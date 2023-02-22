import 'package:country_dial_code/country_dial_code.dart';
import 'package:country_dial_code/src/data/local/dial_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryDialCodeBottomSheet extends StatefulWidget {
  const CountryDialCodeBottomSheet({
    Key? key,
    required this.settings,
  }) : super(key: key);

  final BottomSheetSettings settings;

  @override
  State<CountryDialCodeBottomSheet> createState() =>
      _CountryDialCodeBottomSheetState();
}

class _CountryDialCodeBottomSheetState
    extends State<CountryDialCodeBottomSheet> {
  final List<CountryDialCode> countries = dialCodes
      .map(
        (json) => CountryDialCode.fromJson(json),
      )
      .toList();
  List<CountryDialCode> filteredCountries = [];

  @override
  void initState() {
    filteredCountries = countries;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: widget.settings.decoration,
      child: Padding(
        padding: widget.settings.padding,
        child: Column(
          children: [
            TextField(
              onChanged: _search,
              style: widget.settings.searchTextStyle,
              decoration: widget.settings.inputDecoration,
              autofocus: true,
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: filteredCountries.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    leading: widget.settings.showFlag
                        ? SvgPicture.asset(
                            filteredCountries[index].flagURI,
                            package: 'country_dial_code',
                            width: 50,
                          )
                        : null,
                    title: Text(
                      filteredCountries[index].dialCode,
                      style: widget.settings.textStyle,
                    ),
                    onTap: () => Navigator.of(context).pop(
                      filteredCountries[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _search(String value) {
    setState(() {
      filteredCountries = countries.where(
        (element) {
          return element.name.toLowerCase().contains(value.toLowerCase()) ||
              element.dialCode.contains(value.toLowerCase());
        },
      ).toList()
        // sort based on exact matches in dialCode, dialCode or name
        ..sort((a, b) {
          if (a.dialCode == value) {
            return -1;
          } else if (b.dialCode == value) {
            return 1;
          } else if (a.dialCode.contains(value)) {
            return -1;
          } else if (b.dialCode.contains(value)) {
            return 1;
          } else if (a.name.toLowerCase().contains(value.toLowerCase())) {
            return -1;
          } else if (b.name.toLowerCase().contains(value.toLowerCase())) {
            return 1;
          } else {
            return 0;
          }
        });
    });
  }
}
