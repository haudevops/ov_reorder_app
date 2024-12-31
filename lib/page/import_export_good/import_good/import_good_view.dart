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
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  S.current.import_and_export_good,
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8)),
                  color: Colors.purple[50],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(child: Text("STT"),),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(child: Text("Ma PO"),),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(child: Text("SKU"),),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(child: Text("QTY"),),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(child: Text("ĐVT"),),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(child: Text("LOCATION"),),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(child: Text("ACTUAL RECEIVE"),),
                    ),
                  ],
                ),
              ),
              poCodeMode != null ? Expanded(
                child: ReOrderAbleWidget(poCodeMode: poCodeMode!)
              ) : Center(child: const CircularProgressIndicator())
            ],
          )),
    );
  }
}

class ReOrderAbleWidget extends StatefulWidget {
  const ReOrderAbleWidget({super.key, required this.poCodeMode});

  final POCodeMode poCodeMode;

  @override
  State<ReOrderAbleWidget> createState() => _ReOrderAbleWidgetState();
}

class _ReOrderAbleWidgetState extends State<ReOrderAbleWidget> {
  List<POCodeMode> items = [];

  @override
  void initState() {
    widget.poCodeMode.poCodeEntity!.removeWhere((e) => e.requestType == 'SO');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Container> recordContainer = <Container>[
      for (int index = 0; index < widget.poCodeMode.poCodeEntity!.length; index += 1)
        Container(
          key: Key('$index'),
          color: Colors.white,
          child: ReorderableDragStartListener(
            index: index,
            child: ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(child: Text("${index + 1}"),),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(child: Text("${widget.poCodeMode.poCodeEntity?[index].documentCode}"),),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(child: Text("${widget.poCodeMode.poCodeEntity?[index].sku}"),),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(child: Text("${widget.poCodeMode.poCodeEntity?[index].qty}"),),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(child: Text("${widget.poCodeMode.poCodeEntity?[index].uom}"),),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(child: Text("${widget.poCodeMode.poCodeEntity?[index].location}"),),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(child: Text("${widget.poCodeMode.poCodeEntity?[index].actualReceive}"),),
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
            // Create a Card based on the color and the content of the dragged one
            // and set its elevation to the animated value.
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
          final POCodeEntity item = widget.poCodeMode.poCodeEntity!.removeAt(oldIndex);
          widget.poCodeMode.poCodeEntity!.insert(newIndex, item);
        });
      },
      children: recordContainer,
    );
  }
}
