import 'package:flutter/material.dart';


class CustomInputs {

  static InputDecoration loginInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }){
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.3))
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: const Color.fromARGB(255, 1, 18, 92).withOpacity(0.3))
      ),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon( icon, color: const Color.fromARGB(160, 41, 39, 55) ),
      labelStyle: const TextStyle( color: Color.fromARGB(84, 48, 38, 71) ),
      hintStyle: const TextStyle( color: Color.fromARGB(84, 48, 38, 71) ),
    );
  }

  static InputDecoration searchInputDecoration({
    required String hint,
    required IconData icon
  }) {
    return InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      hintText: hint,
      prefixIcon: Icon( icon, color:Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey)
    );
  }


  static InputDecoration formInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }){
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.indigo.withOpacity(0.3))
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.indigo.withOpacity(0.3))
      ),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon( icon, color: Colors.grey ),
      labelStyle: const TextStyle( color: Colors.grey ),
      hintStyle: const TextStyle( color: Colors.grey ),
    );
  }
}