import 'package:country_dial_code/src/data/local/dial_codes.dart';
import 'package:country_dial_code/src/domain/exceptions/country_not_found_exception.dart';

/// [CountryDialCode] class.
class CountryDialCode {
  /// Define a [CountryDialCode] class.
  const CountryDialCode({
    required this.code,
    required this.dialCode,
    required this.flagURI,
    required this.name,
  });

  /// Country ISO 3166-1 Alpha-2 code.
  final String code;

  /// Country dial code.
  final String dialCode;

  /// Country flag URI.
  final String flagURI;

  /// Country name.
  final String name;

  /// Returns a [CountryDialCode] class by ISO 3166 Alpha-2 [countryCode].
  ///
  /// Throw a [CountryNotFoundException] if the country does not exist.
  factory CountryDialCode.fromCountryCode(String countryCode) {
    final Map<String, String> country = dialCodes.firstWhere(
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
    final Map<String, String> country = dialCodes.firstWhere(
      (code) => code['dialCode'] == dialCode.toUpperCase(),
      orElse: () => {},
    );
    if (country.isEmpty) throw const CountryNotFoundException();
    return CountryDialCode.fromJson(country);
  }

  /// Returns a [CountryDialCode] from [json] Map.
  factory CountryDialCode.fromJson(Map<String, dynamic> json) {
    return CountryDialCode(
      code: json['code'] as String,
      dialCode: json['dialCode'] as String,
      flagURI: 'assets/flags/${json['code'].toString().toLowerCase()}.png',
      name: json['name'] as String,
    );
  }
}
