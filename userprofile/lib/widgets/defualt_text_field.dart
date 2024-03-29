import 'package:flutter/material.dart';

import '../style/app_colors.dart';

class DefaultFormField extends StatefulWidget {
  final String hint;
  final String title;
  final int? maxLength;
  final TextInputType? keyboardtype;
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
    this.keyboardtype,
    this.maxLength,
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
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: TextFormField(
              style: Theme.of(context).textTheme.headline4,
              keyboardType: widget.keyboardtype,
              controller: widget.controller,
              decoration: InputDecoration(
                // Setting the background color of the TextFormField.
                filled: true,
                fillColor: AppColors.light_blue_tint_2,
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: AppColors.black_Text,
                    width: 1,
                  ),
                ),
                errorStyle: const TextStyle(
                  fontSize: 15,
                  color: AppColors.red_error,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: AppColors.red_error,
                    width: 1.5,
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
                  color: AppColors.black_Text,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                // Setting the padding of the hint text.
                isCollapsed: true,
                contentPadding: const EdgeInsets.all(18),
              ),
              maxLines: widget.lines ?? 1,
              validator: widget.validator,
              maxLength: widget.maxLength,
            ),
          ),
        ],
      ),
    );
  }
}
