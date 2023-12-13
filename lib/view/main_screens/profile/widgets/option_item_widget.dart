import 'package:e_commerce/core/extensions.dart';
import 'package:flutter/material.dart';

class OptionItem extends StatelessWidget {
  const OptionItem({super.key, required this.title, required this.icon, required this.arrowVisible, required this.onClick});
  final String title;
  final IconData icon;
  final bool arrowVisible;
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 70.0,
            )
          ],
        ),
        child: Row(
          children: [
            15.wi,
            Icon(
              icon,
              size: 20,
            ),
            10.wi,
            Text(title),

            const Expanded(child: SizedBox()),
            if(arrowVisible)
              Icon(Icons.arrow_forward_ios,
                  size: 20, color: Theme.of(context).primaryColor),
            10.wi
          ],
        ),
      ),
    );
  }
}
