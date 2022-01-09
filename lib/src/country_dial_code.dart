import 'package:country_dial_code/src/codes.dart';
import 'package:country_dial_code/src/exceptions.dart';

/// Country dial code.
class CountryDialCode {
  /// Define a [CountryDialCode] class.
  const CountryDialCode({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flagURI,
  });

  /// The name of country.
  final String name;

  /// The ISO 3166-1 Alpha-2 code.
  final String code;

  /// The dial code of the country.
  final String dialCode;

  /// The URI flag saved in assets folder.
  final String flagURI;

  /// Returns a [CountryDialCode] class by ISO 3166 Alpha-2 [countryCode].
  ///
  /// Throw a [CountryNotFoundException] if the country does not exist.
  factory CountryDialCode.fromCountryCode(String countryCode) {
    final Map<String, String> country = codes.firstWhere(
      (code) => code['code'] == countryCode.toUpperCase(),
      orElse: () => {},
    );
    if (country.isEmpty) throw const CountryNotFoundException();
    return CountryDialCode.fromJson(country);
  }

  /// Returns a [CountryDialCode] class by [dialCode].
  ///
  /// Throw a [CountryNotFoundException] if the country does not exist.
  factory CountryDialCode.fromDialCode(String dialCode) {
    final Map<String, String> country = codes.firstWhere(
      (code) => code['dialCode'] == dialCode.toUpperCase(),
      orElse: () => {},
    );
    if (country.isEmpty) throw const CountryNotFoundException();
    return CountryDialCode.fromJson(country);
  }

  /// Returns a [CountryDialCode] class from [json] Map.
  factory CountryDialCode.fromJson(Map<String, dynamic> json) {
    return CountryDialCode(
      name: json['name'] as String,
      code: json['code'] as String,
      dialCode: json['dialCode'] as String,
      flagURI: 'assets/flags/${json['code'].toString().toLowerCase()}.png',
    );
  }
}

List<CountryDialCode> get allCountries {
  const List<Map<String, String>> jsonList = codes;
  return jsonList.map((json) => CountryDialCode.fromJson(json)).toList();
}
