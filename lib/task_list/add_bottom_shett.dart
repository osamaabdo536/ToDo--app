import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_todo_app/firebase_utils.dart';
import 'package:flutter_todo_app/model/task.dart';
import 'package:flutter_todo_app/my_theme.dart';
import 'package:flutter_todo_app/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late AppConfigProvider listProvider;
  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.add_new_task,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (text){
                      title = text ;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return AppLocalizations.of(context)!.enter_title;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.task_title,
                      hintStyle: TextStyle(
                        color: provider.isDarkMode()
                            ? MyTheme.whiteColor
                            : MyTheme.blackColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (text){
                      description = text ;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return AppLocalizations.of(context)!.enter_details;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.task_details,
                      hintStyle: TextStyle(
                        color: provider.isDarkMode()
                            ? MyTheme.whiteColor
                            : MyTheme.blackColor,
                      ),
                    ),
                    maxLines: 4,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.select_date,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                InkWell(
                    onTap: () {
                      showCalender();
                    },
                    child: Text(
                      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    )),
                ElevatedButton(
                  onPressed: () {
                    addTask();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.add,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      Task task = Task(
          title: title,
          description: description,
          dateTime: selectedDate
      );
      FirebaseUtils.addTaskToFirebase(task).timeout(
        Duration(milliseconds: 500),onTimeout: (){
          print('ToDo added successfully');
          listProvider.getAllTasksFromFireStore();
          Navigator.pop(context);
      }
      );
    }
  }
}
