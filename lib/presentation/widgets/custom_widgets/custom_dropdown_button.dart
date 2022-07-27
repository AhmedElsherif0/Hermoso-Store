import 'package:flutter/material.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({Key? key}) : super(key: key);

  @override
  _CustomDropDownButtonState createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String dropDownValue = 'English';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropDownValue,
        underline: const SizedBox() ,
      icon: const Icon(Icons.arrow_forward_ios),
      onChanged: (String? newValue) {
        setState(() {
          dropDownValue = newValue!;
        });
      },
      items: <String>['English', 'Arabic']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
