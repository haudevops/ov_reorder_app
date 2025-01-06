import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:reorder_app/generated/l10n.dart';
import 'package:reorder_app/models/models.dart';
import 'package:reorder_app/page/page.dart';
import 'package:reorder_app/routes/screen_arguments.dart';

class ReOrderAbleWidget extends StatefulWidget {
  const ReOrderAbleWidget(
      {super.key, required this.data, this.onSelectedChange});

  static const routeName = '/ReOrderAbleWidget';

  final ScreenArguments data;
  final Function? onSelectedChange;

  @override
  State<ReOrderAbleWidget> createState() => _ReOrderAbleWidgetState();
}

class _ReOrderAbleWidgetState extends State<ReOrderAbleWidget>
    with TickerProviderStateMixin {
  List<POCodeMode> items = [];
  List<AnimationController> listController = [];
  List<Animation<Color?>> colorAnimation = [];
  POCodeEntity? poCodeEntity;
  POCodeMode? poCodeMode;
  List<TimeLineModel> timeLine = [];

  @override
  void initState() {
    initController();
    poCodeMode = widget.data.arg1;
    initData();
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in listController) {
      controller.dispose();
    }
    super.dispose();
  }

  void initData() {
    poCodeMode!.poCodeEntity!.removeWhere((e) => e.requestType == 'SO');
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

  Widget buildStatusWidget(int index, {bool isComplete = false}) {
    String statusText;
    Color textColor;

    if (index == 0 && !isComplete) {
      statusText = 'URGENT';
      textColor = Colors.red;
    } else if (index == 1 && !isComplete) {
      statusText = 'PENDING';
      textColor = Colors.yellow[700]!;
    } else if (!isComplete) {
      statusText = 'NEW';
      textColor = Colors.blue;
    } else {
      statusText = 'COMPLETE';
      textColor = Colors.green;
    }

    return Text(
      statusText,
      style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
    );
  }

  void _showQuantityDialog({POCodeEntity? poCodeEntity, int? index}) {
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
                final qty = poCodeEntity?.qty;
                final inputQtyActual = int.parse(controller.text);

                if (inputQtyActual == qty) {
                  POCodeEntity firstElement =
                      poCodeMode!.poCodeEntity!.removeAt(index!);
                  firstElement.status = "COMPLETE";
                  firstElement.qtyActual = inputQtyActual;
                  poCodeMode!.poCodeEntity!.add(firstElement);
                  timeLine.add(TimeLineModel(
                      title: 'Cập nhật PO',
                      content:
                          'Đơn ${firstElement.documentCode} hoàn thành Pallet',
                      dateTime: DateFormat('yyyy/MM/dd HH:mm:ss')
                          .format(DateTime.now()),
                      documentCode: firstElement.documentCode));
                } else if (inputQtyActual >= qty!) {
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

                  timeLine.add(TimeLineModel(
                      title: 'Cập nhật PO',
                      content:
                          'Admin cập nhật sai Pallet - ${poCodeMode!.poCodeEntity![index!].documentCode}',
                      dateTime: DateFormat('yyyy/MM/dd HH:mm:ss')
                          .format(DateTime.now()),
                      documentCode:
                          poCodeMode!.poCodeEntity![index].documentCode));
                } else {
                  poCodeEntity?.qtyActual = int.parse(controller.text);
                  timeLine.add(TimeLineModel(
                      title: 'Cập nhật PO',
                      content:
                          'Admin cập nhật ${int.parse(controller.text)} thùng cho ${poCodeMode!.poCodeEntity![index!].documentCode}',
                      dateTime: DateFormat('yyyy/MM/dd HH:mm:ss')
                          .format(DateTime.now()),
                      documentCode:
                          poCodeMode!.poCodeEntity![index].documentCode));
                }
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
                  final qty = poCodeEntity?.qty;
                  final inputQtyActual = int.parse(controller.text);

                  if (inputQtyActual == qty) {
                    POCodeEntity firstElement =
                        poCodeMode!.poCodeEntity!.removeAt(index!);
                    firstElement.status = "COMPLETE";
                    firstElement.qtyActual = inputQtyActual;
                    poCodeMode!.poCodeEntity!.add(firstElement);

                    timeLine.add(TimeLineModel(
                        title: 'Cập nhật PO',
                        content:
                            'Đơn ${firstElement.documentCode} hoàn thành Pallet',
                        dateTime: DateFormat('yyyy/MM/dd HH:mm:ss')
                            .format(DateTime.now()),
                        documentCode: firstElement.documentCode));
                  } else if (inputQtyActual >= qty!) {
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

                    timeLine.add(TimeLineModel(
                        title: 'Cập nhật PO',
                        content:
                            'Admin cập nhật sai Pallet - ${poCodeMode!.poCodeEntity![index!].documentCode}',
                        dateTime: DateFormat('yyyy/MM/dd HH:mm:ss')
                            .format(DateTime.now()),
                        documentCode:
                            poCodeMode!.poCodeEntity![index].documentCode));
                  } else {
                    poCodeEntity?.qtyActual = int.parse(controller.text);
                    timeLine.add(TimeLineModel(
                        title: 'Cập nhật PO',
                        content:
                            'Admin cập nhật ${int.parse(controller.text)} thùng cho ${poCodeMode!.poCodeEntity![index!].documentCode}',
                        dateTime: DateFormat('yyyy/MM/dd HH:mm:ss')
                            .format(DateTime.now()),
                        documentCode:
                            poCodeMode!.poCodeEntity![index].documentCode));
                  }
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

  void _showEditDialog({POCodeEntity? poCodeEntity, int? index}) {
    final TextEditingController requestQtyController = TextEditingController();
    final TextEditingController pickerController = TextEditingController();

    if (poCodeEntity!.qtyActual != 0) {
      requestQtyController.text = poCodeEntity.qtyActual.toString();
    }

    showDialog(
      context: context,
      builder: (buildContext) {
        return Dialog(
          child: SizedBox(
              width: 400,
              height: 520,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                          child: Text(
                        'Thông tin cần điều chỉnh'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.w600),
                      )),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Table(
                        columnWidths: const <int, TableColumnWidth>{
                          0: IntrinsicColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FixedColumnWidth(34),
                        },
                        children: [
                          _itemWidget(
                              title: S.current.po_code,
                              widget: Container(
                                height: 45,
                                width: double.infinity,
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    poCodeEntity.documentCode ?? "",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )),
                          _itemWidget(
                              title: S.current.sku,
                              widget: Container(
                                height: 45,
                                width: double.infinity,
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    poCodeEntity?.sku ?? "",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.orange),
                                  ),
                                ),
                              )),
                          _itemWidget(
                              title: S.current.sku_name,
                              widget: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    poCodeEntity.skuName ?? "",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.orange),
                                  ),
                                ),
                              )),
                          _itemWidget(
                              title: S.current.uom,
                              widget: Container(
                                height: 45,
                                width: double.infinity,
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    poCodeEntity.uom ?? "",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )),
                          _itemWidget(
                              title: S.current.qty_plan,
                              widget: Container(
                                height: 45,
                                width: double.infinity,
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${poCodeEntity.qty}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red),
                                  ),
                                ),
                              )),
                          _itemWidget(
                              title: S.current.virtual_qty,
                              widget: Container(
                                width: double.infinity,
                                height: 45,
                                margin: EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  controller: requestQtyController,
                                  decoration: InputDecoration(
                                    hintText: 'Nhập số',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400),
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  onFieldSubmitted: (value) {},
                                  onTapOutside: (event) {},
                                  onChanged: (value) {},
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                  ),
                                ),
                              )),
                          _itemWidget(
                              title: S.current.transfer_performer,
                              widget: Container(
                                width: double.infinity,
                                height: 45,
                                margin: EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  controller: pickerController,
                                  decoration: InputDecoration(
                                    hintText: poCodeEntity.picker,
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400),
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  onFieldSubmitted: (value) {},
                                  onTapOutside: (event) {},
                                  onChanged: (value) {},
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(buildContext);
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey),
                                child: Center(
                                  child: Text(
                                    'Huỷ'.toUpperCase(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(buildContext);
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.blue),
                                child: Center(
                                  child: Text('Xác nhận'.toUpperCase(),
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
        );
      },
    ).then((value) {
      setState(() {
        if (RegExp(r'^\d+$').hasMatch(requestQtyController.text) &&
            int.parse(requestQtyController.text) <= poCodeEntity.qty! &&
            int.parse(requestQtyController.text) != poCodeEntity.qtyActual!) {
          poCodeMode!.poCodeEntity![index!].qtyActual =
              int.parse(requestQtyController.text);
          timeLine.add(TimeLineModel(
              title: 'Điều chỉnh PO',
              content:
                  'Admin cập nhật số lượng ${int.parse(requestQtyController.text)} cho ${poCodeMode!.poCodeEntity![index].documentCode}',
              dateTime:
                  DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.now()),
              documentCode: poCodeMode!.poCodeEntity![index].documentCode));
        }

        if (pickerController.text != poCodeEntity.picker &&
            pickerController.text.isNotEmpty) {
          poCodeMode!.poCodeEntity![index!].picker = pickerController.text;
          timeLine.add(TimeLineModel(
              title: 'Điều chỉnh PO',
              content:
                  'Điều chuyển Picker ${poCodeMode!.poCodeEntity![index].picker} cho ${poCodeMode!.poCodeEntity![index].documentCode}',
              dateTime:
                  DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.now()),
              documentCode: poCodeMode!.poCodeEntity![index].documentCode));
        }
      });
    });
  }

  void _showQRCodeDialog({POCodeEntity? poCodeEntity}) {
    showDialog(
      context: context,
      builder: (buildContext) {
        return Dialog(
          child: SizedBox(
              width: 400,
              height: 350,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      QrImageView(
                        data: "${poCodeEntity?.sku} - ${poCodeEntity?.skuName}",
                        version: QrVersions.auto,
                        size: 250,
                        padding: EdgeInsets.zero,
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          "${poCodeEntity?.sku} - ${poCodeEntity?.skuName}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ))),
        );
      },
    );
    setState(() {
      timeLine.add(TimeLineModel(
          title: 'Yêu cầu QRCode',
          content: 'Admin yêu cầu QRCode của ${poCodeEntity?.documentCode}',
          dateTime: DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.now()),
          documentCode: poCodeEntity?.documentCode));
    });
  }

  void _showOTPDialog({POCodeEntity? poCodeEntity}) {
    showDialog(
      context: context,
      builder: (buildContext) {
        return Dialog(
          child: SizedBox(
              width: 400,
              height: 200,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          "Mã OTP của bạn".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 25),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          "1  4  3  6",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 40,
                              color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ))),
        );
      },
    );
    setState(() {
      timeLine.add(TimeLineModel(
          title: 'Yêu cầu OTP',
          content: 'Admin yêu cầu OTP của ${poCodeEntity?.documentCode}',
          dateTime: DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.now()),
          documentCode: poCodeEntity?.documentCode));
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Container> recordContainer = <Container>[
      for (int index = 0; index < poCodeMode!.poCodeEntity!.length; index += 1)
        Container(
          height: 60,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          key: Key('$index'),
          color: Colors.white,
          child: ReorderableDragStartListener(
            index: index,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 0.3),
                    bottom: BorderSide(color: Colors.grey, width: 0.3),
                  ),
                ),
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
                          "${poCodeMode!.poCodeEntity?[index].documentCode}",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "${poCodeMode!.poCodeEntity?[index].sku} - ${poCodeMode!.poCodeEntity?[index].skuName}",
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
                          "${poCodeMode!.poCodeEntity?[index].qty}",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          "${poCodeMode!.poCodeEntity?[index].qtyActual}",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text("${poCodeMode!.poCodeEntity?[index].uom}"),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: (poCodeMode!.poCodeEntity?[index].status !=
                                  'COMPLETE' &&
                              (index == 0 || index == 1 || index == 2))
                          ? AnimatedBuilder(
                              animation: colorAnimation[index],
                              builder: (context, child) {
                                return Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 30),
                                  decoration: BoxDecoration(
                                      color: colorAnimation[index].value,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text(
                                        "${poCodeMode!.poCodeEntity?[index].location}"),
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
                                    "${poCodeMode!.poCodeEntity?[index].location}"),
                              ),
                            ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: buildStatusWidget(index,
                            isComplete:
                                poCodeMode!.poCodeEntity?[index].status ==
                                    "COMPLETE"),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          "${poCodeMode!.poCodeEntity?[index].picker}",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      poCodeMode!
                                              .poCodeEntity?[index].qtyActual =
                                          (poCodeMode!
                                              .poCodeEntity?[index].qty);
                                      POCodeEntity firstElement = poCodeMode!
                                          .poCodeEntity!
                                          .removeAt(index);
                                      firstElement.status = "COMPLETE";
                                      poCodeMode!.poCodeEntity!
                                          .add(firstElement);

                                      timeLine.add(TimeLineModel(
                                          title: 'Cập nhật PO',
                                          content:
                                              'Đơn ${firstElement.documentCode} hoàn thành Pallet',
                                          dateTime:
                                              DateFormat('yyyy/MM/dd HH:mm:ss')
                                                  .format(DateTime.now()),
                                          documentCode:
                                              firstElement.documentCode));
                                    });
                                  },
                                  child: Icon(
                                    Icons.inventory_outlined,
                                    size: 18,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _showQRCodeDialog(
                                        poCodeEntity:
                                            poCodeMode!.poCodeEntity?[index]);
                                  },
                                  child: Icon(
                                    Icons.qr_code,
                                    size: 18,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _showOTPDialog(
                                        poCodeEntity:
                                            poCodeMode!.poCodeEntity?[index]);
                                  },
                                  child: Icon(
                                    Icons.password,
                                    size: 18,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   child: GestureDetector(
                              //     onTap: () {},
                              //     child: Icon(
                              //       Icons.production_quantity_limits,
                              //       size: 18,
                              //       color: Colors.blue,
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _showQuantityDialog(
                                        poCodeEntity:
                                            poCodeMode!.poCodeEntity?[index],
                                        index: index);
                                  },
                                  child: Icon(
                                    Icons.edit_note,
                                    size: 18,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: timeLine.any((e) =>
                                    e.documentCode ==
                                    poCodeMode!
                                        .poCodeEntity?[index].documentCode),
                                child: Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      List<TimeLineModel> timeLineData = [];
                                      timeLineData.addAll(timeLine);

                                      for (final i in timeLineData) {
                                        if (i.documentCode !=
                                            poCodeMode!.poCodeEntity?[index]
                                                .documentCode) {
                                          timeLineData.remove(i);
                                        }
                                      }

                                      showDialog(
                                          context: context,
                                          builder: (buildContext) {
                                            return TimeLineView(
                                              data: ScreenArguments(
                                                  arg1: timeLineData),
                                            );
                                          });
                                    },
                                    child: Icon(
                                      Icons.history,
                                      size: 18,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              onTap: () {
                _showEditDialog(
                    poCodeEntity: poCodeMode!.poCodeEntity?[index],
                    index: index);
              },
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
              poCodeMode!.poCodeEntity!.removeAt(oldIndex);

          poCodeMode!.poCodeEntity!.insert(newIndex, item);
          timeLine.add(TimeLineModel(
              title: 'Thay đổi độ ưu tiên của đơn đơn',
              content:
                  'Admin thay đổi ưu tiên đơn ${item.documentCode} vào vị trí $newIndex',
              dateTime:
                  DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.now()),
              documentCode: item.documentCode));
        });
      },
      children: recordContainer,
    );
  }

  TableRow _itemWidget({required String title, required Widget widget}) {
    return TableRow(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child:
            Text('$title:', style: TextStyle(fontSize: 14, color: Colors.grey)),
      ),
      Padding(padding: EdgeInsets.symmetric(vertical: 4), child: widget)
    ]);
  }
}
