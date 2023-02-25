import 'package:country_dial_code/country_dial_code.dart';

extension FilteredCountryList on List<CountryDialCode> {
  List<CountryDialCode> search(String value) {
    final formattedValue = value.trim().toLowerCase().replaceAll('+', '');

    return where(
      (element) {
        return element.name.toLowerCase().contains(formattedValue) ||
            element.dialCode.contains(formattedValue) ||
            element.code.toLowerCase().contains(formattedValue);
      },
    ).toList()
      // sort based on exact matches in dialCode, dialCode or name
      ..sort((a, b) {
        if (a.dialCode.replaceAll('+', '') == formattedValue) {
          return -1;
        } else if (b.dialCode.replaceAll('+', '') == formattedValue) {
          return 1;
        } else if (a.code.toLowerCase() == formattedValue) {
          return -1;
        } else if (b.code.toLowerCase() == formattedValue) {
          return 1;
        } else if (a.dialCode.contains(formattedValue)) {
          return -1;
        } else if (b.dialCode.contains(formattedValue)) {
          return 1;
        } else if (a.name.toLowerCase().contains(formattedValue)) {
          return -1;
        } else if (b.name.toLowerCase().contains(formattedValue)) {
          return 1;
        } else {
          return 0;
        }
      });
  }
}
