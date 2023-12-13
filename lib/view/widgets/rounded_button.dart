import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  late String text;
  late VoidCallback? onClick;
  bool? visible;
  double? padding;

  RoundedButton({
    Key? key,
    required this.text,
    required this.onClick,
    this.visible = true,
    this.padding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: visible! ? onClick : () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
      child: visible!
          ? Padding(
              padding: EdgeInsets.all(padding != null ? padding! : 20),
              child: Text(text),
            )
          : const Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
    );
  }
}
