import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nemob_cs_helper/pages/home/home_container_presenter.dart';
import 'package:nemob_cs_helper/pages/home/home_gps.dart';
import 'package:nemob_cs_helper/pages/notif/notif.dart';
import 'package:nemob_cs_helper/providers/models.dart';
import 'package:nemob_cs_helper/utilities/localization.dart';
import 'package:nemob_cs_helper/utilities/view.dart';
import 'package:pit_components/components/adv_button.dart';
import 'package:pit_components/components/adv_column.dart';
import 'package:pit_components/components/adv_row.dart';
import 'package:nemob_cs_helper/utilities/global.dart' as global;

import '../../application.dart';

typedef WidgetAppBarCallback = void Function(Widget widget);

class HomeContainerPage extends StatefulWidget {
  @override
  _HomeContainerPageState createState() => _HomeContainerPageState();
}

class _HomeContainerPageState extends View<HomeContainerPage> {
  int _currentIndex = 0;
  HomeContainerPresenter _presenter;
  List<DrawerItem> _drawerItems;
  Widget _appBarHomeGps;

  @override
  void initStateWithContext(BuildContext context) {
    super.initStateWithContext(context);
    _presenter = HomeContainerPresenter(context, this);
    _appBarHomeGps = Container();
    _settingDrawer();
  }

  _settingDrawer(){
    _drawerItems = [
      new DrawerItem(title: dict.getString("gps"), icon: Icons.map),
      new DrawerItem(title: dict.getString("notification"), icon: Icons.notifications),
    ];
  }

  @override
  Widget buildView(BuildContext context) {
    // TODO: implement buildView

    return _widgetBuilder(context);
  }

  Widget _widgetBuilder(BuildContext context) {
    print("dict 2 => ${dict == null}");

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(child: _getDrawerItemWidget(_currentIndex)),
            ],
          ),
          appBar: _getAppBar(_currentIndex),
          drawer: Drawer(
            child: Container(
              color: Colors.blue,
              child:AdvColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    currentAccountPicture: new CircleAvatar(),
                    accountName: Text("Yudisthira Guy"),
                    accountEmail: Text("yudisguy199@gmail.com"),
                  ),
                  AdvColumn(
                      divider: ColumnDivider(1.0,color: Colors.white),
                      children: <Widget>[
                        ListTile(
                          leading:  Icon(_drawerItems[0].icon),
                          title:  Text(_drawerItems[0].title),
                          selected: 0 == _currentIndex,
                          onTap: () => _onSelectMenu(0),
                        ),
                        ListTile(
                          leading:  Icon(_drawerItems[1].icon),
                          title:  Text(_drawerItems[1].title),
                          selected: 1 == _currentIndex,
                          onTap: () => _onSelectMenu(1),
                        )
                      ]
                  )
                ],
              )
            ),
          ),
        ));
  }

  _onSelectMenu(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.pop(context);
  }

  Widget _getAppBar(int pos){
    switch (pos){
      case 0:
        return AppBar(title: Text(dict.getString("gps")), actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: (){

            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){

            },
          )
        ],);
      case 1:
        return AppBar(title: Text(dict.getString("notification")),);
    }
  }

  Widget _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new HomeGpsPage(
          carList: _presenter.getCarList,
          locationList: _presenter.getLocationList,
        );
      case 1:
        return new  NotifPage();

      default:
        return new Text("Error");
    }
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
