import 'package:flutter/material.dart';

class FiltersButton extends StatelessWidget {
  const FiltersButton({super.key, required this.onClick});
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 3),
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(16)),
          child: SizedBox(
              width: 20,
              height: 20,
              child: Image.asset('assets/images/options_icon.png')),
        ),
      ),
    );
  }
}
