import 'dart:math' as math;
import 'dart:ui';

import 'package:country_dial_code/country_dial_code.dart';
import 'package:country_dial_code/src/data/local/dial_codes.dart';
import 'package:country_dial_code/src/ui/country_dial_code_bottom_sheet.dart';
import 'package:flutter/material.dart';

class CountryDialCodePicker extends StatefulWidget {
  const CountryDialCodePicker({
    Key? key,
    this.arrowDropDownColor,
    this.borderRadius = 0.0,
    this.bottomSheetSettings = const BottomSheetSettings(),
    this.flagImageSettings = const FlagImageSettings(),
    this.initialSelection,
    this.onChanged,
    this.padding = const EdgeInsets.all(8.0),
    this.showArrowDropDown = true,
    this.showCountryDialCode = true,
    this.showFlag = true,
    this.textStyle,
  }) : super(key: key);

  /// Arrow drop down icon color.
  final Color? arrowDropDownColor;

  /// Radius of the button for splash.
  final double borderRadius;

  /// Settings of the button sheet with all countries.
  final BottomSheetSettings bottomSheetSettings;

  /// Flag image settings.
  final FlagImageSettings flagImageSettings;

  /// The country ISO 3166-1 Alpha-2 code for initial selection.
  final String? initialSelection;

  /// Event when user change country code.
  final ValueChanged<CountryDialCode>? onChanged;

  /// Padding to apply around to the button picker.
  final EdgeInsets padding;

  /// Show arrow drop down icon.
  final bool showArrowDropDown;

  /// Show country dial code selected.
  final bool showCountryDialCode;

  /// Show flag inside button picker.
  final bool showFlag;

  /// Style to apply of the country dial codes.
  final TextStyle? textStyle;

  @override
  State<CountryDialCodePicker> createState() {
    return _CountryDialCodePickerState();
  }
}

class _CountryDialCodePickerState extends State<CountryDialCodePicker> {
  CountryDialCode? _countryDialCode;

  @override
  void initState() {
    _load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_countryDialCode == null) {
      return const Text('');
    }
    final double scale = MediaQuery.maybeOf(context)?.textScaleFactor ?? 1;
    final double gap =
        scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;
    return Padding(
      padding: widget.padding,
      child: InkWell(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        onTap: () {
          showModalBottomSheet<CountryDialCode?>(
            context: context,
            shape: widget.bottomSheetSettings.shape,
            builder: (_) {
              return CountryDialCodeBottomSheet(
                settings: widget.bottomSheetSettings,
              );
            },
          ).then((value) {
            if (value != null) {
              widget.onChanged?.call(value);
              setState(() => _countryDialCode = value);
            }
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.showFlag && !widget.flagImageSettings.circle)
              ClipRRect(
                borderRadius: widget.flagImageSettings.borderRadius,
                child: Image.asset(
                  _countryDialCode!.flagURI,
                  package: 'country_dial_code',
                  width: widget.flagImageSettings.width,
                  height: widget.flagImageSettings.height,
                ),
              ),
            if (widget.showFlag && widget.flagImageSettings.circle)
              CircleAvatar(
                backgroundImage: AssetImage(
                  _countryDialCode!.flagURI,
                  package: 'country_dial_code',
                ),
                radius: widget.flagImageSettings.circleRadius,
              ),
            if (widget.showFlag && widget.showCountryDialCode)
              SizedBox(width: gap),
            if (widget.showCountryDialCode)
              Text(
                _countryDialCode!.dialCode,
                style: widget.textStyle,
              ),
            if (widget.showArrowDropDown)
              Icon(Icons.arrow_drop_down, color: widget.arrowDropDownColor),
          ],
        ),
      ),
    );
  }

  void _load() {
    final List<CountryDialCode> countries = dialCodes
        .map(
          (json) => CountryDialCode.fromJson(json),
        )
        .toList();
    if (widget.initialSelection != null) {
      _countryDialCode = countries.firstWhere(
        (element) => element.code == widget.initialSelection,
        orElse: () => countries.first,
      );
    } else {
      _countryDialCode = countries.first;
    }
  }
}
