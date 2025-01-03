import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reorder_app/generated/l10n.dart';
import 'package:reorder_app/models/models.dart';

class ImportGoodView extends StatefulWidget {
  const ImportGoodView({super.key});

  static const routeName = '/ImportGoodView';

  @override
  State<ImportGoodView> createState() => _ImportGoodViewState();
}

class _ImportGoodViewState extends State<ImportGoodView> {
  POCodeMode? poCodeMode;
  bool selected = false;
  int rowDataLength = 0;
  int switchButton = 1;

  @override
  void initState() {
    convertData();
    super.initState();
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
                            switchButton == 1 ? Colors.blue[100] : Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        "Nhập hàng".toUpperCase(),
                        style: TextStyle(
                            color:
                                switchButton == 1 ? Colors.blue : Colors.white,
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
                            switchButton == 2 ? Colors.blue[50] : Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        "Xuất hàng".toUpperCase(),
                        style: TextStyle(
                            color:
                                switchButton == 2 ? Colors.blue : Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = !selected;
                    });
                  },
                  child: Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(S.current.edit),
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
                                  color: Colors.purple[50],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Center(child: Text("STT")),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(child: Text("Ma PO")),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(child: Text("SKU")),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(child: Text("QTY PLAN")),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(child: Text("QTY ACTUAL")),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(child: Text("ĐVT")),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(child: Text("LOCATION")),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(child: Text("STATUS")),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child:
                                          Center(child: Text("ACTUAL RECEIVE")),
                                    ),
                                  ],
                                ),
                              ),
                              poCodeMode != null
                                  ? switchButton == 1
                                      ? ReOrderAbleWidget(
                                          poCodeMode: poCodeMode!,
                                          onSelectedChange: () {
                                            setState(() {
                                              selected = !selected;
                                            });
                                          },
                                        )
                                      : ReOrderAbleExportWidget(
                                          poCodeMode: poCodeMode!,
                                          onSelectedChange: () {
                                            setState(() {
                                              selected = !selected;
                                            });
                                          },
                                        )
                                  : Center(child: CircularProgressIndicator()),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  // Container Edit
                  SizedBox(
                    width: selected ? 300 : 0,
                    height: selected ? 200 : 0,
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInCubic,
                          top: 0,
                          bottom: 0,
                          left: selected ? 10 : 0,
                          right: 0,
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 500),
                            opacity: selected ? 1.0 : 0.0,
                            child: SizedBox(
                                width: selected ? 300 : 0,
                                height: selected ? 200 : 0,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 30,
                                      color: Colors.purple[50],
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        // children: [
                                        //   Text('Actual Receive'),
                                        //   TextButton(
                                        //       onPressed: () {},
                                        //       child: Text('Save'))
                                        // ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 90,
                                                height: 30,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                child: Center(
                                                    child: Text(
                                                  'Quick Action',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                              ),
                                              Draggable(
                                                data: 'Input qty',
                                                feedback: Container(
                                                  width: 90,
                                                  height: 30,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: ElevatedButton(
                                                    onPressed: () {},
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            WidgetStateProperty
                                                                .all<Color>(Colors
                                                                    .blueAccent)),
                                                    child: Text(
                                                      'Input Qty',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                childWhenDragging: Container(
                                                  width: 90,
                                                  height: 30,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: ElevatedButton(
                                                    onPressed: () {},
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            WidgetStateProperty
                                                                .all<Color>(Colors
                                                                    .blueAccent)),
                                                    child: Text(
                                                      'Input Qty',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                child: Container(
                                                  width: 90,
                                                  height: 30,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: ElevatedButton(
                                                    onPressed: () {},
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            WidgetStateProperty
                                                                .all<Color>(Colors
                                                                    .blueAccent)),
                                                    child: Text(
                                                      'Input Qty',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 90,
                                                height: 30,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                child: ElevatedButton(
                                                  onPressed: () {},
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStateProperty
                                                              .all<Color>(Colors
                                                                  .green)),
                                                  child: Text('Option',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white)),
                                                ),
                                              ),
                                              Container(
                                                width: 90,
                                                height: 30,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                child: ElevatedButton(
                                                  onPressed: () {},
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStateProperty
                                                              .all<Color>(Colors
                                                                  .green)),
                                                  child: Text('Option',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white)),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 90,
                                                height: 30,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                child: Center(
                                                    child: Text(
                                                  'Pick Location',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                              ),
                                              Draggable(
                                                data: 'LA.92',
                                                feedback: Material(
                                                  color: Colors.transparent,
                                                  child: Container(
                                                    width: 90,
                                                    height: 30,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.purple),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: Center(
                                                      child: Text(
                                                        'LA.92',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Colors.purple,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                childWhenDragging: Container(
                                                  width: 90,
                                                  height: 30,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.purple),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Center(
                                                    child: Text(
                                                      'LA.92',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.purple,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                                child: Container(
                                                  width: 90,
                                                  height: 30,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.purple),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Center(
                                                    child: Text(
                                                      'LA.92',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.purple,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Draggable(
                                                data: 'LA.72',
                                                feedback: Container(
                                                  width: 90,
                                                  height: 30,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.purple),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Center(
                                                    child: Text('LA.72',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Colors.purple,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                ),
                                                childWhenDragging: Container(
                                                  width: 90,
                                                  height: 30,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.purple),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Center(
                                                    child: Text('LA.72',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Colors.purple,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                ),
                                                child: Container(
                                                  width: 90,
                                                  height: 30,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.purple),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Center(
                                                    child: Text('LA.72',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Colors.purple,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                ),
                                              ),
                                              Draggable(
                                                data: 'LA.66',
                                                feedback: Container(
                                                  width: 90,
                                                  height: 30,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.purple),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Center(
                                                    child: Text('LA.66',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Colors.purple,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                ),
                                                childWhenDragging: Container(
                                                  width: 90,
                                                  height: 30,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.purple),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Center(
                                                    child: Text('LA.66',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Colors.purple,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                ),
                                                child: Container(
                                                  width: 90,
                                                  height: 30,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.purple),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Center(
                                                    child: Text('LA.66',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Colors.purple,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
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

class ReOrderAbleWidget extends StatefulWidget {
  const ReOrderAbleWidget(
      {super.key, required this.poCodeMode, required this.onSelectedChange});

  final POCodeMode poCodeMode;
  final Function onSelectedChange;

  @override
  State<ReOrderAbleWidget> createState() => _ReOrderAbleWidgetState();
}

class _ReOrderAbleWidgetState extends State<ReOrderAbleWidget>
    with TickerProviderStateMixin {
  List<POCodeMode> items = [];
  List<AnimationController> listController = [];
  List<Animation<Color?>> colorAnimation = [];

  @override
  void initState() {
    initController();
    widget.poCodeMode.poCodeEntity!.removeWhere((e) => e.requestType == 'SO');
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in listController) {
      controller.dispose();
    }
    super.dispose();
  }

  void initController() {
    for (int i = 0; i < 3; i++) {
      var controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
      )..repeat(reverse: true);

      listController.add(controller);
    }

    colorAnimation.addAll([
      ColorTween(
        begin: Colors.red,
        end: Colors.white,
      ).animate(listController[0]),
      ColorTween(
        begin: Colors.yellow,
        end: Colors.white,
      ).animate(listController[1]),
      ColorTween(
        begin: Colors.green,
        end: Colors.white,
      ).animate(listController[2])
    ]);
  }

  Widget buildStatusWidget(int index) {
    String statusText;
    Color textColor;

    if (index == 0) {
      statusText = 'URGENT';
      textColor = Colors.red;
    } else if (index == 1) {
      statusText = 'PENDING';
      textColor = Colors.yellow[700]!;
    } else {
      statusText = 'NEW';
      textColor = Colors.green;
    }

    return Text(
      statusText,
      style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
    );
  }

  void _showQuantityDialog({POCodeEntity? poCodeEntity}) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              Text('Vui lòng nhập số lượng thực nhận'),
              Text(
                '${poCodeEntity?.documentCode}',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nhập số lượng',
            ),
            onSubmitted: (value) {
              setState(() {
                poCodeEntity?.qtyActual = int.parse(value);
              });
              Navigator.of(context).pop();
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  setState(() {
                    final qty = poCodeEntity?.qty;
                    final inputQtyActual =
                        poCodeEntity?.qtyActual = int.parse(controller.text);
                    if (inputQtyActual != null && inputQtyActual >= qty!) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Cảnh báo"),
                            content: Text(
                                "Số lượng thực nhận phải nhỏ hơn hoặc bằng số lượng."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Đóng"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text('Xác nhận'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Container> recordContainer = <Container>[
      for (int index = 0;
          index < widget.poCodeMode.poCodeEntity!.length;
          index += 1)
        Container(
          key: Key('$index'),
          color: Colors.white,
          child: ReorderableDragStartListener(
            index: index,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text("${index + 1}"),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "${widget.poCodeMode.poCodeEntity?[index].documentCode}",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "${widget.poCodeMode.poCodeEntity?[index].sku} - ${widget.poCodeMode.poCodeEntity?[index].skuName}",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "${widget.poCodeMode.poCodeEntity?[index].qty}",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "${widget.poCodeMode.poCodeEntity?[index].qtyActual}",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child:
                          Text("${widget.poCodeMode.poCodeEntity?[index].uom}"),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: DragTarget(
                      onAcceptWithDetails: (data) {
                        setState(() {
                          widget.poCodeMode.poCodeEntity?[index].location =
                              data.data.toString();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Đã thay đổi Location: ${data.data.toString()}')),
                        );
                      },
                      builder: (context, candidateData, rejectData) {
                        return (index == 0 || index == 1 || index == 2)
                            ? AnimatedBuilder(
                                animation: colorAnimation[index],
                                builder: (context, child) {
                                  return Container(
                                    height: 50,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    decoration: BoxDecoration(
                                        color: colorAnimation[index].value,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                      child: Text(
                                          "${widget.poCodeMode.poCodeEntity?[index].location}"),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(
                                      "${widget.poCodeMode.poCodeEntity?[index].location}"),
                                ),
                              );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: buildStatusWidget(index),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.poCodeMode.poCodeEntity?[index]
                                            .qtyActual =
                                        (widget.poCodeMode.poCodeEntity?[index]
                                            .qty);
                                  });
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 18,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.production_quantity_limits,
                                  size: 18,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _showQuantityDialog(
                                      poCodeEntity: widget
                                          .poCodeMode.poCodeEntity?[index]);
                                },
                                child: Icon(
                                  Icons.edit_note,
                                  size: 18,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
    ];

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(1, 6, animValue)!;
          final double scale = lerpDouble(1, 1.02, animValue)!;
          return Transform.scale(
            scale: scale,
            child: Card(
              elevation: elevation,
              color: Colors.deepPurpleAccent[50],
              child: recordContainer[index].child,
            ),
          );
        },
        child: child,
      );
    }

    return ReorderableListView(
      shrinkWrap: true,
      buildDefaultDragHandles: false,
      proxyDecorator: proxyDecorator,
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final POCodeEntity item =
              widget.poCodeMode.poCodeEntity!.removeAt(oldIndex);

          widget.poCodeMode.poCodeEntity!.insert(newIndex, item);
        });
      },
      children: recordContainer,
    );
  }
}

class ReOrderAbleExportWidget extends StatefulWidget {
  const ReOrderAbleExportWidget(
      {super.key, required this.poCodeMode, required this.onSelectedChange});

  final POCodeMode poCodeMode;
  final Function onSelectedChange;

  @override
  State<ReOrderAbleExportWidget> createState() =>
      _ReOrderAbleExportWidgetState();
}

class _ReOrderAbleExportWidgetState extends State<ReOrderAbleExportWidget>
    with TickerProviderStateMixin {
  List<POCodeMode> items = [];
  List<AnimationController> listController = [];
  List<Animation<Color?>> colorAnimation = [];

  @override
  void initState() {
    initController();
    widget.poCodeMode.poCodeEntity!.removeWhere((e) => e.requestType == 'PO');
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in listController) {
      controller.dispose();
    }
    super.dispose();
  }

  void initController() {
    for (int i = 0; i < 3; i++) {
      var controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
      )..repeat(reverse: true);

      listController.add(controller);
    }

    colorAnimation.addAll([
      ColorTween(
        begin: Colors.red,
        end: Colors.white,
      ).animate(listController[0]),
      ColorTween(
        begin: Colors.yellow,
        end: Colors.white,
      ).animate(listController[1]),
      ColorTween(
        begin: Colors.green,
        end: Colors.white,
      ).animate(listController[2])
    ]);
  }

  Widget buildStatusWidget(int index) {
    String statusText;
    Color textColor;

    if (index == 0) {
      statusText = 'URGENT';
      textColor = Colors.red;
    } else if (index == 1) {
      statusText = 'PENDING';
      textColor = Colors.yellow[700]!;
    } else {
      statusText = 'NEW';
      textColor = Colors.green;
    }

    return Text(
      statusText,
      style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
    );
  }

  void _showQuantityDialog({POCodeEntity? poCodeEntity}) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              Text('Vui lòng nhập số lượng thực nhận'),
              Text(
                '${poCodeEntity?.documentCode}',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nhập số lượng',
            ),
            onSubmitted: (value) {
              setState(() {
                poCodeEntity?.qtyActual = int.parse(value);
              });
              Navigator.of(context).pop();
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  setState(() {
                    final qty = poCodeEntity?.qty;
                    final inputQtyActual =
                        poCodeEntity?.qtyActual = int.parse(controller.text);
                    if (inputQtyActual != null && inputQtyActual >= qty!) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Cảnh báo"),
                            content: Text(
                                "Số lượng thực nhận phải nhỏ hơn hoặc bằng số lượng."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Đóng"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text('Xác nhận'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Container> recordContainer = <Container>[
      for (int index = 0;
          index < widget.poCodeMode.poCodeEntity!.length;
          index += 1)
        Container(
          key: Key('$index'),
          color: Colors.white,
          child: ReorderableDragStartListener(
            index: index,
            child: ListTile(
                title: TextButton(
              onPressed: () {
                setState(() {
                  widget.onSelectedChange();
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text("${index + 1}"),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                          "${widget.poCodeMode.poCodeEntity?[index].documentCode}"),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child:
                          Text("${widget.poCodeMode.poCodeEntity?[index].sku}"),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "${widget.poCodeMode.poCodeEntity?[index].qty}",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "${widget.poCodeMode.poCodeEntity?[index].qtyActual}",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child:
                          Text("${widget.poCodeMode.poCodeEntity?[index].uom}"),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: DragTarget(
                      onAcceptWithDetails: (data) {
                        setState(() {
                          widget.poCodeMode.poCodeEntity?[index].location =
                              data.data.toString();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Đã thay đổi Location: ${data.data.toString()}')),
                        );
                      },
                      builder: (context, candidateData, rejectData) {
                        return (index == 0 || index == 1 || index == 2)
                            ? AnimatedBuilder(
                                animation: colorAnimation[index],
                                builder: (context, child) {
                                  return Container(
                                    height: 50,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    decoration: BoxDecoration(
                                        color: colorAnimation[index].value,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                      child: Text(
                                          "${widget.poCodeMode.poCodeEntity?[index].location}"),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(
                                      "${widget.poCodeMode.poCodeEntity?[index].location}"),
                                ),
                              );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: buildStatusWidget(index),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: DragTarget(
                      onAcceptWithDetails: (data) {
                        if (data.data == 'Input qty') {
                          _showQuantityDialog(
                              poCodeEntity:
                                  widget.poCodeMode.poCodeEntity?[index]);
                        }
                      },
                      builder: (context, candidateData, rejectData) {
                        return Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(color: Colors.blue, width: 0.5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.poCodeMode.poCodeEntity?[index]
                                                .qtyActual =
                                            (widget.poCodeMode
                                                .poCodeEntity?[index].qty);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      size: 24,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                  color: Colors.blue,
                                  width: 0.5,
                                ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.production_quantity_limits,
                                      size: 24,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                  color: Colors.blue,
                                  width: 0.5,
                                ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: () {
                                      _showQuantityDialog(
                                          poCodeEntity: widget
                                              .poCodeMode.poCodeEntity?[index]);
                                    },
                                    icon: Icon(
                                      Icons.edit_note,
                                      size: 24,
                                      color: Colors.blue,
                                    ),
                                  ),
                                )
                              ],
                            ));
                      },
                    ),
                  ),
                ],
              ),
            )),
          ),
        ),
    ];

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(1, 6, animValue)!;
          final double scale = lerpDouble(1, 1.02, animValue)!;
          return Transform.scale(
            scale: scale,
            child: Card(
              elevation: elevation,
              color: Colors.deepPurpleAccent[50],
              child: recordContainer[index].child,
            ),
          );
        },
        child: child,
      );
    }

    return ReorderableListView(
      shrinkWrap: true,
      buildDefaultDragHandles: false,
      proxyDecorator: proxyDecorator,
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final POCodeEntity item =
              widget.poCodeMode.poCodeEntity!.removeAt(oldIndex);
          widget.poCodeMode.poCodeEntity!.insert(newIndex, item);
        });
      },
      children: recordContainer,
    );
  }
}
