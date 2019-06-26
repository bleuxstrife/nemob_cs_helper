
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nemob_cs_helper/component/adv_multiple_group_check.dart';
import 'package:pit_components/components/adv_button.dart';
import 'package:pit_components/components/adv_list_tile.dart';
import 'package:pit_components/consts/textstyles.dart' as ts;

typedef void OnItemChanged(BuildContext context, List<String> oldValueList, List<String> newValueList);

class ComponentUtils {
  static Future<dynamic> pickMultiFromChooser(BuildContext context,
      {String title = "",
        List<GroupCheckItem> items,
        List<String> currentItemList = const []}) async {
    assert(items != null);

    List<String> valueList = new List<String>.from(currentItemList);
    List<String> newValueList = [];

    AdvGroupCheckMultiController controller =
    AdvGroupCheckMultiController(checkedValueList: valueList, itemList: items);

    return await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AdvListTile(
                padding: EdgeInsets.all(16.0),
                start: Icon(Icons.close),
                expanded: Text(title, style: ts.fs18.merge(ts.fw700)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Container(height: 2.0, color: Theme.of(context).dividerColor),
              Flexible(
                  child: SingleChildScrollView(
                      child: AdvGroupMultiCheck(
                        controller: controller,
                        callback: (itemSelected) async {
                          newValueList = itemSelected;
                        },
                      ))),

              Container(
                  margin: EdgeInsets.all(16.0),
                  child: AdvButton(
                        "Submit",
                        buttonSize: ButtonSize.large,
                        circular: false,
                        width: MediaQuery.of(context).size.width,
                        onPressed: (){
                              Navigator.pop(context, newValueList);
                        },
                  ),
              )
            ],
          );
        });

  }
}