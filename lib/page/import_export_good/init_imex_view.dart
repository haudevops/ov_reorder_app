import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reorder_app/generated/l10n.dart';
import 'package:reorder_app/models/models.dart';
import 'package:reorder_app/page/page.dart';
import 'package:reorder_app/routes/screen_arguments.dart';

class InitImExView extends StatefulWidget {
  const InitImExView({super.key});

  static const routeName = '/InitImExView';

  @override
  State<InitImExView> createState() => _InitImExViewState();
}

class _InitImExViewState extends State<InitImExView> {
  int switchButton = 1;
  POCodeMode? poCodeMode;
  bool selected = false;

  @override
  void initState() {
    super.initState();
    convertData();
  }

  void convertData() async {
    String jsonString = await rootBundle.loadString('lib/data/po_data.json');

    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    setState(() {
      poCodeMode = POCodeMode.fromJson(jsonMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(8),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    width: 50,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Icon(Icons.menu, color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      switchButton = 1;
                      convertData();
                    });
                  },
                  child: Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                        color:
                        switchButton == 1 ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        "Nhập hàng".toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      switchButton = 2;
                      convertData();
                    });
                  },
                  child: Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                        color:
                        switchButton == 2 ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        "Xuất hàng".toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInCubic,
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: selected ? 20 : 0,
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    topLeft: Radius.circular(8),
                                  ),
                                  color: Colors.blue,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: textHeader("STT"),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: textHeader(S.current.po_code),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: textHeader("SKU"),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: textHeader("QTY PLAN"),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: textHeader("QTY ACTUAL"),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: textHeader("ĐVT"),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: textHeader("LOCATION"),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: textHeader("STATUS"),
                                    ),Expanded(
                                      flex: 2,
                                      child: textHeader("PERFORMER"),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: textHeader("ACTUAL RECEIVE"),
                                    ),
                                  ],
                                ),
                              ),
                              poCodeMode != null
                                  ? switchButton == 1
                                  ? ReOrderAbleWidget(
                                  data: ScreenArguments(arg1: poCodeMode)
                              )
                                  : ReOrderAbleExportWidget(
                                  data: ScreenArguments(arg1: poCodeMode)
                              )
                                  : Center(child: CircularProgressIndicator()),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textHeader(String title) {
    return Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ));
  }
}
