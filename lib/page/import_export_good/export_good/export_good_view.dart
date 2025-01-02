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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer(); // Mở Drawer
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
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(8),
        color: Colors.white,
        child: Center(
          child: Text("Quản lý vị trí lưu trữ".toUpperCase()),
        ),
      ),
    );
  }
}
