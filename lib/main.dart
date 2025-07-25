import 'dart:async';
import 'dart:io';
import 'dart:math' as m;

import 'package:actions_menu_appbar/actions_menu_appbar.dart';
import 'package:args/args.dart';
import 'package:boatinstrument/log_display.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:boatinstrument/boatinstrument_controller.dart';
import 'package:flutter_fullscreen/flutter_fullscreen.dart';
import 'package:provider/provider.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'theme_provider.dart';

void main(List<String> cmdlineArgs) {
  List<String> args = (Platform.environment['BOAT_INSTRUMENT_ARGS']??'').split(RegExp(r'\s+')) + cmdlineArgs;

  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(ChangeNotifierProvider(create: (context) => ThemeProvider(), child: BoatInstrumentApp(args)));
}

class BoatInstrumentApp extends StatelessWidget {
  final List<String> args;

  const BoatInstrumentApp(this.args, {super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    const noAudio = 'no-audio';
    const noBrightnessCtrl = 'no-brightness-ctrl';
    const noKeepAwake = 'no-keep-awake';
    const noFullScreen = 'no-full-screen';
    const readOnly = 'read-only';
    const enableExit = 'enable-exit';
    const enableSetTime = 'enable-set-time';
    const configFile = 'config-file';

    final p = ArgParser()
                ..addFlag(noAudio, negatable: false)
                ..addFlag(noBrightnessCtrl, negatable: false)
                ..addFlag(noKeepAwake, negatable: false)
                ..addFlag(noFullScreen, negatable: false)
                ..addFlag(readOnly, negatable: false)
                ..addFlag(enableExit, negatable: false)
                ..addFlag(enableSetTime, negatable: false)
                ..addOption(configFile,
                    defaultsTo: 'boatinstrument.json',
                    valueHelp: 'filename',
                    help: 'If the <filename> does not start with a "/", it is appended to the default directory');

    try {
      ArgResults r = p.parse(args);
      if(r.rest.length > 1) {
        throw const FormatException('Too many command line arguments given.');
      }

      return MaterialApp(
        home: MainPage(
          r.flag(noAudio),
          r.flag(noBrightnessCtrl),
          r.flag(noKeepAwake),
          r.flag(noFullScreen),
          r.flag(readOnly),
          r.flag(enableExit),
          r.flag(enableSetTime),
          r.option(configFile)!),
        theme:  Provider.of<ThemeProvider>(context).themeData
      );
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('Usage: boatinstrument ${p.usage}');
      exit(1);
    } 
  }
}

class MainPage extends StatefulWidget {
  final bool noAudio;
  final bool noBrightnessControl;
  final bool noKeepAwake;
  final bool noFullScreen;
  final bool readOnly;
  final bool enableExit;
  final bool enableSetTime;
  final String configFile;

