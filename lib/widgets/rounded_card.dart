import 'package:flutter/material.dart';

class RoundedCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double width;
  final double height;

  RoundedCard({
    @required this.child,
    this.margin = const EdgeInsets.all(8),
    this.padding = const EdgeInsets.all(8),
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            offset: Offset(0, 3),
            blurRadius: 5,
            spreadRadius: 3,
          )
        ],
      ),
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      child: child,
    );
  }
}
