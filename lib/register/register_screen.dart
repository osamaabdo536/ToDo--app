import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/components/custom_text_form_filed.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'registerScreen';
  var nameController = TextEditingController(text: 'osama');
  var emailController = TextEditingController(text: 'osama@route.com');
  var passwordController = TextEditingController(text: '123456');
  var confirmationPasswordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/main_background.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.55,
                  ),
                  CustomTextFormField(
                    label: 'User Name',
                    controller: nameController,
                    myValidator: (text){
                      if(text == null || text.trim().isEmpty){
                        return 'Please enter userName';
                      }
                      return null ;
                    },
                  ),
                  CustomTextFormField(
                    label: 'Email Address',
                    controller: emailController,
                    myValidator: (text){
                      if(text == null || text.trim().isEmpty){
                        return 'Please enter email Address';
                      }
                      bool emailValid =
                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if(!emailValid){
                        return 'Please enter valid email ';
                      }
                      return null ;
                    },
                  ),
                  CustomTextFormField(
                    label: 'Password',
                    controller: passwordController,
                    isPassword: true ,
                    keyBordType: TextInputType.number,
                    myValidator: (text){
                      if(text == null || text.trim().isEmpty){
                        return 'Please enter password';
                      }
                      if(text.length < 6){
                        return 'password should be at least 6 chars.';
                      }
                      return null ;
                    },
                  ),
                  CustomTextFormField(
                    label: 'Confirmation Password',
                    controller: confirmationPasswordController,
                    isPassword: true ,
                    keyBordType: TextInputType.number,
                    myValidator: (text){
                      if(text == null || text.trim().isEmpty){
                        return 'Please enter confirmationPassword';
                      }
                      if(text != passwordController.text){
                        return "password doesn't match";
                      }
                      return null ;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                        onPressed: (){
                         register();
                        },
                        child: Text('Register' ,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void register() async{
    if(formKey.currentState?.validate() == true){
       try {
       final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: emailController.text,
       password: passwordController.text,
       );
       print('account added successfully');
       print(credential.user?.uid ?? '');
       } on FirebaseAuthException catch (e) {
         if (e.code == 'weak-password') {
           print('The password provided is too weak.');
         } else if (e.code == 'email-already-in-use') {
           print('The account already exists for that email.');
         }
       } catch (e) {
         print('error: ${e.toString()}');
       }
    }
  }
}
