import 'package:flutter/material.dart';

extension Space on num{
  SizedBox get he => SizedBox(height: toDouble(),);
  SizedBox get wi => SizedBox(width: toDouble(),);
}

extension StringExtensions on String {
  bool isValidEmail() {
    final emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    return emailRegex.hasMatch(this);
  }
  bool isNumber() {
    final numberRegex = RegExp(r'^\d+$');
    return numberRegex.hasMatch(this);
  }
}