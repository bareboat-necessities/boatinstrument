part of 'boatinstrument_controller.dart';

class _EditPage extends StatefulWidget {
  final BoatInstrumentController _controller;
  final _Page _page;
  late final _Page _editPage;

  _EditPage(this._controller, this._page) {
    _editPage = _page.clone();
  }

  @override
  State<_EditPage> createState() => _EditPageState();
}
// TODO need to make these menu names more consistent. Probably move labels into menu list so we can shorten names.
final List<BoxDetails> boxDetails = [
  BoxDetails(BlankBox.sid, 'Blank', (config) {return BlankBox(config, key: UniqueKey());}), // This is the default Box.
  BoxDetails(HelpBox.sid, 'Help', (config) {return HelpBox(config, key: UniqueKey());}),
  BoxDetails(DepthBelowSurfaceBox.sid, 'Depth Below Surface', (config) {return DepthBelowSurfaceBox(config, key: UniqueKey());}),
  BoxDetails(DepthBelowKeelBox.sid, 'Depth Below Keel', (config) {return DepthBelowKeelBox(config, key: UniqueKey());}),
  BoxDetails(DepthBelowTransducerBox.sid, 'Depth Below Transducer', (config) {return DepthBelowTransducerBox(config, key: UniqueKey());}),
  BoxDetails(SpeedThroughWaterBox.sid, 'Speed Through Water', (config) {return SpeedThroughWaterBox(config, key: UniqueKey());}),
  BoxDetails(SpeedOverGroundBox.sid, 'Speed Over Ground', (config) {return SpeedOverGroundBox(config, key: UniqueKey());}),
  BoxDetails(WindSpeedApparentBox.sid, 'Wind Speed Apparent', (config) {return WindSpeedApparentBox(config, key: UniqueKey());}),
  BoxDetails(WindSpeedTrueBox.sid, 'Wind Speed True', (config) {return WindSpeedTrueBox(config, key: UniqueKey());}),
  BoxDetails(WindDirectionTrueBox.sid, 'Wind Direction True', (config) {return WindDirectionTrueBox(config, key: UniqueKey());}),
  BoxDetails(WindRoseBox.sid, 'Wind Rose', gauge: true, (config) {return WindRoseBox(config, key: UniqueKey());}),
  BoxDetails(PositionBox.sid, 'Position', (config) {return PositionBox(config, key: UniqueKey());}),
  BoxDetails(CourseOverGroundBox.sid, 'Course Over Ground', (config) {return CourseOverGroundBox(config, key: UniqueKey());}),
  BoxDetails(WaterTemperatureBox.sid, 'Water Temperature', (config) {return WaterTemperatureBox(config, key: UniqueKey());}),
  BoxDetails(OutsideHumidityBox.sid, 'Outside Humidity', (config) {return OutsideHumidityBox(config, key: UniqueKey());}),
  BoxDetails(InsideHumidityBox.sid, 'Inside Humidity', (config) {return InsideHumidityBox(config, key: UniqueKey());}),
  BoxDetails(AutopilotStatusBox.sid, 'Autopilot Status', (config) {return AutopilotStatusBox(config, key: UniqueKey());}),
  BoxDetails(AutopilotStateControlHorizontalBox.sid, 'AP State Ctrl-H', (config) {return AutopilotStateControlHorizontalBox(config, key: UniqueKey());}),
  BoxDetails(AutopilotStateControlVerticalBox.sid, 'AP State Ctrl-V', (config) {return AutopilotStateControlVerticalBox(config, key: UniqueKey());}),
  BoxDetails(AutopilotHeadingControlHorizontalBox.sid, 'AP Heading Ctrl-H', (config) {return AutopilotHeadingControlHorizontalBox(config, key: UniqueKey());}),
  BoxDetails(AutopilotHeadingControlVerticalBox.sid, 'AP Heading Ctrl-V', (config) {return AutopilotHeadingControlVerticalBox(config, key: UniqueKey());}),
  BoxDetails(WebViewBox.sid, 'Web Page', experimental: true, (config) {return WebViewBox(config, key: UniqueKey());}),
  BoxDetails(RudderAngleBox.sid, 'Rudder Angle', gauge: true, (config) {return RudderAngleBox(config, key: UniqueKey());}),
  BoxDetails(CustomTextBox.sid, 'Text', (config) {return CustomTextBox(config, key: UniqueKey());}),
  BoxDetails(CustomDoubleValueBox.sid, 'Decimal Value', (config) {return CustomDoubleValueBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(CustomDoubleValueSemiGaugeBox.sid, 'Semi Gauge', gauge: true, (config) {return CustomDoubleValueSemiGaugeBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(CustomDoubleValueCircularGaugeBox.sid, 'Circular Gauge', gauge: true, (config) {return CustomDoubleValueCircularGaugeBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(CustomDoubleValueBarGaugeBox.sid, 'Bar Gauge', gauge: true, (config) {return CustomDoubleValueBarGaugeBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(DateTimeBox.sid, 'Date/Time', (config) {return DateTimeBox(config, key: UniqueKey());}),
  BoxDetails(CrossTrackErrorBox.sid, 'Cross Track Error', (config) {return CrossTrackErrorBox(config, key: UniqueKey());}),
  BoxDetails(WindSpeedTrueBeaufortBox.sid, 'Wind True Beaufort', (config) {return WindSpeedTrueBeaufortBox(config, key: UniqueKey());}),
  BoxDetails(SetAndDriftBox.sid, 'Set & Drift', (config) {return SetAndDriftBox(config, key: UniqueKey());}),
  BoxDetails(HeadingBox.sid, 'Heading', (config) {return HeadingBox(config, key: UniqueKey());}),
  BoxDetails(NextPointDistanceBox.sid, 'Next Point Distance', (config) {return NextPointDistanceBox(config, key: UniqueKey());}),
  BoxDetails(NextPointVelocityMadeGoodBox.sid, 'Next Point VMG', (config) {return NextPointVelocityMadeGoodBox(config, key: UniqueKey());}),
  BoxDetails(WaypointTimeToGoBox.sid, 'Next Point TTG', (config) {return WaypointTimeToGoBox(config, key: UniqueKey());}),
  // BoxDetails(RouteTimeToGoBox.sid, 'Route TTG', (config) {return RouteTimeToGoBox(config, key: UniqueKey());}),
  BoxDetails(AttitudeRollGaugeBox.sid, 'Roll', gauge: true, (config) {return AttitudeRollGaugeBox(config, key: UniqueKey());}),
  BoxDetails(CrossTrackErrorDeltaBox.sid, 'XTE Delta', gauge: true, (config) {return CrossTrackErrorDeltaBox(config, key: UniqueKey());}),
  BoxDetails(WindAngleApparentBox.sid, 'Apparent Wind Angle', (config) {return WindAngleApparentBox(config, key: UniqueKey());}),
  BoxDetails(MagneticVariationBox.sid, 'Magnetic Variation', (config) {return MagneticVariationBox(config, key: UniqueKey());}),
  BoxDetails(OutsideTemperatureBox.sid, 'Outside Temperature', (config) {return OutsideTemperatureBox(config, key: UniqueKey());}),
  BoxDetails(OutsidePressureBox.sid, 'Outside Pressure', (config) {return OutsidePressureBox(config, key: UniqueKey());}),
  BoxDetails(SunlightBox.sid, 'Sunlight', (config) {return SunlightBox(config, key: UniqueKey());}),
  BoxDetails(MoonBox.sid, 'Moon', (config) {return MoonBox(config, key: UniqueKey());}),
  BoxDetails(DebugBox.sid, 'Debug', (config) {return DebugBox(config, key: UniqueKey());}),
  BoxDetails(AnchorAlarmBox.sid, 'Anchor Alarm', gauge: true, (config) {return AnchorAlarmBox(config, key: UniqueKey());}),
  BoxDetails(BatteriesBox.sid, 'Batteries', (config) {return BatteriesBox(config, key: UniqueKey());}),
  BoxDetails(BatteryVoltMeterBox.sid, 'Volt Meter', gauge: true, (config) {return BatteryVoltMeterBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(BatteryVoltageBox.sid, 'Battery Voltage', (config) {return BatteryVoltageBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(BatteryCurrentBox.sid, 'Battery Current', (config) {return BatteryCurrentBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(BatteryTemperatureBox.sid, 'Battery Temperature', (config) {return BatteryTemperatureBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(InverterCurrentBox.sid, 'Inverter Current', (config) {return InverterCurrentBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(SolarVoltageBox.sid, 'Solar Voltage', (config) {return SolarVoltageBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(SolarCurrentBox.sid, 'Solar Current', (config) {return SolarCurrentBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(EngineRPMBox.sid, 'Engine RPM', gauge: true, (config) {return EngineRPMBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(EngineTempBox.sid, 'Engine Temp', gauge: true, (config) {return EngineTempBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(EngineExhaustTempBox.sid, 'Engine Exhaust Temp', gauge: true, (config) {return EngineExhaustTempBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(EngineOilPressureBox.sid, 'Engine Oil Pressure', gauge: true, (config) {return EngineOilPressureBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(EngineFuelRateBox.sid, 'Fuel Rate', (config) {return EngineFuelRateBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(TanksBox.sid, 'Tanks', (config) {return TanksBox(config, key: UniqueKey());}),
  BoxDetails(FreshWaterTankBox.sid, 'Fresh Water', gauge: true, (config) {return FreshWaterTankBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(GreyWaterTankBox.sid, 'Grey Water', gauge: true, (config) {return GreyWaterTankBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(BlackWaterTankBox.sid, 'Black Water', gauge: true, (config) {return BlackWaterTankBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(FuelTankBox.sid, 'Fuel', gauge: true, (config) {return FuelTankBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(LubricationTankBox.sid, 'Lubrication', gauge: true, (config) {return LubricationTankBox.fromSettings(config, key: UniqueKey());}),
  BoxDetails(RateOfTurnBox.sid, 'Rate of Turn', (config) {return RateOfTurnBox(config, key: UniqueKey());}),
  BoxDetails(ElectricalSwitchesBox.sid, 'Switches', experimental: true, (config) {return ElectricalSwitchesBox(config, key: UniqueKey());}),
  BoxDetails(ElectricalSwitchBox.sid, 'Switch', experimental: true, (config) {return ElectricalSwitchBox(config, key: UniqueKey());}),
  BoxDetails(TrueWindSpeedGraph.sid, 'Wind Speed True', graph: true, experimental: true, background: (ctrl) {TrueWindSpeedGraphBackground(controller: ctrl);}, (config) {return TrueWindSpeedGraph(config, key: UniqueKey());}),
  BoxDetails(ApparentWindSpeedGraph.sid, 'Wind Speed Apparent', graph: true, experimental: true, background: (ctrl) {ApparentWindSpeedGraphBackground(controller: ctrl);}, (config) {return ApparentWindSpeedGraph(config, key: UniqueKey());}),
  BoxDetails(WaterTemperatureGraph.sid, 'Water Temperature', graph: true, experimental: true, background: (ctrl) {WaterTemperatureGraphBackground(controller: ctrl);}, (config) {return WaterTemperatureGraph(config, key: UniqueKey());}),
  BoxDetails(SpeedThroughWaterGraph.sid, 'Speed Through Water', graph: true, experimental: true, background: (ctrl) {SpeedThroughWaterGraphBackground(controller: ctrl);}, (config) {return SpeedThroughWaterGraph(config, key: UniqueKey());}),
  BoxDetails(SpeedOverGroundGraph.sid, 'Speed Over Ground', graph: true, experimental: true, background: (ctrl) {SpeedOverGroundGraphBackground(controller: ctrl);}, (config) {return SpeedOverGroundGraph(config, key: UniqueKey());}),
  BoxDetails(OutsidePressureGraph.sid, 'Outside Pressure', graph: true, experimental: true, background: (ctrl) {OutsidePressureGraphBackground(controller: ctrl);}, (config) {return OutsidePressureGraph(config, key: UniqueKey());}),
  BoxDetails(OutsideTemperatureGraph.sid, 'Outside Temperature', graph: true, experimental: true, background: (ctrl) {OutsideTemperatureGraphBackground(controller: ctrl);}, (config) {return OutsideTemperatureGraph(config, key: UniqueKey());}),
  BoxDetails(VNCBox.sid, 'VNC', experimental: true, (config) {return VNCBox(config, key: UniqueKey());}),
  BoxDetails(CrossTrackErrorGraph.sid, 'Cross Track Error', graph: true, experimental: true, background: (ctrl) {CrossTrackErrorGraphBackground(controller: ctrl);}, (config) {return CrossTrackErrorGraph(config, key: UniqueKey());}),
  BoxDetails(DepthBelowSurfaceGraph.sid, 'Depth Below Surface', graph: true, experimental: true, background: (ctrl) {DepthBelowSurfaceGraphBackground(controller: ctrl);}, (config) {return DepthBelowSurfaceGraph(config, key: UniqueKey());}),
  BoxDetails(DepthBelowKeelGraph.sid, 'Depth Below Keel', graph: true, experimental: true, background: (ctrl) {DepthBelowKeelGraphBackground(controller: ctrl);}, (config) {return DepthBelowKeelGraph(config, key: UniqueKey());}),
  BoxDetails(DepthBelowTransducerGraph.sid, 'Depth Below Transducer', graph: true, experimental: true, background: (ctrl) {DepthBelowTransducerGraphBackground(controller: ctrl);}, (config) {return DepthBelowTransducerGraph(config, key: UniqueKey());}),
  BoxDetails(RPiCPUTemperatureBox.sid, 'RPi CPU Temperature', (config) {return RPiCPUTemperatureBox(config, key: UniqueKey());}),
  BoxDetails(RPiGPUTemperatureBox.sid, 'RPi GPU Temperature', (config) {return RPiGPUTemperatureBox(config, key: UniqueKey());}),
  BoxDetails(RPiCPUUtilisationBox.sid, 'RPi CPU Utilisation', gauge: true, (config) {return RPiCPUUtilisationBox(config, key: UniqueKey());}),
  BoxDetails(RPiMemoryUtilisationBox.sid, 'RPi Memory Utilisation', gauge: true, (config) {return RPiMemoryUtilisationBox(config, key: UniqueKey());}),
  BoxDetails(RPiSDUtilisationBox.sid, 'RPi SD Utilisation', gauge: true, (config) {return RPiSDUtilisationBox(config, key: UniqueKey());}),
  BoxDetails(RaspberryPiBox.sid, 'Raspberry Pi', experimental: true, (config) {return RaspberryPiBox(config, key: UniqueKey());}),
  BoxDetails(BatteryPowerGraph.sid, 'Power Usage', graph: true, experimental: true, background: (ctrl) {BatteryPowerGraphBackground(controller: ctrl);}, (config) {return BatteryPowerGraph(config, key: UniqueKey());}),
  BoxDetails(SolarPowerGraph.sid, 'Solar Power', graph: true, experimental: true, background: (ctrl) {SolarPowerGraphBackground(controller: ctrl);}, (config) {return SolarPowerGraph(config, key: UniqueKey());}),
];

class _EditPageState extends State<_EditPage> {

  PopupMenuItem<BoxDetails> _widgetMenuEntry(String id) {
    BoxDetails bd = getBoxDetails(id);
    List<Widget> c = [Text(bd.description)];
    if(bd.gauge) {
      c.add(const Icon(Icons.speed));
    }
    if(bd.graph) {
      c.add(const Icon(Icons.show_chart));
    }
    if(bd.experimental) {
      c.add(const Icon(Icons.science_outlined));
    }

    return PopupMenuItem<BoxDetails>(enabled: !bd.experimental || widget._controller.enableExperimentalBoxes, value: bd, child: Row(children: c));
  }

  PopupMenuItem<BoxDetails> _widgetSubMenuEntry(_Box box, String text, List<PopupMenuEntry<BoxDetails>> subMenuEntries) {
    return PopupMenuItem(child: PopupMenuButton<BoxDetails>(
      tooltip: '',
      shape: Border.all(color: Colors.grey),
      itemBuilder: (context) {
        return subMenuEntries;
      },
      onSelected: (value) {
        setState(() {
          box.id = value.id;
          box.settings = {};
          Navigator.pop(context);
        });
      },
      child: ListTile(title: Text(text), trailing: const Icon(Icons.arrow_right)),
    ));
  }

  _getWidgetMenus(_Box box) {
    List<PopupMenuEntry<BoxDetails>> popupMenuEntries = [
      _widgetMenuEntry(BlankBox.sid),
      _widgetSubMenuEntry(box, 'Environment', [
        _widgetMenuEntry(DepthBelowSurfaceBox.sid),
        _widgetMenuEntry(DepthBelowSurfaceGraph.sid),
        _widgetMenuEntry(DepthBelowKeelBox.sid),
        _widgetMenuEntry(DepthBelowKeelGraph.sid),
        _widgetMenuEntry(DepthBelowTransducerBox.sid),
        _widgetMenuEntry(DepthBelowTransducerGraph.sid),
        _widgetMenuEntry(SetAndDriftBox.sid),
        _widgetMenuEntry(WaterTemperatureBox.sid),
        _widgetMenuEntry(WaterTemperatureGraph.sid),
        _widgetMenuEntry(OutsideTemperatureBox.sid),
        _widgetMenuEntry(OutsideTemperatureGraph.sid),
        _widgetMenuEntry(OutsidePressureBox.sid),
        _widgetMenuEntry(OutsidePressureGraph.sid),
        _widgetMenuEntry(OutsideHumidityBox.sid),
        _widgetMenuEntry(InsideHumidityBox.sid),
        _widgetMenuEntry(SunlightBox.sid),
        _widgetMenuEntry(MoonBox.sid),
      ]),
      _widgetSubMenuEntry(box, 'Navigation', [
        _widgetMenuEntry(CourseOverGroundBox.sid),
        _widgetMenuEntry(SpeedOverGroundBox.sid),
        _widgetMenuEntry(SpeedOverGroundGraph.sid),
        _widgetMenuEntry(HeadingBox.sid),
        _widgetMenuEntry(NextPointDistanceBox.sid),
        _widgetMenuEntry(NextPointVelocityMadeGoodBox.sid),
        _widgetMenuEntry(WaypointTimeToGoBox.sid),
        // _widgetMenuEntry(RouteTimeToGoBox.sid),
        _widgetMenuEntry(CrossTrackErrorBox.sid),
        _widgetMenuEntry(CrossTrackErrorGraph.sid),
        _widgetMenuEntry(CrossTrackErrorDeltaBox.sid),
        _widgetMenuEntry(PositionBox.sid),
        _widgetMenuEntry(RateOfTurnBox.sid),
        _widgetMenuEntry(MagneticVariationBox.sid),
      ]),
      _widgetSubMenuEntry(box, 'Boat', [
        _widgetMenuEntry(SpeedThroughWaterBox.sid),
        _widgetMenuEntry(SpeedThroughWaterGraph.sid),
        _widgetMenuEntry(RudderAngleBox.sid),
        _widgetMenuEntry(AttitudeRollGaugeBox.sid),
      ]),
      _widgetSubMenuEntry(box, 'Wind', [
        _widgetMenuEntry(WindSpeedApparentBox.sid),
        _widgetMenuEntry(ApparentWindSpeedGraph.sid),
        _widgetMenuEntry(WindAngleApparentBox.sid),
        _widgetMenuEntry(WindSpeedTrueBox.sid),
        _widgetMenuEntry(TrueWindSpeedGraph.sid),
        _widgetMenuEntry(WindDirectionTrueBox.sid),
        _widgetMenuEntry(WindSpeedTrueBeaufortBox.sid),
        _widgetMenuEntry(WindRoseBox.sid),
      ]),
      _widgetSubMenuEntry(box, 'Autopilot', [
        _widgetMenuEntry(AutopilotStatusBox.sid),
        _widgetMenuEntry(AutopilotStateControlHorizontalBox.sid),
        _widgetMenuEntry(AutopilotStateControlVerticalBox.sid),
        _widgetMenuEntry(AutopilotHeadingControlHorizontalBox.sid),
        _widgetMenuEntry(AutopilotHeadingControlVerticalBox.sid),
      ]),
      _widgetSubMenuEntry(box, 'Electrical', [
        _widgetMenuEntry(BatteriesBox.sid),
        _widgetMenuEntry(BatteryPowerGraph.sid),
        _widgetMenuEntry(BatteryVoltMeterBox.sid),
        _widgetMenuEntry(BatteryVoltageBox.sid),
        _widgetMenuEntry(BatteryCurrentBox.sid),
        _widgetMenuEntry(BatteryTemperatureBox.sid),
        _widgetMenuEntry(InverterCurrentBox.sid),
        _widgetMenuEntry(SolarVoltageBox.sid),
        _widgetMenuEntry(SolarCurrentBox.sid),
        _widgetMenuEntry(SolarPowerGraph.sid),
        _widgetMenuEntry(ElectricalSwitchesBox.sid),
        _widgetMenuEntry(ElectricalSwitchBox.sid),
      ]),
      _widgetSubMenuEntry(box, 'Tanks', [
        _widgetMenuEntry(TanksBox.sid),
        _widgetMenuEntry(FreshWaterTankBox.sid),
        _widgetMenuEntry(GreyWaterTankBox.sid),
        _widgetMenuEntry(BlackWaterTankBox.sid),
        _widgetMenuEntry(FuelTankBox.sid),
        _widgetMenuEntry(LubricationTankBox.sid),
      ]),
      _widgetSubMenuEntry(box, 'Engine', [
        _widgetMenuEntry(EngineRPMBox.sid),
        _widgetMenuEntry(EngineTempBox.sid),
        _widgetMenuEntry(EngineOilPressureBox.sid),
        _widgetMenuEntry(EngineExhaustTempBox.sid),
        _widgetMenuEntry(EngineFuelRateBox.sid),
      ]),
      _widgetSubMenuEntry(box, 'Raspberry Pi', [
        _widgetMenuEntry(RPiCPUTemperatureBox.sid),
        _widgetMenuEntry(RPiGPUTemperatureBox.sid),
        _widgetMenuEntry(RPiCPUUtilisationBox.sid),
        _widgetMenuEntry(RPiMemoryUtilisationBox.sid),
        _widgetMenuEntry(RPiSDUtilisationBox.sid),
        _widgetMenuEntry(RaspberryPiBox.sid),
      ]),
      _widgetMenuEntry(DateTimeBox.sid),
      _widgetMenuEntry(AnchorAlarmBox.sid),
      _widgetMenuEntry(WebViewBox.sid),
      _widgetMenuEntry(VNCBox.sid),
      _widgetSubMenuEntry(box, 'Custom', [
        _widgetMenuEntry(CustomTextBox.sid),
        _widgetMenuEntry(CustomDoubleValueBox.sid),
        _widgetMenuEntry(CustomDoubleValueSemiGaugeBox.sid),
        _widgetMenuEntry(CustomDoubleValueCircularGaugeBox.sid),
        _widgetMenuEntry(CustomDoubleValueBarGaugeBox.sid),
        _widgetMenuEntry(DebugBox.sid),
      ]),
    ];

    return popupMenuEntries;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pageRows = [];
    List<double> pageRowsPercent = [];

    for(int pri = 0; pri < widget._editPage.pageRows.length; ++pri) {
      _PageRow pageRow = widget._editPage.pageRows[pri];

      List<Widget> columns = [];
      List<double> columnsPercent = [];

      for(int ci = 0; ci < pageRow.columns.length; ++ci) {
        _Column column = pageRow.columns[ci];

        List<Widget> rows = [];
        List<double> rowsPercent = [];

        for (int ri = 0; ri < column.rows.length; ++ri) {
          _Row row = column.rows[ri];

          List<Widget> boxes = [];
          List<double> boxesPercent = [];

          for (int bi = 0; bi < row.boxes.length; ++bi) {
            _Box box = row.boxes[bi];

            List<Widget> nButtons = [];
            List<Widget> sButtons = [];
            List<Widget> eButtons = [];
            List<Widget> wButtons = [];

            wButtons.add(IconButton(tooltip: 'Box Before', onPressed: () {_addBox(row, bi);}, icon: const Icon(Icons.arrow_circle_left_outlined, color: Colors.blue)));

            if(bi == 0 && ri == 0 && ci == 0) {
              nButtons.add(IconButton(tooltip: 'Page Row Above', onPressed: () {_addPageRow(widget._editPage, pri);}, icon: const Icon(Icons.arrow_circle_up_outlined, color: Colors.red)));
            }

            if(bi == 0 && ri == 0) {
              wButtons.add(IconButton(tooltip: 'Column Before', onPressed: () {_addColumn(pageRow, ci);}, icon: const Icon(Icons.arrow_circle_left_outlined, color: Colors.orange)));
            }

            if(bi == 0) {
              nButtons.add(IconButton(tooltip: 'Row Above', onPressed: () {_addRow(column, ri);}, icon: const Icon(Icons.arrow_circle_up_outlined, color: Colors.yellow)));
            }

            if(bi == row.boxes.length-1) {
              eButtons.add(IconButton(tooltip: 'Box After', onPressed: () {_addBox(row, bi, after: true);}, icon: const Icon(Icons.arrow_circle_right_outlined, color: Colors.blue)));
            }

            if(pri == (widget._editPage.pageRows.length-1) && ci == 0 && ri == (column.rows.length-1) && bi == 0) {
              sButtons.add(IconButton(tooltip: 'Page Row Below', onPressed: () {_addPageRow(widget._editPage, pri, after: true);}, icon: const Icon(Icons.arrow_circle_down_outlined, color: Colors.red)));
            }

            if(ci == pageRow.columns.length-1 && ri == 0 && bi == row.boxes.length-1) {
              eButtons.add(IconButton(tooltip: 'Column After', onPressed: () {_addColumn(pageRow, ci, after: true);}, icon: const Icon(Icons.arrow_circle_right_outlined, color: Colors.orange)));
            }

            if(ri == column.rows.length-1 && bi == 0) {
              sButtons.add(IconButton(tooltip: 'Row Below', onPressed: () {_addRow(column, ri, after: true);}, icon: const Icon(Icons.arrow_circle_down_outlined, color: Colors.yellow)));
            }

            LayoutBuilder layoutBoxWidget = LayoutBuilder(builder: (context, constraints) {
              return getBoxDetails(box.id).build(BoxWidgetConfig(widget._controller, box.settings, constraints, true));
            });

            PopupMenuButton boxWidgetMenu = PopupMenuButton(
              icon: const Icon(Icons.list, color: Colors.blue),
              tooltip: 'Box Type',
              shape: Border.all(color: Colors.grey),
              itemBuilder: (BuildContext context) {
                return _getWidgetMenus(box);
              },
              onSelected: (value) {
                setState(() {
                  box.id = (value as BoxDetails).id;
                });
              },
            );

            List<Widget> stack = [
              layoutBoxWidget
            ];

            BoxWidget editBoxWidget = getBoxDetails(box.id).build(BoxWidgetConfig(widget._controller, box.settings, const BoxConstraints(maxWidth: 1.0, maxHeight: 1.0), true));

            List<Widget> settingsButtons = [];
            Widget? helpWidget = editBoxWidget.getHelp(context);
            if(helpWidget != null) {
              settingsButtons.add(IconButton(onPressed: () {_showHelpPage(helpWidget);}, icon: const Icon(Icons.help)));
            }

            if(editBoxWidget.hasSettings) {
              settingsButtons.add(IconButton(tooltip: 'Settings', onPressed: () {_showSettingsPage(editBoxWidget);}, icon: const Icon(Icons.settings)));
            }
            if(editBoxWidget.hasPerBoxSettings) {
              settingsButtons.add(IconButton(tooltip: 'Box Settings', onPressed: () {_showPerBoxSettingsPage(editBoxWidget, pri, ci, ri, bi);}, icon: const Icon(Icons.settings, color: Colors.blue)));
            }

            stack.addAll([
              Positioned(top: 0, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: nButtons)),
              Positioned(bottom: 0, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: sButtons)),
              Positioned(right: 0, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: eButtons)),
              Positioned(left: 0, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: wButtons)),
              Positioned(top: 0, right: 0, child: Row(children: settingsButtons)),
              Positioned(bottom: 0, left: 0, child: IconButton(tooltip: 'Delete Box', onPressed: () {_deleteBox(pri, ci, ri, bi);}, icon: const Icon(Icons.delete, color: Colors.blue))),
              boxWidgetMenu
            ]);
            boxes.add(Stack(alignment: Alignment.center, children: stack));

            boxesPercent.add(box.percentage);
          }

          rows.add(ResizableWidget(onResized: (infoList) {_onResize(infoList, row.boxes);}, isHorizontalSeparator: false, separatorColor: Colors.blue, separatorSize: 16, percentages: boxesPercent, children: boxes));
          rowsPercent.add(row.percentage);
        }

        columns.add(ResizableWidget(onResized: (infoList) {_onResize(infoList, column.rows);}, isHorizontalSeparator: true, separatorColor: Colors.yellow, separatorSize: 16, percentages: rowsPercent, children: rows));
        columnsPercent.add(column.percentage);
      }

      pageRows.add(ResizableWidget(onResized: (infoList) {_onResize(infoList, pageRow.columns);}, isHorizontalSeparator: false, separatorColor: Colors.orange, separatorSize: 16, percentages: columnsPercent, children: columns));
      pageRowsPercent.add(pageRow.percentage);
    }

    return Scaffold(
      body: SafeArea(child: ResizableWidget(key: UniqueKey(), onResized: (infoList) {_onResize(infoList, widget._editPage.pageRows);}, isHorizontalSeparator: true, separatorColor: Colors.red, separatorSize: 16, percentages: pageRowsPercent, children: pageRows)),
      floatingActionButton: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        IconButton(icon: const Icon(Icons.save), onPressed: _save),
        IconButton(icon: const Icon(Icons.close), onPressed: _close)
      ])
    );
  }

  void _onResize(List<WidgetSizeInfo> infoList, List<_Resizable> r) {
    assert(infoList.length == r.length);

    // To deal with rounding errors, we always make the last percentage what's remaining.
    double total = 0;
    int i;
    for(i = 0; i < infoList.length-1; ++i) {
      r[i].percentage = infoList[i].percentage;
      total += infoList[i].percentage;
    }
    r[i].percentage = 1.0 - total;
  }

  // We need this to adjust for rounding errors.
  static double _diff(List<_Resizable> list) {
    double tot = 0;
    for(_Resizable r in list) {
      tot += r.percentage;
    }
    return 1.0 - tot;
  }

  void _addBox(_Row r, int bi, {bool after = false}) {
    setState(() {
      _Box b = _Box.blank();
      double pc = r.boxes[bi].percentage / 2;
      r.boxes[bi].percentage = pc;
      b.percentage = pc;
      r.boxes.insert(after ? bi+1 : bi, b);
      b.percentage += _diff(r.boxes);
    });
  }

  void _addRow(_Column c, int ri, {bool after = false}) {
    setState(() {
      _Row r = _Row([_Box.blank()], 1);
      double pc = c.rows[ri].percentage / 2;
      c.rows[ri].percentage = pc;
      r.percentage = pc;
      c.rows.insert(after ? ri+1 : ri, r);
      r.percentage += _diff(c.rows);
    });
  }

  void _addColumn(_PageRow pr, int ci, {bool after = false}) {
    setState(() {
      _Column c = _Column([_Row([_Box.blank()], 1)], 1);
      double pc = pr.columns[ci].percentage / 2;
      pr.columns[ci].percentage = pc;
      c.percentage = pc;
      pr.columns.insert(after ? ci+1 : ci, c);
      c.percentage += _diff(pr.columns);
    });
  }

  void _addPageRow(_Page p, int pri, {bool after = false}) {
    setState(() {
      _PageRow pr = _PageRow([_Column([_Row([_Box.blank()], 1)], 1)], 1);
      double ppr = p.pageRows[pri].percentage / 2;
      p.pageRows[pri].percentage = ppr;
      pr.percentage = ppr;
      p.pageRows.insert(after ? pri+1 : pri, pr);
      pr.percentage += _diff(p.pageRows);
    });
  }

  void _deleteBox(int pri, int ci, int ri, int bi) {
    _Page page = widget._editPage;

    setState(() {
      _Box b = page.pageRows[pri].columns[ci].rows[ri].boxes[bi];
      page.pageRows[pri].columns[ci].rows[ri].boxes.removeAt(bi);
      if(page.pageRows[pri].columns[ci].rows[ri].boxes.isNotEmpty) {
        if(bi >= page.pageRows[pri].columns[ci].rows[ri].boxes.length) {
          --bi;
        }
        page.pageRows[pri].columns[ci].rows[ri].boxes[bi].percentage += b.percentage;
      } else {
        _Row r = page.pageRows[pri].columns[ci].rows[ri];
        page.pageRows[pri].columns[ci].rows.removeAt(ri);
        if(page.pageRows[pri].columns[ci].rows.isNotEmpty) {
          if(ri >= page.pageRows[pri].columns[ci].rows.length) {
            --ri;
          }
          page.pageRows[pri].columns[ci].rows[ri].percentage += r.percentage;
        } else {
          _Column c = page.pageRows[pri].columns[ci];
          page.pageRows[pri].columns.removeAt(ci);
          if(page.pageRows[pri].columns.isNotEmpty) {
            if(ci >= page.pageRows[pri].columns.length) {
              --ci;
            }
            page.pageRows[pri].columns[ci].percentage += c.percentage;
          } else {
            _PageRow pr = page.pageRows[pri];
            page.pageRows.removeAt(pri);
            if(page.pageRows.isNotEmpty) {
              if(pri >= page.pageRows.length) {
                --pri;
              }
              page.pageRows[pri].percentage += pr.percentage;
            } else {
              // Need to have one Box for the current screen.
              page.pageRows = [_PageRow([_Column([_Row([_Box.blank()], 1.0)], 1.0)], 1)];
          }
        }
      }
      }
    });
  }

  void _save() {
    widget._page.pageRows = widget._editPage.pageRows;
    widget._controller.save();
    _close();
  }

  void _close() {
    Navigator.pop(context);
  }

  _showSettingsPage (BoxWidget boxWidget) async {
    BoxSettingsWidget boxSettingsWidget =  boxWidget.getSettingsWidget(widget._controller.getBoxSettingsJson(boxWidget.id))!;

    await Navigator.push(
        context, MaterialPageRoute(builder: (context) {
          return _BoxSettingsPage(
              boxSettingsWidget,
              boxWidget.getSettingsHelp()
          );
        })
    );

    widget._controller._settings?.boxSettings[boxWidget.id] = boxSettingsWidget.getSettingsJson();

    setState(() {});
  }

  _showPerBoxSettingsPage (BoxWidget boxWidget, int pri, int ci, ri, bi) async {
    BoxSettingsWidget boxSettingsWidget = boxWidget.getPerBoxSettingsWidget()!;
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) {
      return _BoxSettingsPage(boxSettingsWidget, boxWidget.getPerBoxSettingsHelp());
    }));

    widget._editPage.pageRows[pri].columns[ci].rows[ri].boxes[bi].settings = boxSettingsWidget.getSettingsJson();

    setState(() {});
  }

  _showHelpPage (Widget helpWidget) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) {
      return _BoxHelpPage(helpWidget);
    }));
  }

}

class _BoxSettingsPage extends StatefulWidget {
  final Widget _settingsWidget;
  final Widget? _helpWidget;

  const _BoxSettingsPage(this._settingsWidget, this._helpWidget);

  @override
  createState() => _BoxSettingsState();
}

class _BoxSettingsState extends State<_BoxSettingsPage> {

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];
    if (widget._helpWidget != null) {
      actions.add(IconButton(onPressed: _showHelpPage, icon: const Icon(Icons.help)));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          actions: actions,
        ),
        body: widget._settingsWidget
    );
  }

  _showHelpPage () async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) {
      return _BoxHelpPage(widget._helpWidget!);
    }));
  }
}

class _BoxHelpPage extends StatefulWidget {
  final Widget _helpWidget;

  const _BoxHelpPage(this._helpWidget);

  @override
  createState() => _BoxHelpState();
}

class _BoxHelpState extends State<_BoxHelpPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Help'),
        ),
        body: widget._helpWidget,
    );
  }
}
