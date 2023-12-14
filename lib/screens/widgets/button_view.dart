import 'package:flutter/material.dart';

class ButtonView extends StatelessWidget {
  const ButtonView({
    super.key,
    required this.title,
    required this.action,
  });

  final String title;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        action();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
