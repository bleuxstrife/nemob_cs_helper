//import 'package:flutter/material.dart';
//import 'package:pit_components/components/controllers/adv_text_field_controller.dart';
//import 'package:visual_hr/components/toast.dart';
//import 'package:visual_hr/dialogs/division_edit.dart';
//import 'package:visual_hr/dialogs/venue_edit.dart';
//import 'package:visual_hr/pages/home_gps.dart';
//import 'package:visual_hr/pages/room.dart';
//import 'package:visual_hr/pages/sub_division.dart';
//import 'package:visual_hr/presenter.dart';
//import 'package:visual_hr/utilities/dialog_helper.dart';
//import 'package:visual_hr/utilities/firebase_database_engine.dart';
//import 'package:visual_hr/utilities/models.dart';
//import 'package:visual_hr/utilities/routing.dart';
//import 'package:visual_hr/utilities/visual_hr_icons.dart';
//import 'package:visual_hr/view.dart';
//
//class VenuePresenter extends Presenter {
//  List<VenueModel> _venues;
//  List<VenueModel> _addedVenues = [];
//  List<AdvTextFieldController> _addedControllers = [];
//  List<VenueModel> _deletedVenues = [];
//  bool deleteMode = false;
//  bool addMode = false;
//  AnimationController _fabAnimation;
//
//  VenuePresenter(
//      BuildContext context, View<StatefulWidget> view, AnimationController fabAnimation)
//      : _fabAnimation = fabAnimation,
//        super(context, view);
//
//  @override
//  void init() {
//    fetchData();
//  }
//
//  Future<void> fetchData() async {
//    List<VenueModel> venues = await DataEngine.getRoom(context, await DataEngine.getVenue(context));
//    _venues = venues;
//    view.refresh();
//  }
//
//  AdvTextFieldController addedController(int index) => _addedControllers[index];
//
//  List<VenueModel> get venues {
//    if (addMode) {
//      return List.from(_venues)..addAll(_addedVenues);
//    }
//
//    return _venues;
//  }
//
//  void save() {
//    if (deleteMode) {
//      deleteMode = false;
//      _fabAnimation.forward();
//
//      view.process(() async {
//        while (_deletedVenues.length > 0) {
//          VenueModel venue = _deletedVenues.first;
//          bool success = await DataEngine.removeVenue(context, venue.id);
//          if (success) {
//            _deletedVenues.removeWhere((deletedDivision) => deletedDivision.id == venue.id);
//
//            if (_deletedVenues.length == 0) {
//              _venues = null;
//              fetchData();
//              view.refresh();
//              return;
//            }
//          }
//        }
//      });
//    } else if (addMode) {
//      view.process(() async {
//        while (_addedControllers.length > 0) {
//          AdvTextFieldController controller = _addedControllers.first;
//
//          bool success = await DataEngine.addVenue(context, controller.text);
//          if (success) {
//            _addedControllers.removeWhere((addedController) => addedController.text == controller.text);
//
//            if (_addedControllers.length == 0) {
//              addMode = false;
//              _addedVenues.clear();
//              _venues = null;
//              fetchData();
//              view.refresh();
//              return;
//            }
//          }
//        }
//      });
//    }
//
//    view.refresh();
//  }
//
//  Future<bool> canPop() async {
//    if (addMode || deleteMode) {
//      bool confirmed = await DialogHelper.showConfirmationDialog(
//        context: context,
//        content: dict.getString("confirm_discard_changes"),
//      );
//
//      if (confirmed) {
//        undoChanges();
//      }
//
//      return false;
//    }
//
//    return true;
//  }
//
//  void undoChanges() {
//    if (addMode) {
//      _addedVenues.clear();
//      _addedControllers.clear();
//      addMode = false;
//    } else {
//      deleteMode = false;
//      _deletedVenues.clear();
//      _fabAnimation.forward();
//    }
//
//    view.refresh();
//  }
//
//  void add() {
//    if (addMode) {
//      _addedVenues.add(VenueModel());
//      _addedControllers.add(defaultController());
//    } else {
//      addMode = true;
//      _addedVenues.add(VenueModel());
//      _addedControllers.add(defaultController());
//    }
//
//    view.refresh();
//  }
//
//  void delete(VenueModel venue) {
//    if (isDeleted(venue)) {
//      _deletedVenues.removeWhere((deletedVenue) => deletedVenue.id == venue.id);
//    } else {
//      _deletedVenues.add(venue);
//    }
//    view.refresh();
//  }
//
//  bool isDeleted(VenueModel venue) {
//    return _deletedVenues.where((deletedVenue) => deletedVenue.id == venue.id).length >
//        0;
//  }
//
//  AdvTextFieldController defaultController() {
//    return AdvTextFieldController(label: dict.getString("name"));
//  }
//
//  void edit(VenueModel venue) async {
//    bool saved = await showDialog(context: context, builder: (BuildContext context) => InputVenueDialog(venue));
//
//    if (saved ?? false) {
//      _venues = null;
//      fetchData();
//      view.refresh();
//    }
//  }
//
//  void goToRooms(String id) {
//    Routing.push(context, RoomPage(venues: _venues, currentVenueId: id)).then((venues) {
//      if (venues != null) {
//        _venues = venues;
//        view.refresh();
//      }
//    });
//  }
//}
