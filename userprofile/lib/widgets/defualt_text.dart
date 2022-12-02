import 'package:flutter/material.dart';

class DefaultTextBox extends StatefulWidget {
  final String text;
  final String title;
  const DefaultTextBox({
    required this.text,
    required this.title,
    Key? key,
  }) : super(key: key);
  @override
  State<DefaultTextBox> createState() => _DefaultTextBoxState();
}

class _DefaultTextBoxState extends State<DefaultTextBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 75),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.text,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
