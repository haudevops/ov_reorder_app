import 'package:flutter/material.dart';
import 'package:reorder_app/generated/l10n.dart';
import 'package:reorder_app/page/page.dart';
import 'package:reorder_app/widgets/widgets_constant.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = '/HomeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   iconTheme: IconThemeData(color: Colors.black),
        //   elevation: 5,
        // ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(child: WidgetConstant.infoUser()),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  title: Text(S.current.import_and_export_good),
                  onTap: () {
                    onItemTapped(1);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  title: Text(S.current.manage_location),
                  onTap: () {
                    onItemTapped(2);
                  },
                ),
              ),
            ],
          ),
        ),
        body: renderBody(selectedIndex));
  }

  Widget renderBody(int index) {
    switch (index) {
      case 1:
        return ImportGoodView();
      default:
        return ImportGoodView();
    }
  }
}
