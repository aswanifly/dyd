import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CTextField extends StatelessWidget {
  final Widget? label;
  final String? validatorName;
  final TextEditingController controller;
  final bool isObscureText;
  final bool enabled;
  final bool filled;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final String? Function(String? v)? validator;
  final int? maxLength;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color fillColor;
  final int maxLines;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;

  const CTextField({
    super.key,
    this.label,
    this.enabled = true,
    required this.controller,
    this.validatorName,
    this.isObscureText = false,
    this.decoration,
    this.keyboardType,
    this.validator,
    this.maxLength,
    this.hintText,
    this.filled = true,
    this.fillColor = AppPalette.lightGrey2,
    this.hintStyle,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.inputFormatters,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscureText,
      enabled: enabled,
      maxLength: maxLength,
      onChanged: onChanged,
      onTap: onTap,
      maxLines: maxLines,
      keyboardType: keyboardType,
      obscuringCharacter: '●',
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      decoration: decoration ??
          InputDecoration(
              label: label,
              hintText: hintText,
              hintStyle: hintStyle,
              filled: filled,
              fillColor: fillColor,
              prefixIcon: prefixIcon,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
      validator: validator,
    );
  }
}

class CPTextField extends StatefulWidget {
  final Widget? label;
  final String? validatorName;
  final TextEditingController controller;
  final bool isObscureText;
  final bool enabled;
  final bool filled;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int? maxLength;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color fillColor;
  final int maxLines;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;

  const CPTextField({
    super.key,
    this.label,
    this.enabled = true,
    required this.controller,
    this.validatorName,
    this.isObscureText = false,
    this.decoration,
    this.keyboardType,
    this.validator,
    this.maxLength,
    this.hintText,
    this.filled = true,
    this.fillColor = AppPalette.lightGrey2,
    this.hintStyle,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.inputFormatters,
    this.prefixIcon,
  });

  @override
  State<CPTextField> createState() => _CPTextFieldState();
}

class _CPTextFieldState extends State<CPTextField> {
  late bool _obscureText;
  bool _showSuffix = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObscureText;
    _showSuffix = widget.controller.text.isNotEmpty;

    widget.controller.addListener(() {
      final shouldShow = widget.controller.text.isNotEmpty;
      if (_showSuffix != shouldShow) {
        setState(() {
          _showSuffix = shouldShow;
        });
      }
    });
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isObscureText ? _obscureText : false,
      enabled: widget.enabled,
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      obscuringCharacter: '●',
      inputFormatters: widget.inputFormatters,
      readOnly: widget.readOnly,
      validator: widget.validator,
      decoration: widget.decoration ??
          InputDecoration(
            label: widget.label,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            filled: widget.filled,
            fillColor: widget.fillColor,
            prefixIcon: widget.prefixIcon,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            suffixIcon: widget.isObscureText && _showSuffix
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: _toggleObscureText,
                  )
                : null,
          ),
    );
  }
}
