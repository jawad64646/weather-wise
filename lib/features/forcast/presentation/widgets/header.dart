import 'package:flutter/material.dart';

Widget header(String title, String tailingText) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        Text(
          tailingText,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}
