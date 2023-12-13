import 'package:flutter/material.dart';

import '../../../widgets/text_button.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, required this.onSeeAllClicked});
  final String title;
  final VoidCallback onSeeAllClicked;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
          DefaultTextButton(
            onClick: onSeeAllClicked,
            text: 'See all',
          )
        ],
      ),
    );
  }
}
