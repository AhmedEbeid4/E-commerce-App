import 'package:e_commerce/core/extensions.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, required this.onTextChanged});
  final void Function(String?) onTextChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.1)),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 50.0,
          )
        ],
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            child: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset('assets/images/search_icon.png')),
          ),
          10.wi,
          Expanded(
            flex: 1,
            child: TextFormField(
              onChanged: onTextChanged,
              // onChanged: onTextChanged,
              cursorColor: const Color.fromRGBO(169, 169, 169, 1),
              style: const TextStyle(color: Color.fromRGBO(96, 96, 96, 1)),
              decoration: const InputDecoration(
                hintText: 'Product Name',
                hintStyle: TextStyle(color: Color.fromRGBO(169, 169, 169, 1)),
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
