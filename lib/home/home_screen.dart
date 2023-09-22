import 'package:flutter/material.dart';
import 'package:flutter_todo_app/my_theme.dart';
import 'package:flutter_todo_app/providers/app_config_provider.dart';
import 'package:flutter_todo_app/settings/settings.dart';
import 'package:flutter_todo_app/task_list/add_bottom_shett.dart';
import 'package:flutter_todo_app/task_list/task_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.app_title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {

            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: AppLocalizations.of(context)!.task_list),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: AppLocalizations.of(context)!.settings),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        shape: StadiumBorder(
          side: BorderSide(
            width: 6,
            color: provider.isDarkMode()?
                MyTheme.darkBlackColor
            :MyTheme.whiteColor,
          ),
        ),
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [
    TaskListTab(),
    SettingsTab(),
  ];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddTaskBottomSheet(),
    );
  }
}
