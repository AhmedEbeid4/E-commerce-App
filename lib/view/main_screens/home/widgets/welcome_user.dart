import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final VoidCallback onImageClicked;

  const WelcomeWidget({super.key, this.imageUrl, required this.name, required this.onImageClicked});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome,',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(name,
                style: TextStyle(
                    fontSize: 18, color: Theme.of(context).primaryColor))
          ],
        ),
        GestureDetector(
          onTap: onImageClicked,
          child: SizedBox(
            height: 50,
            width: 50,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: imageUrl != null
                  ? FadeInImage(
                      fit: BoxFit.cover,
                      placeholder:
                          const AssetImage("assets/images/profile_icon.png"),
                      image: NetworkImage(imageUrl!))
                  : Image.asset("assets/images/profile_icon.png"),
            ),
          ),
        )
      ],
    );
  }
}
