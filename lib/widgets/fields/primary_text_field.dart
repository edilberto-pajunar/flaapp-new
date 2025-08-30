import 'package:flaapp/utils/constant/strings/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PrimaryTextField extends StatefulWidget {
  const PrimaryTextField({
    this.label,
    this.hintText,
    this.suffixIcon,
    this.isPassword = false,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.name,
    this.required = false,
    super.key,
  });

  final String? label;
  final String? hintText;
  final Widget? suffixIcon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final bool readOnly;
  final String? name;
  final bool required;
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
        if (widget.label != null && widget.label!.isNotEmpty)
          Text(
            widget.label ?? "",
            style: TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        const SizedBox(height: 6.0),
        FormBuilderTextField(
            name: widget.name ?? "",
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
            validator: (val) {
              if (widget.required) {
                final requiredResult = FormBuilderValidators.required()(val);
                if (requiredResult != null) {
                  return requiredResult;
                }
              }
              if (widget.validator != null) {
                return widget.validator!(val);
              }
              return null;
            }),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
