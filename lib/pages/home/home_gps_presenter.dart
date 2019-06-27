import 'package:flutter/src/widgets/framework.dart';
import 'package:nemob_cs_helper/component/adv_multiple_search_group_check.dart';
import 'package:nemob_cs_helper/utilities/presenter.dart';
import 'package:nemob_cs_helper/utilities/view.dart';

class HomeGpsPresenter extends Presenter{
  final List<String> _carList;
  final List<String> _locationList;
  List<String> carIdList = [];
  List<String> locationIdList =[];
  List<SearchGroupCheckItem> carGroupItemList = [];
  List<SearchGroupCheckItem> locationGroupItemList = [];

  HomeGpsPresenter(BuildContext context, View<StatefulWidget> view,
      List<String> locationList, List<String> carList)
      : _carList= carList,
        _locationList = locationList,
        super(context, view);

  @override
  void init() {
    carIdList.add(_carList[0]);
    locationIdList.add(_locationList[1]);

    for(int i = 0; _carList.length>i; i++){
      carGroupItemList.add(new SearchGroupCheckItem(_carList[i], _carList[i]));
    }

    for(int i = 0; _locationList.length>i; i++){
      locationGroupItemList.add(new SearchGroupCheckItem(_locationList[i], _locationList[i]));
    }
  }

  List<SearchGroupCheckItem> get getCarGroupItemList{
    return carGroupItemList;
  }

  List<SearchGroupCheckItem> get getLocationGroupItemList{
    return locationGroupItemList;
  }

  List<String> get getCarIdList{
    return carIdList;
  }

  set setCarIdList(List<String> newValueList){
    this.carIdList = newValueList;
  }

  List<String> get getLocationIdList{
    return locationIdList;
  }

  set setLocationIdList(List<String> newValueList){
    this.locationIdList = newValueList;
  }

}