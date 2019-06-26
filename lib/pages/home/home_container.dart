import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nemob_cs_helper/pages/home/home_gps.dart';
import 'package:nemob_cs_helper/pages/notif/notif.dart';
import 'package:nemob_cs_helper/utilities/localization.dart';
import 'package:nemob_cs_helper/utilities/view.dart';
import 'package:pit_components/components/adv_button.dart';
import 'package:pit_components/components/adv_column.dart';
import 'package:pit_components/components/adv_row.dart';
import 'package:nemob_cs_helper/utilities/global.dart' as global;

class HomeContainerPage extends StatefulWidget {
  @override
  _HomeContainerPageState createState() => _HomeContainerPageState();
}

class _HomeContainerPageState extends View<HomeContainerPage> {
  int _currentIndex = 0;

  List<Widget> _children;

  @override
  Widget buildView(BuildContext context) {
    // TODO: implement buildView
    _children = [new HomeGpsPage(), new NotifPage()];
    return _widgetBuilder(context);
  }

  Widget _widgetBuilder(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(child: _children[_currentIndex]),
              Positioned(
                bottom: 0.0,
                child: Container(
                  height: 3.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.grey.withOpacity(0.2)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar:
              BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  onTap: onTabTapped,
                  currentIndex: _currentIndex,
                  items: [
            new BottomNavigationBarItem(
                icon: Icon(Icons.map),
                title: Text(
                  dict.getString("gps"),
                  style: TextStyle(color: Colors.black),
                ),
                activeIcon: Icon(Icons.map, color: global.systemAccentColor)),
            new BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                title: Text(
                  dict.getString('notification'),
                  style: TextStyle(color: Colors.black),
                ),
                activeIcon: Icon(Icons.notifications, color: global.systemAccentColor))
          ]),

        ));
  }

  void onTabTapped(int index) {
//    AnalyticsHelper.setCurrentScreen(screenName: _tabNames[_currentIndex]);

    setState(() {
      _currentIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    CsHelperDict dict = CsHelperDict.of(context);
    return await showDialog(
            context: context,
            builder: (context) => new Dialog(
                    child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: AdvColumn(
                    divider: ColumnDivider(10.0),
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(dict.getString('quit_apps')),
                      Text(dict.getString('quit_apps_msg')),
                      Container(
                        padding: EdgeInsets.only(top: 15.0),
                        child: AdvRow(
                          divider: RowDivider(10.0),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: AdvButton(dict.getString('no'), onPressed: () {
                                Navigator.pop(context, false);
                              },
                                  textColor: Colors.white,
                                  backgroundColor: Colors.black,
                                  onlyBorder: true),
                            ),
                            Expanded(
                              child: AdvButton(
                                dict.getString('yes'),
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ))) ??
        false;
  }
}
