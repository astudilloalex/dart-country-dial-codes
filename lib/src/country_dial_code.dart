import 'package:country_dial_code/src/codes.dart';
import 'package:country_dial_code/src/exceptions/country_not_found_exception.dart';

class CountryDialCode {
  final String name;
  final String code;
  final String dialCode;

  const CountryDialCode({
    required this.name,
    required this.code,
    required this.dialCode,
  });

  factory CountryDialCode.fromCountryCode(String countryCode) {
    final Map<String, String> country = codes.firstWhere(
      (code) => code['code'] == countryCode.toUpperCase(),
      orElse: () => {},
    );
    if (country.isEmpty) throw const CountryNotFoundException();
    return CountryDialCode(
      name: country['name']!,
      code: country['code']!,
      dialCode: country['dialCode']!,
    );
  }
}
