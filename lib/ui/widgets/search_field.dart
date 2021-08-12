import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          onChanged: (value) => print(value),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(12),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: "Search product" ,
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search)),
        ),
      ),
    );
  }
}
