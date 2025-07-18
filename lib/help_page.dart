part of 'boatinstrument_controller.dart';

class _HelpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<ListTile> list = [
      ListTile(title: RichText(text: TextSpan(style: Theme.of(context).textTheme.bodyMedium, children: const [
        TextSpan(text: '''The display shows a number of Pages and swiping left/right moves between them. Swiping down and selecting '''),
        WidgetSpan(child: Icon(Icons.web)),
        TextSpan(text: ''' shows the list of Pages. Press the '''),
        WidgetSpan(child: Icon(Icons.edit)),
        TextSpan(text: ''' button to edit a Page. Each Page is made up of multiple Page Rows (Red), containing multiple Columns (Orange), containing multiple Rows (Yellow), containing multiple Boxes (Blue). Use the coloured arrows to add Page elements.

Hint: sometimes you may need to temporarily resize a Box to show all the buttons.

The contents of each Box is selected through the '''),
        WidgetSpan(child: Icon(Icons.list, color: Colors.blue)),
        TextSpan(text: ''' button. If the Box has settings these are set through the '''),
        WidgetSpan(child: Icon(Icons.settings)),
        TextSpan(text: ''' buttons in the top right of the Box. The Blue button sets the Per-Box settings and the White/Black button sets the Box Type settings that are shared between all instances of the Box. Boxes containing dial or other controls are marked '''),
        WidgetSpan(child: Icon(Icons.speed)),
        TextSpan(text: ''' and Graphs marked '''),
        WidgetSpan(child: Icon(Icons.show_chart)),
        TextSpan(text: '''. The sizes of the Page elements can be adjusted by dragging the coloured Box borders. If the last Box in a Row or Column is deleted, the Row or Column is also deleted.

Whilst in "Edit Mode" dummy values are shown, usually the value "12.3". This allows you to gauge what the Boxes will look like when running.

Swiping up or pressing the back button hides the top bar.

For "Auto Discovery" of your SignalK server, mDNS must be turned on in your server's settings. If discovery does not work, enter your server's URL.

The "Subscription Min Period" is the minimum time between data updates. Increasing this value will reduce the load on your SignalK server.

If no data is received within the "Connection Timeout" the connection is reopened.

If a Box receives no data within the "Data Timeout" the box is cleared and a "-" is generally displayed.

You can set additional HTTP Headers if the connection to the SignalK server requires them, e.g. for proxies.

Notifications sent from SignalK are displayed at the bottom of the app, with appropriate sounds if requested by the server. If repeat notifications are sent with the same severity, then the number displayed for normal/nominal is 1, alert is 5, warn is 10, alarm is 20 and emergency is 30.

In "Demo Mode" the app connects to "https://demo.signalk.org".

Boxes marked '''),
        WidgetSpan(child: Icon(Icons.science_outlined)),
        TextSpan(text: ''' are experimental and may not function as expected, but any feedback will be gratefully received. You must enable Experimental Boxes in the Advanced Settings.
        
If setting time is enabled via the "--enable-set-time" command line option and "Set Time" is enabled in the Advanced Settings, then "sudo" will be used to set the time from "navigation.datetime".'''),
      ]))),
      const ListTile(leading: Icon(Icons.mode_night), title: Text('Enables/Disables Night Mode')),
      const ListTile(leading: Icon(Icons.fullscreen), title: Text('Enables/Disables Full Screen')),
      const ListTile(leading: Icon(Icons.brightness_high), title: Text('Cycles the brightness on supported platforms')),
      const ListTile(leading: Icon(Icons.sync_alt), title: Text('Toggles the Auto-Page rotation. Set the per-page delays in the page list. Pages without delays are not shown')),
      const ListTile(leading: Icon(Icons.format_list_bulleted), title: Text('Shows the notification log')),
      const ListTile(leading: Icon(Icons.volume_off), title: Text('Unmutes notifications')),
      const ListTile(leading: Icon(Icons.copy), title: Text('Copy/Clone a Page')),
      const ListTile(leading: Icon(Icons.drag_handle), title: Text('Drag handle for reordering pages')),
      const ListTile(leading: Icon(Icons.share), title: Text('Shares/Exports the Settings')),
      const ListTile(leading: Icon(Icons.file_open), title: Text('Imports Settings from a file')),
      const ListTile(leading: Icon(Icons.mediation), title: Text('Show the current SignalK Subscriptions')),
      const ListTile(leading: Icon(Icons.notes), title: Text('Shows the message/error log')),
      const ListTile(leading: Icon(Icons.change_history), title: Text('Shows the change log')),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
        actions: [
          IconButton(tooltip: 'Change Log', icon: const Icon(Icons.change_history),onPressed: () {_showChangeLog(context);})
        ],
      ),
      body: ListView(children: list)
    );
  }

  void _showChangeLog (BuildContext context) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) {
      return const ChangeLogPage();
    }));
  }
}