  const MainPage(
    this.noAudio,
    this.noBrightnessControl,
    this.noKeepAwake,
    this.noFullScreen,
    this.readOnly,
    this.enableExit,
    this.enableSetTime,
    this.configFile,
    {super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const Image _icon = Image(image: AssetImage('assets/icon.png'));

  late final ThemeProvider _themeProvider;
  static const _brightnessStep = 4;
  static const _brightnessMax = 12;
  static final Map<int, IconData> _brightnessIcons = {
    12: Icons.brightness_high,
    8: Icons.brightness_medium,
    4: Icons.brightness_low,
    1: Icons.brightness_4_outlined,
    0: Icons.brightness_4_outlined
  };

  bool _showAppBar = false;
  int _brightness = _brightnessMax;
  bool _rotatePages = false;
  Timer? _pageTimer;
  Offset _panStart = Offset.zero;
  bool fullScreen = (Platform.isIOS || Platform.isAndroid) ? true : false;

  late final BoatInstrumentController _controller;
  int _pageNum = 0;
  int? _pageTimeout = 0;

  @override
  void initState() {
    super.initState();

    _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _controller = BoatInstrumentController(widget.noAudio, widget.noBrightnessControl, widget.enableExit, widget.enableSetTime);
  }

  Future<void> _configure () async {
    if(!widget.noFullScreen) await FullScreen.ensureInitialized();
    await _controller.loadSettings(widget.configFile, MediaQuery.of(context).orientation == Orientation.portrait);
    await _controller.connect();

    _themeProvider.setDarkMode(_controller.darkMode);

    if(_controller.brightnessControl) {
      // Convert the current system brightness into the closest step, rounding up.
      // Note: We add the step as well as _setBrightness() will remove it.
      _brightness = (await ScreenBrightness().system * _brightnessMax).ceil();
      _brightness =
          _brightness - (_brightness % _brightnessStep) + (_brightnessStep * 2);
      _setBrightness();
    }

    if(_controller.pageTimerOnStart) {
      _togglePageTimer();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if(!_controller.ready) {
      _configure();
      return const Center(child: _icon);
    }

    if(!widget.noKeepAwake) {
      WakelockPlus.toggle(enable: _controller.keepAwake);
    }

    ActionsMenuAppBar? appBar;
    if(_showAppBar) {
      appBar = ActionsMenuAppBar(
        actionsPercent: 0.5,
        context: context,
        leading: BackButton(onPressed: () {setState(() {_showAppBar = false;});}),
        title: Text(_controller.pageName(_pageNum)),
        actions: [
          if(!widget.noFullScreen) IconButton(tooltip: '${fullScreen ? 'Exit ':''}Full Screen', icon: Icon(fullScreen ? Icons.fullscreen_exit : Icons.fullscreen), onPressed: _toggleFullScreen),
          if(_controller.muted) IconButton(tooltip: 'Unmute', icon: const Icon(Icons.volume_off), onPressed: _unmute),
          IconButton(tooltip: 'Night Mode', icon: const Icon(Icons.mode_night), onPressed:  _nightMode),
          IconButton(tooltip: 'Auto Page', icon: _rotatePages ? const Icon(Icons.sync_alt) : const Stack(children: [Icon(Icons.sync_alt), Icon(Icons.close)]), onPressed:  _togglePageTimer),
          if(_controller.brightnessControl) IconButton(tooltip: 'Brightness', icon: Icon(_brightnessIcons[_brightness]), onPressed: _setBrightness),
          if(_controller.notifications.isNotEmpty) IconButton(tooltip: 'Notifications', icon: Icon(Icons.format_list_bulleted), onPressed: _showNotifications),
          if(!widget.readOnly) IconButton(tooltip: 'Edit Pages', icon: const Icon(Icons.web), onPressed: _showEditPagesPage),
          if(widget.readOnly) IconButton(tooltip: 'Log', icon: const Icon(Icons.notes),onPressed: () {LogDisplay.show(context);})
        ]
      );
    }

    return Scaffold(
      appBar: appBar,
      body: SafeArea(child: GestureDetector(
        onPanStart: (details) {
          _panStart = details.localPosition;
        },
        onPanEnd: (details) {
          Offset diff = details.localPosition - _panStart;
          double max = m.max(diff.dx.abs(), diff.dy.abs());
          if(max < 100) {
            return;
          }
          if(diff.dx.abs() > diff.dy.abs()) {
            _movePage(diff.dx);
          } else {
            _displayAppBar(diff.dy);
          }
        },
        child: _controller.buildPage(_pageNum),
      )),
    );
  }

  void _setBrightness() {
    setState(() {
      _brightness = ((_brightness < _brightnessStep) || (_brightness > _brightnessMax)) ? _brightnessMax : _brightness - _brightnessStep;
      if(Platform.isMacOS && _brightness == 0) {
        _brightness = 1;
      }
    });

    ScreenBrightness().setApplicationScreenBrightness(_brightness/_brightnessMax);
  }

  void _nightMode() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.toggleNightMode(_controller.darkMode);
  }

  void _unmute() {
    setState(() {
      _controller.unmute();
    });
  }
  
  void _toggleFullScreen() {
    setState(() {
      fullScreen = !fullScreen;
      FullScreen.setFullScreen(fullScreen);
    });
  }

  void _togglePageTimer() {
    setState(() {
      _rotatePages = !_rotatePages;
    });

    if(_rotatePages) {
      // Initially get it going.
      _pageTimeout = _pageTimeout??0;
    }

    _startPageTimer();
  }

  void _startPageTimer() {
    _stopPageTimer();

    if(_pageTimeout == null) {
      _rotatePages = false;
    }

    if(_rotatePages) {
      _pageTimer = Timer(Duration(seconds: _pageTimeout!), _rotatePage);
    }
  }

  void _stopPageTimer() {
    _pageTimer?.cancel();
    _pageTimer = null;
  }

  void _rotatePage() {
    int pageNum;
    int? timeout;
    setState(() {
      (pageNum, timeout) = _controller.rotatePageNum(_pageNum);
      _pageNum = pageNum;
      _pageTimeout = timeout;
    });

    _startPageTimer();
  }

  void _showNotifications () async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) {
      return NotificationLogDisplay(_controller.notifications);
    }));

    setState(() {
      _showAppBar = false;
    });
  }

  Future<void> _showEditPagesPage () async {
    _stopPageTimer();

    await Navigator.push(
        context, MaterialPageRoute(builder: (context) {
      return EditPagesPage(_controller);
    }));

    _controller.save();

    _controller.connect();

    setState(() {
      _showAppBar = false;
      if(_pageNum >= _controller.numOfPages) {
        _pageNum = _controller.numOfPages-1;
      }
    });

    _startPageTimer();
  }

  void _movePage (double direction) {
    _startPageTimer();

    int newPage = 0;
    if (direction > 0.0) {
      newPage = _controller.prevPageNum(_pageNum);
    } else {
      newPage = _controller.nextPageNum(_pageNum);
    }
    if(newPage != _pageNum) {
      setState(() {
        _pageNum = newPage;
      });
    }
  }

  void _displayAppBar (double direction) async {
    _startPageTimer();

    bool showAppBar = false;
    if(direction > 0.0) {
      showAppBar = true;
    }

    if(_showAppBar != showAppBar) {
      setState(() {
        _showAppBar = showAppBar;
      });
    }
  }
}
