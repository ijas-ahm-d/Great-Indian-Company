import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.label,
    this.color,
    this.fontWeight,
    this.fontsize = 18,
  });

  final String label;
  final Color? color;
  final FontWeight? fontWeight;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
          color: color ?? Colors.white,
          fontSize: fontsize,
          fontWeight: fontWeight ?? FontWeight.w500),
    );
  }
}
