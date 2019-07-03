import 'package:flutter/cupertino.dart';
import 'package:demo/pages/notes.dart';
import 'package:demo/pages/search.dart';
import 'package:provider/provider.dart';
import 'package:demo/data/schedule.dart';

class DemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (BuildContext context) => NotesSchedule(),
      child: CupertinoPageScaffold(
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(IconData(0xe896, fontFamily: 'MaterialIcons')),
                title: Text('Notes'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search),
                title: Text('Search'),
              ),
            ],
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return CupertinoTabView(builder: (context) {
                  return CupertinoPageScaffold(
                    child: NotesPage(),
                  );
                });
              case 1:
                return CupertinoTabView(builder: (context) {
                  return CupertinoPageScaffold(
                    child: SearchPage(),
                  );
                });
            }
          },
        ),
      ),
    );
  }
}
