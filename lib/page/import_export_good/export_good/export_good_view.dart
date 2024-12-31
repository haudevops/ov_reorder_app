import 'package:flutter/material.dart';

class ExportGoodView extends StatefulWidget {
  const ExportGoodView({super.key});

  static const routeName = '/ExportGoodView';

  @override
  State<ExportGoodView> createState() => _ExportGoodViewState();
}

class _ExportGoodViewState extends State<ExportGoodView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(8),
        color: Colors.deepPurpleAccent[50],
        child: Center(
          child: Text("Page 2".toUpperCase()),
        ),
      ),
    );
  }
}
