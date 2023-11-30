import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isLast,
    this.size = 16,
    this.textColor,
  });

  final Color color;
  final String text;
  final bool isLast;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(
              color: color,
              style: BorderStyle.solid,
              width: 4.0,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        const SizedBox(width: 4.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        if (!isLast) const SizedBox(width: 10.0),
      ],
    );
  }
}
