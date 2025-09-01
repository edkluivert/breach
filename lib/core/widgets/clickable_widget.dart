import 'package:flutter/material.dart';

class ClickableWidget extends StatelessWidget {
  const ClickableWidget({
    required this.onTap,
    required this.child,
    super.key,
    this.backgroundColor = Colors.white,
    this.borderRadius = 0,
    this.padding = 0,
  });

  final Widget child;
  final GestureTapCallback? onTap;
  final Color? backgroundColor;
  final double borderRadius;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Material(
        color: backgroundColor,
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.grey.withOpacity(0.2),
          highlightColor: Colors.transparent,
          child: Padding(
            padding:  EdgeInsets.all(padding),
            child: child,
          ),
        ),
      ),
    );
  }
}
