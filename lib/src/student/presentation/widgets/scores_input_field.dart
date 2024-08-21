import 'package:flutter/material.dart';

class ScoresInputField extends StatefulWidget {
  const ScoresInputField(
      {super.key,
      required this.inputController,
      required this.lableText,
      required this.useNumberKeyboard,
      this.ispassword = false,
      this.isemail = false});
  final TextEditingController inputController;
  final String lableText;
  final bool useNumberKeyboard;
  final bool ispassword;
  final bool isemail;

  @override
  State<ScoresInputField> createState() => _ScoresInputFieldState();
}

class _ScoresInputFieldState extends State<ScoresInputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.inputController,
      obscureText: widget.ispassword,
      keyboardType: widget.useNumberKeyboard
          ? TextInputType.number
          : widget.isemail
              ? TextInputType.emailAddress
              : TextInputType.text,
      decoration: InputDecoration(
          border: const OutlineInputBorder(), label: Text(widget.lableText)),
    );
  }
}
