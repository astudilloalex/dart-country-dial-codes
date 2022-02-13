import 'package:flutter/cupertino.dart';

class FlagImageSettings {
  const FlagImageSettings({
    this.borderRadius = BorderRadius.zero,
    this.circle = false,
    this.circleRadius = 16.0,
    this.height,
    this.width = 32.0,
  });

  /// Radius to apply to the all flag
  ///
  /// Only apply if [circle] is false.
  final BorderRadius borderRadius;

  /// Circle flag, replace rectangle flag by circle flag.
  final bool circle;

  /// Only apply if the [circle] is true.
  final double circleRadius;

  /// Height of the flag.
  final double? height;

  /// Width of the flag.
  final double width;
}
