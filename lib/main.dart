import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import './views/tracking.dart';
import './views/schedule.dart';
import './views/links.dart';
import './views/settings.dart';
import './theme.dart';

// Grade:
// grade: 5,
//         topic: `Dog`,
//         type: `normal`,
//         gradeWeight: 1,
//         notes: ``,
//         remember: ``,
//         semester: 4.2,
//         date: ``,

class Subject {
  String name;
  double goal;
  String weight;
  List grades;
  double average;
  String notes;
  String rememeber;
  String background;
  String icon;

  Subject(this.name, this.goal, this.weight, this.grades, this.average,
      this.notes, this.rememeber, this.background, this.icon);
}

void main() async {
  runApp(MaterialApp(title: 'Edusketch', theme: theme, home: PageLayout()));
}

class PageLayout extends StatefulWidget {
  PageLayout({Key key}) : super(key: key);

  @override
  _PageLayoutState createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  bool keyboardOpen = false;

  final _pageViewController = PageController();

  int _activePage = 0;

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() => keyboardOpen = visible);
      },
    );
  }

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
      appBar: AppBar(
        title: Text(_selectedViewText,
            style: Theme.of(context).textTheme.headline4),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: PageView(
        controller: _pageViewController,
        children: <Widget>[
          TrackingView(db),
          ScheduleView(),
          LinksView(),
          SettingsView()
        ],
        onPageChanged: (index) {
          setState(() {
            _activePage = index;
          });
        },
      ),
      bottomNavigationBar: BottomAppBar(
          child: BottomNavigationBar(
            items: List<BottomNavigationBarItem>.generate(
                4, (int i) => _createBottomNavItem(i)),
            currentIndex: _activePage,
            unselectedItemColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.amber[800],
            onTap: (index) {
              _pageViewController.animateToPage(index,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.bounceOut);
              _activePage = index;
              _selectedViewText = bottomNavItemsText[index];
            },
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
