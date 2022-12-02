import 'package:flutter/material.dart';

class DefaultFormField extends StatefulWidget {
  final String hint;
  final String title;
  final lines;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const DefaultFormField({
    required this.hint,
    required this.title,
    required this.controller,
    this.lines,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  State<DefaultFormField> createState() => _DefaultFormFieldState();
}

class _DefaultFormFieldState extends State<DefaultFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 0, 0, 7),
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: TextFormField(
              controller: widget.controller,
              decoration: InputDecoration(
                // Setting the background color of the TextFormField.
                filled: true,
                fillColor: Color.fromARGB(255, 224, 224, 224),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                errorStyle: const TextStyle(
                  color: Color.fromARGB(255, 169, 14, 14),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 169, 14, 14),
                    width: 1,
                  ),
                ),
                // Removing the default border.
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                // Setting the hint text and hint style.
                hintText: widget.hint,
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                // Setting the padding of the hint text.
                isCollapsed: true,
                contentPadding: const EdgeInsets.all(18),
              ),
              maxLines: widget.lines ?? 1,
              validator: widget.validator,
            ),
          ),
        ],
      ),
    );
  }
}
