import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import './views/tracking.dart';
import './views/schedule.dart';
import './views/links.dart';
import './views/settings.dart';

final darkTheme =
    ThemeData(brightness: Brightness.dark, primaryColor: Colors.blueGrey);
final lightTheme =
    ThemeData(brightness: Brightness.light, primaryColor: Colors.blueGrey);
final TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

void main() {
  runApp(MaterialApp(
      title: 'Edusketch', theme: lightTheme, home: MyStatefulWidget()));
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool keyboardOpen = false;

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() => keyboardOpen = visible);
      },
    );
  }

  int _selectedIndex = 0;
  String _selectedViewText = 'Tracking';
  final List<Widget> _views = <Widget>[
    TrackingView(),
    ScheduleView(),
    LinksView(),
    SettingsView()
  ];

  final List<String> bottomNavItemsText = <String>[
    'Tracking',
    'Schedule',
    'Links',
    'Settings'
  ];

  final List<IconData> bottomNavItemsIcons = <IconData>[
    Icons.timeline,
    Icons.schedule,
    Icons.link,
    Icons.settings
  ];

  BottomNavigationBarItem _createBottomNavItem(int i) {
    return BottomNavigationBarItem(
      icon: Icon(bottomNavItemsIcons[i]),
      title: Text(bottomNavItemsText[i]),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedViewText = bottomNavItemsText[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedViewText,
            style: Theme.of(context).textTheme.headline4),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: _views[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
          child: BottomNavigationBar(
            items: List<BottomNavigationBarItem>.generate(
                4, (int i) => _createBottomNavItem(i)),
            currentIndex: _selectedIndex,
            unselectedItemColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
            backgroundColor: Colors.grey[300],
          ),
          notchMargin: 6,
          clipBehavior: Clip.antiAlias,
          shape: CircularNotchedRectangle()),
      floatingActionButton: keyboardOpen
          ? SizedBox()
          : FloatingActionButton(
              onPressed: null,
              elevation: 2.0,
              child: Icon(Icons.add),
              focusElevation: 4.0,
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
