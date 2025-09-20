import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.field,
  });
  final TextEditingController controller;
  final String labelText;
  final String field;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            field,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 245, 245, 245),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: field == 'Password' ? true : false,
            decoration: InputDecoration(
                hintText: field,
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your $labelText';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
