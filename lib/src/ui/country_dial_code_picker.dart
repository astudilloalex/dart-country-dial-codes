import 'dart:math' as math;
import 'dart:ui';

import 'package:country_dial_code/country_dial_code.dart';
import 'package:country_dial_code/src/data/local/dial_codes.dart';
import 'package:country_dial_code/src/ui/country_dial_code_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryDialCodePicker extends StatefulWidget {
  const CountryDialCodePicker({
    super.key,
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
    this.countryCode,
  });

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

  /// The country ISO 3166-1 Alpha-2 code for initial selection.
  final String? countryCode;

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
  final List<CountryDialCode> countries =
      dialCodes.map((json) => CountryDialCode.fromJson(json)).toList();

  @override
  void initState() {
    _load();
    super.initState();
  }

  @override
  void didUpdateWidget(CountryDialCodePicker oldWidget) {
    if (oldWidget.countryCode != widget.countryCode) {
      setState(() {
        _countryDialCode = countries.firstWhere(
          (element) => element.code == widget.countryCode,
          orElse: () => countries.first,
        );
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  bool get isControlled => widget.countryCode != null;

  @override
  Widget build(BuildContext context) {
    if (_countryDialCode == null) {
      return const SizedBox();
    }
    final TextScaler? textScaler = MediaQuery.maybeOf(context)?.textScaler;
    final double scale = textScaler?.scale(1) ?? 1;
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
                child: SvgPicture.asset(
                  _countryDialCode!.flagURI,
                  package: 'country_dial_code',
                  width: widget.flagImageSettings.width,
                  height: widget.flagImageSettings.height,
                ),
              ),
            if (widget.showFlag && widget.flagImageSettings.circle)
              CircleAvatar(
                radius: widget.flagImageSettings.circleRadius,
                backgroundColor: Colors.transparent,
                backgroundImage:
                    _countryDialCode!.flagURI.toLowerCase().endsWith('.svg')
                        ? null
                        : AssetImage(
                          _countryDialCode!.flagURI,
                          package: 'country_dial_code',
                        ),
                child:
                    _countryDialCode!.flagURI.toLowerCase().endsWith('.svg')
                        ? SvgPicture.asset(
                          _countryDialCode!.flagURI,
                          package: 'country_dial_code',
                          width: widget.flagImageSettings.circleRadius * 2,
                          height: widget.flagImageSettings.circleRadius * 2,
                          fit: BoxFit.cover,
                        )
                        : null,
              ),
            if (widget.showFlag && widget.showCountryDialCode)
              SizedBox(width: gap),
            if (widget.showCountryDialCode)
              Text(_countryDialCode!.dialCode, style: widget.textStyle),
            if (widget.showArrowDropDown)
              Icon(Icons.arrow_drop_down, color: widget.arrowDropDownColor),
          ],
        ),
      ),
    );
  }

  void _load() {
    final String? countryCode =
        isControlled ? widget.countryCode : widget.initialSelection;

    if (countryCode != null) {
      _countryDialCode = countries.firstWhere(
        (element) => element.code == countryCode,
        orElse: () => countries.first,
      );
    } else {
      _countryDialCode = countries.first;
    }
  }
}
