import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CommonPrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double? fontSize;
  final double? height;

  const CommonPrimaryButton({
    super.key,
    required this.title,
    required this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.fontSize,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 60.px,
        width: MediaQuery.of(context).size.width - 40,
        padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 10.px),
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(15.px),
          border: Border.all(
            width: 2.px,
            color: borderColor ?? Theme.of(context).primaryColor,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: fontSize ?? 17.px,
              fontWeight: FontWeight.w700,
              color: textColor ?? Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
