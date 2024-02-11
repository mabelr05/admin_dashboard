import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email = '';
  String password = '';

//valida los campos
  bool validateForm(){

    if (formKey.currentState!.validate()){
     // print('Form valid ... Login');
      //print('$email === $password');

      return true;
    }else{
     // print('Form not valid');
      return false;
    }
  }
}