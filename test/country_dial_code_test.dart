import 'package:country_dial_code/src/country_dial_code.dart';
import 'package:test/test.dart';

void main() {
  test('Verify country code', () {
    final CountryDialCode dialCode = CountryDialCode.fromCountryCode('EC');
    expect(dialCode.code, 'EC');
    expect(dialCode.name, 'Ecuador');
    expect(dialCode.dialCode, '+593');
  });
}
