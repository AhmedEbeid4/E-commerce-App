import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final Function(int) onChange;
  final int index;

  const BottomNavBar({super.key, required this.onChange, required this.index});

  @override
  Widget build(BuildContext context) {
    return BottomBarInspiredOutside(
        items: const [
          TabItem(
            icon: Icons.home,
            title: 'Home',
          ),
          TabItem(
            icon: Icons.search_sharp,
            title: 'Explore',
          ),
          TabItem(
            icon: Icons.shopping_cart_outlined,
            title: 'Cart',
          ),
          TabItem(
            icon: Icons.favorite_border,
            title: 'Wishlist',
          ),
          TabItem(
            icon: Icons.account_box,
            title: 'Profile',
          ),
        ],
        backgroundColor: Colors.white,
        color: Colors.grey,
        indexSelected: index,
        onTap: onChange,
        animated: true,
        fixed: true,
        fixedIndex: 2,
        itemStyle: ItemStyle.hexagon,
        chipStyle: ChipStyle(
            drawHexagon: true, background: Theme.of(context).primaryColor),
        colorSelected: Colors.white);
  }
}
