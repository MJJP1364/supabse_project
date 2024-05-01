import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  const InputText({
    super.key,
    required this.controller,
    required this.labale,
    required this.hintText,
    this.icon,
    this.sufixe,
    this.onTap,
    this.obsecured = false,
    this.textMinLines = 1,
    this.textMaxLines = 1,
  });
  final String labale;
  final String hintText;
  final IconData? icon;
  final TextEditingController controller;
  final IconData? sufixe;
  final VoidCallback? onTap;
  final bool? obsecured;
  final int? textMinLines;
  final int? textMaxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: textMinLines,
      maxLines: textMaxLines,
      obscureText: obsecured!,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field Is Required';
        }
        return null;
      },
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: onTap,
          child: Icon(sufixe),
        ),
        label: Text(labale),
        hintText: hintText,
        icon: Icon(icon),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
      ),
    );
  }
}
