import 'package:flutter/material.dart';

//typedef myValidator = String? Function(String?);
class CustomTextFormField extends StatelessWidget {
  String label ;
  TextInputType keyBordType;
  bool isPassword;
  String? Function(String?)  myValidator;
  TextEditingController controller;
  CustomTextFormField({required this.label ,
    this.keyBordType = TextInputType.text ,
    this.isPassword = false ,
    required this.controller,
    required this.myValidator,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          label: Text(label),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 4,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 4,
            ),
          ),
        ),
        keyboardType: keyBordType,
        obscureText: isPassword,
        controller: controller,
        validator: myValidator,
      ),
    );
  }
}
