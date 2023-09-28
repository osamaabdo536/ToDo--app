import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/my_theme.dart';
import 'package:flutter_todo_app/providers/app_config_provider.dart';
import 'package:flutter_todo_app/task_list/task_edit.dart';
import 'package:flutter_todo_app/task_list/task_widget.dart';
import 'package:provider/provider.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<AppConfigProvider>(context);
    if(listProvider.taskList.isEmpty){
      listProvider.getAllTasksFromFireStore();
    }
    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) => print(date),
          leftMargin: 20,
          monthColor: MyTheme.blackColor,
          dayColor: MyTheme.blackColor,
          activeDayColor: MyTheme.whiteColor,
          activeBackgroundDayColor: Theme.of(context).primaryColor,
          dotsColor: MyTheme.whiteColor,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        Expanded(
          child: ListView.builder(
              itemBuilder: (context,index){
                return InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed(TaskEdit.routeName);
                  },
                    child: TaskWidget(task: listProvider.taskList[index])
                );
              },
            itemCount: listProvider.taskList .length,
          ),
        ),
      ],
    );
  }
}
