import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nemob_cs_helper/component/adv_multiple_group_check.dart';
import 'package:nemob_cs_helper/component/adv_multiple_search_group_check.dart';
import 'package:nemob_cs_helper/component/component_utils.dart';
import 'package:pit_components/components/adv_column.dart';
import 'package:pit_components/components/adv_row.dart';
import 'package:pit_components/components/controllers/adv_chooser_controller.dart';
import 'package:nemob_cs_helper/utilities/view.dart';
import 'package:nemob_cs_helper/utilities/global.dart' as global;

import '../../application.dart';
import 'home_container.dart';
import 'home_container_presenter.dart';
import 'home_gps_presenter.dart';

class HomeGpsPage extends StatefulWidget {
  final List<String> carList;
  final List<String> locationList;



  HomeGpsPage({this.carList, this.locationList});

  @override
  _HomeGpsPageState createState() => _HomeGpsPageState();
}

class _HomeGpsPageState extends View<HomeGpsPage> with TickerProviderStateMixin {
  GoogleMapController mapController;
  AnimationController _buttonAnimController;
  AnimationController _slideCityAnimController;
  AnimationController _slideCarListAnimController;
  Animation<Offset> _containerCityOffset;
  Animation<Offset> _containerCarOffset;
  Animation<double> _iconOffset;
  BuildContext currentScaffoldContext;

  HomeGpsPresenter _presenter;

  List<GroupCheckItem> carGroupList = [];
  AdvChooserController carCtrl = AdvChooserController();
  CameraPosition cameraPosition =
      CameraPosition(bearing: 0.0, target: LatLng(0.0, 0.0), tilt: 0, zoom: 11.0);
  bool isCarExpanded = false, isCityExpanded = false;
  bool isFilter = false;

  @override
  void initStateWithContext(BuildContext context) {
    super.initStateWithContext(context);
    _presenter = HomeGpsPresenter(context, this, widget.locationList, widget.carList);

    _buttonAnimController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100), value: 1.0);
    _slideCityAnimController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100), value: 1.0);
    _slideCarListAnimController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100), value: 1.0);
    _containerCarOffset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, -1.0))
        .animate(_slideCarListAnimController);
    _containerCityOffset =
        Tween<Offset>(begin: Offset.zero, end: Offset(0.0, -1.0)).animate(_slideCityAnimController);
    _iconOffset = Tween<double>(begin: 0, end: 180 / 360).animate(_buttonAnimController);

  }

  _mainSegment() {

    return Stack(
      children: <Widget>[
        GoogleMap(
//          markers: Set<Marker>.of(markers.values),
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            tiltGesturesEnabled: false,
            rotateGesturesEnabled: false,
            initialCameraPosition: cameraPosition),
//        Container(
//          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//          child: AnimatedBuilder(
//            animation: _buttonAnimController,
//            builder: (context, widget) {
//              return Stack(
//                children: <Widget>[
//                  Container(
//                    width: MediaQuery.of(context).size.width,
//                    child: SlideTransition(
//                        position: _containerCarOffset,
//                        child: Container(
//                          color: Colors.white,
//                          child: SingleChildScrollView(
//                            scrollDirection: Axis.vertical,
//                            child: AdvColumn(
//                              divider: ColumnDivider(
//                                1.0,
//                                color: Colors.grey,
//                              ),
//                              children: <Widget>[
//                                AdvMultiSearchGroupCheck(
//                                  widgetCallBack: (car) => _buildItemListCar(car),
//                                  itemCallback: (checkedValueList) {
//                                    _presenter.setCarIdList = checkedValueList;
//                                  },
//                                  itemList: _presenter.getCarGroupItemList,
//                                  checkedValueList: _presenter.getCarIdList,
//                                )
//                              ],
//                            ),
//                          ),
//                        )),
//                  ),
//                  Container(
//                    width: MediaQuery.of(context).size.width,
//                    child: SlideTransition(
//                        position: _containerCityOffset,
//                        child: Container(
//                          color: Colors.white,
//                          child: SingleChildScrollView(
//                            scrollDirection: Axis.vertical,
//                            child: AdvColumn(
//                              divider: ColumnDivider(
//                                1.0,
//                                color: Colors.grey,
//                              ),
//                              children: <Widget>[
//                                AdvMultiSearchGroupCheck(
//                                  widgetCallBack: (location) => _buildItemLocation(location),
//                                  itemCallback: (checkedValueList) {
//                                    _presenter.setLocationIdList = checkedValueList;
//                                  },
//                                  itemList: _presenter.getLocationGroupItemList,
//                                  checkedValueList: _presenter.getLocationIdList,
//                                )
//                              ],),
//                          ),
//                        )),
//                  ),
//
//                ],
//              );
//            },
//          ),
//        ),
//        Container(
//            color: Colors.white,
//            width: MediaQuery.of(context).size.width,
//            height: MediaQuery.of(context).padding.top),
      ],
    );
  }

//  Widget _buildAppBar(){
//    return Container(
//        padding: EdgeInsets.all(16.0),
//        color: Colors.white,
//        width: MediaQuery.of(context).size.width,
//        height: AppBar().preferredSize.height,
//        child: Container(
//          child: AdvRow(
//            divider: RowDivider(8.0),
//            mainAxisAlignment: MainAxisAlignment.end,
//            children: <Widget>[
//              InkWell(
//                child: Icon(Icons.filter_list),
//                onTap: () {
//                  isFilter = true;
//                  _buttonAnimController.forward();
//                  if (_slideCarListAnimController.value == 0.0) {
//                    _slideCarListAnimController.forward();
//                    isCarExpanded = false;
//                  }
//
//                  if (isCityExpanded) {
//                    _slideCityAnimController.forward();
//                  } else {
//                    _slideCityAnimController.reverse();
//                  }
//                  isCityExpanded = !isCityExpanded;
//                },
//              ),
//              InkWell(
//                child: RotationTransition(
//                    child: Icon(Icons.arrow_upward), turns: _iconOffset),
//                onTap: () {
//                  isFilter = false;
//
//                  if (_slideCityAnimController.value == 0.0) {
//                    _slideCityAnimController.forward();
//                    isCityExpanded = false;
//                  }
//
//                  if (isCarExpanded) {
//                    _slideCarListAnimController.forward();
//                    _buttonAnimController.forward();
//                  } else {
//                    _slideCarListAnimController.reverse();
//                    _buttonAnimController.reverse();
//                  }
//                  isCarExpanded = !isCarExpanded;
//                },
//              ),
//            ],
//          ),
//        ));
//  }

  Widget _buildItemListCar(String car) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(car),
    );
  }

  Widget _buildItemLocation(String location) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(location),
    );
  }


  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  Widget _widgetBuilder(BuildContext context) {
    if (mapController != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mapController.moveCamera(CameraUpdate.newCameraPosition(cameraPosition));

      });
    }
    return _mainSegment();
  }

  @override
  Widget buildView(BuildContext context) {
    // TODO: implement buildView
    return Scaffold(
      body: _widgetBuilder(context),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () async {
//          carIdList = await ComponentUtils.pickMultiFromChooser(context,
//                  title: 'Pilih Mobil', items: carGroupList, currentItemList: carIdList) ??
//              this.carIdList;
//        },
//        backgroundColor: global.systemAccentColor,
//        foregroundColor: global.systemLighterGreyColor,
//        child: Icon(Icons.directions_car),
//      ),
    );
//
  }
}
