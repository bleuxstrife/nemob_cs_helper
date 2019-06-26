//import 'package:flutter/material.dart';
//import 'package:pit_components/components/adv_column.dart';
//import 'package:pit_components/components/adv_loading_with_barrier.dart';
//import 'package:pit_components/components/adv_row.dart';
//import 'package:pit_components/components/adv_text_field.dart';
//import 'package:refresher/refresher.dart';
//import 'package:visual_hr/components/plate.dart';
//import 'package:visual_hr/components/round_button.dart';
//import 'package:visual_hr/presenters/venue.dart';
//import 'package:visual_hr/utilities/global.dart';
//import 'package:visual_hr/utilities/models.dart';
//import 'package:visual_hr/utilities/textstyles.dart';
//import 'package:visual_hr/utilities/visual_hr_icons.dart';
//import 'package:visual_hr/view.dart';
//
//class VenuePage extends StatefulWidget {
//  @override
//  _VenuePageState createState() => _VenuePageState();
//}
//
//class _VenuePageState extends View<VenuePage> with SingleTickerProviderStateMixin {
//  AnimationController _fabAnimation;
//  VenuePresenter _presenter;
//
//  @override
//  void initStateWithContext(BuildContext context) {
//    super.initStateWithContext(context);
//
//    _fabAnimation =
//        AnimationController(value: 1.0, duration: Duration(milliseconds: 300), vsync: this);
//
//    _presenter = VenuePresenter(context, this, _fabAnimation);
//  }
//
//  @override
//  Widget buildView(BuildContext context) {
//    List<Widget> actions = [
//      IconButton(
//        icon: Icon(_presenter.deleteMode || _presenter.addMode ? Icons.undo : VisualHrIcons.delete),
//        onPressed: () {
//          if (_presenter.addMode || _presenter.deleteMode) {
//            _presenter.canPop();
//          } else {
//            setState(() {
//              _presenter.deleteMode = !_presenter.deleteMode;
//
//              _fabAnimation.reverse();
//            });
//          }
//        },
//      )
//    ];
//
//    if (_presenter.deleteMode || _presenter.addMode) {
//      IconButton saveEdit = IconButton(
//        icon: Icon(Icons.check),
//        onPressed: () {
//          _presenter.save();
//        },
//      );
//
//      actions.add(saveEdit);
//    }
//
//    int addCounter = 0;
//
//    return WillPopScope(
//      onWillPop: _presenter.canPop,
//      child: Scaffold(
//        appBar: AppBar(
//          centerTitle: false,
//          title: Text(dict.getString("venue")),
//          actions: actions,
//        ),
//        body: AdvLoadingWithBarrier(
//          isProcessing: _presenter.venues == null,
//          content: Container(
//            constraints: BoxConstraints.expand(),
//            child: Refresher(
//              onRefresh: _presenter.fetchData,
//              child: AdvColumn(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                padding: EdgeInsets.all(16.0),
//                divider: ColumnDivider(8.0),
//                children: _presenter.venues == null
//                    ? []
//                    : _presenter.venues.map((venue) {
//                        if (venue.id == null) addCounter++;
//                        return _presenter.deleteMode
//                            ? _buildDeletePlate(venue)
//                            : _presenter.addMode
//                                ? _buildAddPlate(venue, addCounter)
//                                : _buildNormalPlate(venue);
//                      }).toList()
//                  ..add(Container(
//                    height: 60.0,
//                  )),
//              ),
//            ),
//          ),
//        ),
//        floatingActionButton: ScaleTransition(
//          scale: _fabAnimation,
//          child: FloatingActionButton(
//            onPressed: _presenter.add,
//            child: Icon(Icons.add),
//          ),
//        ),
//      ),
//    );
//  }
//
//  Widget _buildNormalPlate(VenueModel venue) {
//    return Plate(
//      padding: EdgeInsets.all(8.0),
//      child: AdvColumn(crossAxisAlignment: CrossAxisAlignment.start, children: [
//        AdvColumn(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          padding: EdgeInsets.all(8.0),
//          children: [
//            Text(venue.name, style: TextStyle(color: Colors.black)),
//            Text(dict.getStringPlural("room", venue.rooms.length),
//                style: p5.copyWith(color: Colors.black)),
//          ],
//        ),
//        IgnorePointer(
//          ignoring: _presenter.addMode,
//          child: AdvRow(
//            mainAxisAlignment: MainAxisAlignment.end,
//            divider: ColumnDivider(8.0),
//            children: [
//              InkWell(
//                child: Container(
//                  child: Text(dict.getString("edit"),
//                      style: h10.copyWith(
//                          color: _presenter.addMode ? systemDisabledColor : systemHyperlinkColor)),
//                  padding: EdgeInsets.all(8.0),
//                ),
//                onTap: () {
//                  _presenter.edit(venue);
//                },
//              ),
//              InkWell(
//                child: Container(
//                  child: Text(dict.getString(venue.rooms.length == 0 ? "add_room" : "see_rooms"),
//                      style: h10.copyWith(
//                          color: _presenter.addMode ? systemDisabledColor : systemHyperlinkColor)),
//                  padding: EdgeInsets.all(8.0),
//                ),
//                onTap: () {
//                  _presenter.goToRooms(venue.id);
//                },
//              ),
//            ],
//          ),
//        ),
//      ]),
//    );
//  }
//
//  Widget _buildAddPlate(VenueModel venue, int addCounter) {
//    if (venue.id == null) {
//      return Plate(
//        padding: EdgeInsets.all(8.0),
//        child: AdvRow(divider: RowDivider(16.0), children: [
//          Expanded(
//              child: AdvTextField(
//            controller: _presenter.addedController(addCounter - 1),
//          )),
//          RoundButton(
//            icon: VisualHrIcons.delete,
//            backgroundColor: systemRedColor,
//            iconColor: Colors.white,
//            callback: () {},
//          ),
//        ]),
//      );
//    } else {
//      return _buildNormalPlate(venue);
//    }
//  }
//
//  Widget _buildDeletePlate(VenueModel venue) {
//    bool isDeleted = _presenter.isDeleted(venue);
//    return Plate(
//      color: isDeleted ? Color.lerp(systemRedColor, Colors.white, 0.5) : null,
//      child: AdvRow(divider: RowDivider(16.0), children: [
//        Expanded(
//          child: Text(venue.name, style: TextStyle(color: isDeleted ? Colors.white : Colors.black)),
//        ),
//        RoundButton(
//          icon: isDeleted ? Icons.undo : Icons.close,
//          iconColor: isDeleted ? systemGreenColor : systemRedColor,
//          callback: () {
//            _presenter.delete(venue);
//          },
//        ),
//      ]),
//    );
//  }
//}
