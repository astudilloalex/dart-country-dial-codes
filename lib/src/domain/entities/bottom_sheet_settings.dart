import 'package:flutter/material.dart';

class BottomSheetSettings {
  const BottomSheetSettings({
    this.decoration = const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
    ),
    this.inputDecoration = const InputDecoration(
      hintText: 'Search',
      contentPadding: EdgeInsets.all(10.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
    ),
    this.padding = const EdgeInsets.all(8.0),
    this.searchTextStyle,
    this.shape = const RoundedRectangleBorder(),
    this.showFlag = true,
    this.textStyle,
  });

  /// Decoration inside bottom sheet.
  final BoxDecoration decoration;

  /// Decoration of the search input field.
  final InputDecoration inputDecoration;

  /// Padding to apply in bottom sheet children.
  final EdgeInsetsGeometry padding;

  /// Style to apply search text field.
  final TextStyle? searchTextStyle;

  /// Shape border of the bottom sheet.
  final ShapeBorder shape;

  /// Flag image should be displayed.
  final bool showFlag;

  /// Style to apply for all countries list.
  final TextStyle? textStyle;
}
