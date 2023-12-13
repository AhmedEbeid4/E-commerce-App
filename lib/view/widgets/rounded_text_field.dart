import 'package:flutter/material.dart';


class RoundedTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController textEditingController;
  TextInputType? inputType;
  bool? obscureText;
  IconData? suffixIcon;
  Function()? onClickSuffixIcon;

  RoundedTextField(
      {super.key, this.hintText, this.inputType = TextInputType.text, this.obscureText = false, this.onClickSuffixIcon,this.suffixIcon,required this.textEditingController, this.labelText});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return TextField(
      controller: textEditingController,
      obscureText: obscureText ?? false,
      keyboardType: inputType,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          suffixIcon: IconButton(color: primaryColor , onPressed: onClickSuffixIcon, icon: Icon(suffixIcon)),
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: primaryColor, width: 1.5)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: primaryColor, width: 1.9))),
    );
  }
}