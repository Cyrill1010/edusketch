import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edusketch/screens/authenticated/views/links.dart';
import 'package:edusketch/screens/authenticated/views/schedule.dart';
import 'package:edusketch/screens/authenticated/views/settings.dart';
import 'package:edusketch/screens/authenticated/views/tracking.dart';
import 'package:flutter/material.dart';

class Views extends StatefulWidget {
  Views({Key key}) : super(key: key);

  @override
  _ViewsState createState() => _ViewsState();
}

class _ViewsState extends State<Views> {
  bool keyboardOpen = false;

  final _pageViewController = PageController();

  int _activePage = 0;

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   KeyboardVisibilityNotification().addNewListener(
  //     onChange: (bool visible) {
  //       setState(() => keyboardOpen = visible);
  //     },
  //   );
  // }

  static final db = Firestore.instance;
  String _selectedViewText = 'Tracking';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(_selectedViewText,
            style: Theme.of(context).textTheme.headline4),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: PageView(
          controller: _pageViewController,
          children: <Widget>[
            TrackingView(db),
            ScheduleView(),
            LinksView(),
            SettingsView()
          ],
          onPageChanged: (index) {
            setState(() {
              _selectedViewText = bottomNavItemsText[index];
              _activePage = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: List<BottomNavigationBarItem>.generate(
                4, (int i) => _createBottomNavItem(i)),
            currentIndex: _activePage,
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.amber[800],
            onTap: (index) {
              _pageViewController.animateToPage(index,
                  duration: Duration(milliseconds: 2), curve: Curves.ease);
              _activePage = index;
              _selectedViewText = bottomNavItemsText[index];
            },
            backgroundColor: Colors.grey[300],
          ),
          clipBehavior: Clip.antiAlias,
          shape: CircularNotchedRectangle()),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        elevation: 2.0,
        child: Icon(Icons.add),
        focusElevation: 4.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
