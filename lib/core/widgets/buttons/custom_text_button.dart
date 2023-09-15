import 'package:flutter/material.dart';

/// Custom [TextButton].
class CustomTextButton extends StatelessWidget {
  /// Create [CustomTextButton].
  const CustomTextButton({
    required this.label,
    super.key,
    this.onPressed,
  });

  /// Can set a execution function [onPressed].
  final VoidCallback? onPressed;

  /// Set a text [label].
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
