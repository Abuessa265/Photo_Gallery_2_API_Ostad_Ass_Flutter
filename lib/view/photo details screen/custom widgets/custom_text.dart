import 'package:flutter/material.dart';

Widget buildText(String label, String value) {
  return Text(
    '$label: $value',
    style: const TextStyle(
      // fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
  );
}
