import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nemob_cs_helper/component/mod_rect_checkbox.dart';
import 'package:pit_components/components/adv_column.dart';
import 'package:pit_components/components/adv_list_tile.dart';
import 'package:pit_components/pit_components.dart';

typedef SearchGroupCheckCallback = void Function(List<String> data);

typedef WidgetCallback<T> = Widget Function(T data);


class SearchGroupCheckItem<T> {
  String data;
  T display;

  SearchGroupCheckItem(this.data, this.display);
}

class AdvMultiSearchGroupCheck extends StatefulWidget {
  final SearchGroupCheckCallback itemCallback;
  final WidgetCallback widgetCallBack;
  final List<String> checkedValueList ;
  final List<SearchGroupCheckItem> itemList;
  
  AdvMultiSearchGroupCheck({this.itemCallback, this.widgetCallBack, this.itemList,this.checkedValueList = const []});


  @override
  _AdvMultiSearchGroupCheckState createState() => _AdvMultiSearchGroupCheckState();
}

class _AdvMultiSearchGroupCheckState extends State<AdvMultiSearchGroupCheck> {

//  @override
//  void initState() {
//    widget.controller.addListener(() {
//      if (this.mounted) {
//        setState(() {});
//      }
//    });
//
//    super.initState();
//  }
  bool isTriggerChecked = true;
  @override
  Widget build(BuildContext context) {
    List<SearchGroupCheckItem> stringChildren = widget.itemList;
    List<Widget> children = [];

    stringChildren.forEach((groupCheckItem) {
      bool _isCheckedValue = false;
      for (final value in widget.checkedValueList) {
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
                  widget.checkedValueList.remove(groupCheckItem.data);
                } else {
                  widget.checkedValueList.add(groupCheckItem.data);
                }
                _isCheckedValue = true;
                setState(() {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _isCheckedValue = !_isCheckedValue;
                      isTriggerChecked = true;

                      if (widget.itemCallback != null)
                        widget.itemCallback(widget.checkedValueList);


                    });
                  });
                });
              },
              padding: EdgeInsets.all(16.0),
              expanded: Builder(builder: (_) {
                if(widget.widgetCallBack!=null)
                  return widget.widgetCallBack(groupCheckItem.display);
              }),
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

//class AdvMultiSearchGroupCheckController
//    extends ValueNotifier<AdvMultiSearchGroupCheckEditingValue> {
//  AdvMultiSearchGroupCheckController(
//      {List<SearchGroupCheckItem> itemList, List<String> checkedValueList})
//      : super(itemList == null && checkedValueList == null
//            ? AdvMultiSearchGroupCheckEditingValue.empty
//            : new AdvMultiSearchGroupCheckEditingValue(
//                itemList: itemList, checkedValueList: checkedValueList));
//
//  List<String> get checkedValueList => value.checkedValueList;
//
//  set checkedValueList(List<String> newCheckedValueList) {
//    value = value.copyWith(checkedValueList: newCheckedValueList, itemList: this.itemList);
//  }
//
//  List<SearchGroupCheckItem> get itemList => value.itemList;
//
//  set itemList(List<SearchGroupCheckItem> newItemList) {
//    value = value.copyWith(checkedValueList: this.checkedValueList, itemList: newItemList);
//  }
//}
//
//@immutable
//class AdvMultiSearchGroupCheckEditingValue {
//  final List<SearchGroupCheckItem> itemList;
//  final List<String> checkedValueList;
//
//  const AdvMultiSearchGroupCheckEditingValue({this.itemList, this.checkedValueList});
//
//  static const AdvMultiSearchGroupCheckEditingValue empty =
//      const AdvMultiSearchGroupCheckEditingValue();
//
//  AdvMultiSearchGroupCheckEditingValue copyWith(
//      {List<SearchGroupCheckItem> itemList, List<String> checkedValueList}) {
//    return new AdvMultiSearchGroupCheckEditingValue(
//        itemList: itemList, checkedValueList: checkedValueList);
//  }
//
//  AdvMultiSearchGroupCheckEditingValue.fromValue(AdvMultiSearchGroupCheckEditingValue copy)
//      : this.itemList = copy.itemList,
//        this.checkedValueList = copy.checkedValueList;
//
//  @override
//  String toString() =>
//      '$runtimeType(CheckValueList: \u2524$checkedValueList\u251C, ValueList: \u2524$itemList\u251C)';
//
//  @override
//  bool operator ==(dynamic other) {
//    if (identical(this, other)) return true;
//    if (other is! AdvMultiSearchGroupCheckEditingValue) return false;
//    final AdvMultiSearchGroupCheckEditingValue typedOther = other;
//    return typedOther.checkedValueList == checkedValueList && typedOther.itemList == itemList;
//  }
//
//  @override
//  int get hashCode => hashValues(checkedValueList.hashCode, itemList.hashCode);
//}
