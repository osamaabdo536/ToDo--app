import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebase_utils.dart';
import '../model/task.dart';

class AppConfigProvider extends ChangeNotifier{
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;
  List<Task> taskList = [];

  void changeLanguage(String newLanguage){
    if(appLanguage == newLanguage){
      return ;
    }
    appLanguage = newLanguage ;
    notifyListeners();
  }

  void changeTheme(ThemeMode newMode){
    if(appTheme == newMode){
      return ;
    }
    appTheme = newMode;
    notifyListeners();
  }

  bool isDarkMode(){
    return appTheme == ThemeMode.dark;
  }


  void getAllTasksFromFireStore()async{
    QuerySnapshot<Task> querySnapshot = await FirebaseUtils.getTasksCollection().get();
    taskList = querySnapshot.docs.map((doc) {
      return  doc.data();
    }).toList();
    notifyListeners();
  }
}