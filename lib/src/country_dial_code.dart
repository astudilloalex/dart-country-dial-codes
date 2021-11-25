import 'package:country_dial_code/src/codes.dart';
import 'package:country_dial_code/src/exceptions.dart';

/// Country dial code.
class CountryDialCode {
  final String name;
  final String code;
  final String dialCode;

  /// Define a [CountryDialCode] class.
  const CountryDialCode({
    required this.name,
    required this.code,
    required this.dialCode,
  });

  /// Returns a [CountryDialCode] class by ISO 3166 Alpha-2 [countryCode].
  ///
  /// Throw a [CountryNotFoundException] if the country does not exist.
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
