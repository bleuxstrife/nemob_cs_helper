import 'package:flutter/src/widgets/framework.dart';
import 'package:nemob_cs_helper/utilities/presenter.dart';
import 'package:nemob_cs_helper/utilities/view.dart';

class HomeContainerPresenter extends Presenter {
  HomeContainerPresenter(BuildContext context, View<StatefulWidget> view) : super(context, view);
  List<String> carList = ["Car 1", "Car 2", "Car 3", "Car 4", "Car 5"];
  List<String> locationList = ["All", "Jakarta", "Bandung", "Yogyakarta", "Bali"];
  List<String> carIdList = ["Car 3", "Car 4"];
  @override
  void init() {
    // TODO: implement init
  }


  List<String> get getCarList {
    return carList;
  }

  List<String> get getDefaultCarIdList {
    return locationList;
  }

  List<String> get getLocationList{
    return locationList;
  }

  set setCarIdList(List<String> newValueList){
    this.carIdList = newValueList;
  }


}
