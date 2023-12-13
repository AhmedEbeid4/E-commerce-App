import 'package:flutter/material.dart';

class DefaultRadioButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onClick;
  const DefaultRadioButton(
      {super.key, required this.text, required this.isSelected, required this.onClick});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
        decoration: BoxDecoration(
          color: isSelected? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1.8, color: primaryColor),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: isSelected ? Colors.white : primaryColor),
          ),
        ),
      ),
    );
  }
}
