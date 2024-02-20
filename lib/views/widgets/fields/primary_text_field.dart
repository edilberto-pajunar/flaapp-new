import 'package:flaapp/values/strings/images.dart';
import 'package:flutter/material.dart';

class PrimaryTextField extends StatefulWidget {
  const PrimaryTextField({
    required this.controller,
    required this.label,
    this.hintText,
    this.suffixIcon,
    this.isPassword = false,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String? hintText;
  final Widget? suffixIcon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool readOnly;

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  bool _hidden = true;

  Widget passwordWidget() {
    if (widget.isPassword) {
      return IconButton(
        onPressed: () {
          setState(() {
            _hidden = !_hidden;
          });
        },
        icon: Image.asset(
          _hidden ? PngImage.closedEye : PngImage.openEye,
        ),
      );
    } else {
      return widget.suffixIcon ?? const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
        ),
        const SizedBox(height: 6.0),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          obscureText: widget.isPassword ? _hidden : false,
          onTapOutside: (point) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          readOnly: widget.readOnly,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            hintText: widget.hintText ?? "Enter",
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            suffixIcon: passwordWidget(),
          ),
          validator: widget.validator,
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
