import 'package:animations/animations.dart';
import 'package:edusketch/screens/authenticated/views/links.dart';
import 'package:edusketch/screens/authenticated/views/schedule.dart';
import 'package:edusketch/screens/authenticated/views/settings.dart';
import 'package:edusketch/screens/authenticated/views/tracking/tracking.dart';
import 'package:edusketch/widgets/detailed_subject.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Views extends StatefulWidget {
  Views({Key key}) : super(key: key);

  @override
  _ViewsState createState() => _ViewsState();
}

class _ViewsState extends State<Views> with TickerProviderStateMixin {
  bool keyboardOpen = false;
  final _pageViewController = PageController(keepPage: true, initialPage: 0);

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

  String _selectedViewText = 'Tracking';
  final List<String> bottomNavItemsText = <String>['Tracking', 'Schedule', 'Links', 'Settings'];
  final List<IconData> bottomNavItemsIcons = <IconData>[
    Icons.timeline,
    Icons.schedule,
    Icons.link,
    Icons.settings
  ];

  IconButton bottomNavIconButton(int index, IconData i) {
    return IconButton(
        tooltip: bottomNavItemsText[index],
        icon: Icon(i),
        onPressed: () {
          _pageViewController.animateToPage(index,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
          _selectedViewText = bottomNavItemsText[index];
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedViewText.text.textStyle(Theme.of(context).textTheme.headline4).make(),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: PageView(
          controller: _pageViewController,
          children: <Widget>[TrackingView(), ScheduleView(), LinksView(), SettingsView()],
          onPageChanged: (index) {
            setState(() {
              _selectedViewText = bottomNavItemsText[index];
            });
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                bottomNavIconButton(0, Icons.timeline),
                bottomNavIconButton(1, Icons.schedule),
                SizedBox(width: 40),
                bottomNavIconButton(2, Icons.link),
                bottomNavIconButton(3, Icons.settings),
              ],
            ),
          ),
          clipBehavior: Clip.antiAlias,
          shape: CircularNotchedRectangle()),
      floatingActionButton: OpenContainer(
        openBuilder: (BuildContext context, VoidCallback _) {
          return DetailedSubject(
            createMode: true,
          );
        },
        closedElevation: 6.0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(56 / 2),
          ),
        ),
        closedColor: Theme.of(context).colorScheme.secondary,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return SizedBox(
            height: 56,
            width: 56,
            child: Center(
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// FloatingActionButton(
//           elevation: 2.0, tooltip: 'Add Subject', onPressed: () {}, child: Icon(Icons.add)),
