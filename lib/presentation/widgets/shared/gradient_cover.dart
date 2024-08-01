import 'package:flutter/material.dart';

class GradientCover extends StatelessWidget {
  final Alignment? startAlignment;
  final Alignment? endAlignment;
  final List<Color>? colors;
  final List<double> stops;

  const GradientCover(
      {super.key,
      this.startAlignment,
      this.endAlignment,
      required this.stops,
      this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors ?? [Colors.transparent, Colors.black87],
            begin: startAlignment ?? Alignment.topCenter,
            end: endAlignment ?? Alignment.bottomCenter,
            stops: stops,
          ),
        ),
      ),
    );
  }
}
