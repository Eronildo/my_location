import 'package:flutter/material.dart';

/// Custom [MaterialButton].
class CustomButton extends StatelessWidget {
  /// Create [CustomButton].
  const CustomButton({
    super.key,
    this.onPressed,
    this.iconData,
    this.label,
  });

  /// Can set a execution function [onPressed].
  final VoidCallback? onPressed;

  /// Can set a Icon from [IconData].
  final IconData? iconData;

  /// Can set a text [label].
  final String? label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      minWidth: 40,
      onPressed: onPressed,
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconData != null) Icon(iconData),
          if (iconData != null && label != null) const SizedBox(width: 5),
          if (label != null) Text(label!),
        ],
      ),
    );
  }
}
