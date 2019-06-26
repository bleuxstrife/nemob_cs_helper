import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nemob_cs_helper/component/mod_rect_checkbox.dart';
import 'package:pit_components/components/adv_button.dart';
import 'package:pit_components/components/adv_column.dart';
import 'package:pit_components/components/adv_list_tile.dart';
import 'package:pit_components/mods/mod_checkbox.dart';
import 'package:pit_components/pit_components.dart';
import 'package:pit_components/consts/textstyles.dart' as ts;

typedef GroupCheckCallback = void Function(List<String> data);

class GroupCheckItem {
  String data;
  String display;
  Widget icon;

  GroupCheckItem(this.data, this.display, {this.icon});
}

class AdvGroupMultiCheck extends StatefulWidget {
  final AdvGroupCheckMultiController controller;
  final String title;
  final GroupCheckCallback callback;

  AdvGroupMultiCheck(
      {this.title,
      List<String> checkedValueList,
      List<GroupCheckItem> itemList,
      AdvGroupCheckMultiController controller,
      this.callback})
      : assert(controller == null || (checkedValueList == null && itemList == null)),
        this.controller = controller ??
            new AdvGroupCheckMultiController(
                checkedValueList: checkedValueList ?? [], itemList: itemList ?? []);

  @override
  State<StatefulWidget> createState() => _AdvGroupMultiCheckState();
}

class _AdvGroupMultiCheckState extends State<AdvGroupMultiCheck> {
  @override
  void initState() {
    widget.controller.addListener(() {
      if (this.mounted) {
        setState(() {});
      }
    });

    super.initState();
  }

  bool isTriggerChecked = true;

  @override
  Widget build(BuildContext context) {
    List<GroupCheckItem> stringChildren = widget.controller.itemList;
    List<Widget> children = [];

    stringChildren.forEach((groupCheckItem) {
      bool _isCheckedValue = false;
      for (final value in widget.controller.checkedValueList) {
        if (groupCheckItem.data == value) {
          _isCheckedValue = true;
          break;
        }
      }
      children.add(Container(
          child: AdvListTile(
              onTap: () {
                isTriggerChecked = false;
                if (_isCheckedValue) {
                  widget.controller.checkedValueList.remove(groupCheckItem.data);
                } else {
                  widget.controller.checkedValueList.add(groupCheckItem.data);
                }
                _isCheckedValue = true;
                setState(() {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _isCheckedValue = !_isCheckedValue;
                      isTriggerChecked = true;

                      if (widget.callback != null)
                        widget.callback(widget.controller.checkedValueList);
                    });
                  });
                });
              },
              padding: EdgeInsets.all(16.0),
              start: groupCheckItem.icon,
              expanded: Text(groupCheckItem.display),
              end: _isCheckedValue
                  ? AbsorbPointer(
                      child: RectCheckbox(
                        onChanged: (value){},
                      value: isTriggerChecked,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor: PitComponents.groupCheckCheckColor,
                    ))
                  : Container())));
    });

    return Container(
        child: AdvColumn(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        widget.title == null
            ? Container()
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 16.0, bottom: 4.0),
                child: Text(
                  widget.title,
                  style:
                      ts.fs18.merge(ts.fw700).copyWith(color: PitComponents.groupCheckTitleColor),
                ),
              ),
        Container(
          child: AdvColumn(
              divider: Container(
                height: 1.0,
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                color: Theme.of(context).dividerColor,
              ),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children),
        ),
      ],
    ));
  }
}

class AdvGroupCheckMultiController extends ValueNotifier<AdvGroupCheckEditingValue> {
  List<String> get checkedValueList => value.checkedValueList;

  set checkedValueList(List<String> newCheckedValueList) {
    value = value.copyWith(checkedValueList: newCheckedValueList, itemList: this.itemList);
  }

  List<GroupCheckItem> get itemList => value.itemList;

  set itemList(List<GroupCheckItem> newItemList) {
    value = value.copyWith(checkedValueList: this.checkedValueList, itemList: newItemList);
  }

  AdvGroupCheckMultiController({List<String> checkedValueList, List<GroupCheckItem> itemList})
      : super(checkedValueList == null && itemList == null
            ? AdvGroupCheckEditingValue.empty
            : new AdvGroupCheckEditingValue(
                checkedValueList: checkedValueList, itemList: itemList));

  AdvGroupCheckMultiController.fromValue(AdvGroupCheckEditingValue value)
      : super(value ?? AdvGroupCheckEditingValue.empty);

  void clear() {
    value = AdvGroupCheckEditingValue.empty;
  }
}

@immutable
class AdvGroupCheckEditingValue {
  const AdvGroupCheckEditingValue({this.checkedValueList, this.itemList});

  final List<String> checkedValueList;
  final List<GroupCheckItem> itemList;

  static const AdvGroupCheckEditingValue empty = const AdvGroupCheckEditingValue();

  AdvGroupCheckEditingValue copyWith(
      {List<String> checkedValueList, List<GroupCheckItem> itemList}) {
    return new AdvGroupCheckEditingValue(checkedValueList: checkedValueList, itemList: itemList);
  }

  AdvGroupCheckEditingValue.fromValue(AdvGroupCheckEditingValue copy)
      : this.checkedValueList = copy.checkedValueList,
        this.itemList = copy.itemList;

  @override
  String toString() =>
      '$runtimeType(checkedValue: \u2524$checkedValueList\u251C, valueList: \u2524$itemList\u251C)';

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other is! AdvGroupCheckEditingValue) return false;
    final AdvGroupCheckEditingValue typedOther = other;
    return typedOther.checkedValueList == checkedValueList && typedOther.itemList == itemList;
  }

  @override
  int get hashCode => hashValues(checkedValueList.hashCode, itemList.hashCode);
}
