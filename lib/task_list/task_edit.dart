import 'package:flutter/material.dart';
import 'package:flutter_todo_app/my_theme.dart';
import 'package:provider/provider.dart';
import '../providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskEdit extends StatefulWidget {
  static const String routeName = 'Task Edit';
  @override
  State<TaskEdit> createState() => _TaskEditState();
}

class _TaskEditState extends State<TaskEdit> {
  DateTime selectedDate = DateTime.now();
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
      body: Container(
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.2,
            top: MediaQuery.of(context).size.height * 0.02,
            right: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.height * 0.02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: provider.isDarkMode()?
              MyTheme.darkBlackColor
              :MyTheme.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Edit Task' ,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (text){
                  if(text == null || text.isEmpty){
                    return AppLocalizations.of(context)!.enter_title;
                  }
                  return null ;
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
                validator: (text){
                  if(text == null || text.isEmpty){
                    return AppLocalizations.of(context)!.enter_details;
                  }
                  return null ;
                },
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.task_details,
                  hintStyle: TextStyle(
                    color: provider.isDarkMode()
                        ? MyTheme.whiteColor
                        : MyTheme.blackColor,
                  ),
                ),
                maxLength: 4,
              ),
            ),
            Text(AppLocalizations.of(context)!.select_date ,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            InkWell(
                onTap: (){
                  showCalender();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${selectedDate.day}/${selectedDate.month}/${selectedDate.year}' ,
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                )
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
              },
              child: Text(AppLocalizations.of(context)!.save_changes , style: Theme.of(context).textTheme.titleLarge,),
            ),
          ],
        ),
      ),
    );
  }

  void showCalender() async{
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if(chosenDate != null){
      selectedDate = chosenDate ;
      setState(() {

      });
    }
  }
}
