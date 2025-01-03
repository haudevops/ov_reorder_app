import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:reorder_app/models/models.dart';
import 'package:reorder_app/routes/screen_arguments.dart';

class ReOrderAbleExportWidget extends StatefulWidget {
  const ReOrderAbleExportWidget({super.key, required this.data});

  static const routeName = '/ReOrderAbleExportWidget';

  final ScreenArguments data;

  @override
  State<ReOrderAbleExportWidget> createState() =>
      _ReOrderAbleExportWidgetState();
}

class _ReOrderAbleExportWidgetState extends State<ReOrderAbleExportWidget>
    with TickerProviderStateMixin {
  List<POCodeMode> items = [];
  POCodeMode? poCodeMode;
  Function? onSelectedChange;
  List<AnimationController> listController = [];
  List<Animation<Color?>> colorAnimation = [];

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
    poCodeMode!.poCodeEntity!.removeWhere((e) => e.requestType == 'PO');
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
      for (int index = 0; index < poCodeMode!.poCodeEntity!.length; index += 1)
        Container(
          key: Key('$index'),
          height: 68,
          color: Colors.white,
          child: ReorderableDragStartListener(
            index: index,
            child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: GestureDetector(
                    onTap: () {
                      setState(() {
                        onSelectedChange;
                      });
                    },
                    child: Column(
                      children: [
                        Row(
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
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  "${poCodeMode!.poCodeEntity?[index].qty}",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  "${poCodeMode!.poCodeEntity?[index].qtyActual}",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                    "${poCodeMode!.poCodeEntity?[index].uom}"),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: DragTarget(
                                onAcceptWithDetails: (data) {
                                  setState(() {
                                    poCodeMode!.poCodeEntity?[index].location =
                                        data.data.toString();
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Đã thay đổi Location: ${data.data.toString()}')),
                                  );
                                },
                                builder: (context, candidateData, rejectData) {
                                  return (index == 0 ||
                                          index == 1 ||
                                          index == 2)
                                      ? AnimatedBuilder(
                                          animation: colorAnimation[index],
                                          builder: (context, child) {
                                            return Container(
                                              height: 50,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 30),
                                              decoration: BoxDecoration(
                                                  color: colorAnimation[index]
                                                      .value,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Center(
                                                child: Text(
                                                    "${poCodeMode!.poCodeEntity?[index].location}"),
                                              ),
                                            );
                                          },
                                        )
                                      : Container(
                                          height: 50,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Center(
                                            child: Text(
                                                "${poCodeMode!.poCodeEntity?[index].location}"),
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
                                              poCodeMode!.poCodeEntity?[index]
                                                      .qtyActual =
                                                  (poCodeMode!
                                                      .poCodeEntity?[index]
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
                                                poCodeEntity: poCodeMode!
                                                    .poCodeEntity?[index]);
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
                        Divider(
                          thickness: 0.15,
                          color: Colors.grey,
                        ),
                      ],
                    ))),
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
        });
      },
      children: recordContainer,
    );
  }
}
