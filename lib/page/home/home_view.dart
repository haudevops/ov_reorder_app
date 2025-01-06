import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorder_app/generated/l10n.dart';
import 'package:reorder_app/page/page.dart';
import 'package:reorder_app/utils/constants.dart';
import 'package:reorder_app/utils/providers/language_provider.dart';
import 'package:reorder_app/widgets/widgets_constant.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = '/HomeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
  bool change_language = false;
  bool isEnglish = true;

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
              ListTile(
                contentPadding: EdgeInsets.zero,
                selected: selectedIndex == 0,
                title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(S.current.import_and_export_good),
                ),
                onTap: () {
                  onItemTapped(0);
                },
              ),
              ListTile(
                  contentPadding: EdgeInsets.zero,
                  selected: selectedIndex == 1,
                  title: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<bool>(
                        padding: EdgeInsets.zero,
                        // borderRadius: BorderRadius.circular(8),
                        value: change_language,
                        items: [
                          DropdownMenuItem(
                            value: true,
                            child: Text('English'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Tiếng Việt'),
                          ),
                        ],
                        onChanged: (value) {
                          final provider = Provider.of<LanguageProvider>(
                              context,
                              listen: false);
                          change_language = !change_language;
                          provider.changeLocale(change_language
                              ? Constants.ENGLISH
                              : Constants.VIETNAMESE);
                        },
                        // dropdownColor: Colors.blue[100],
                        // Màu của menu
                      ),
                    ),
                  ),
                  onTap: () {
                    onItemTapped(1);
                  }),
              // ListTile(
              //   contentPadding: EdgeInsets.zero,
              //   title: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 20),
              //     child:
              //   ),
              // )
            ],
          ),
        ),
        body: renderBody(selectedIndex));
  }

  Widget renderBody(int index) {
    switch (index) {
      default:
        return InitImExView();
    }
  }
}
