import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/my_theme.dart';
import 'package:flutter_todo_app/task_list/task_widget.dart';

class TaskListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarAgenda(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            print(date);
          },
        ),
        Expanded(
          child: ListView.builder(
              itemBuilder: (context,index){
                return TaskWidget();
              },
            itemCount: 20,
          ),
        ),
      ],
    );
  }
}
