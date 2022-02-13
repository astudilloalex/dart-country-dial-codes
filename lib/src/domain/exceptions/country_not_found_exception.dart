/// Country not found exception if country doesn't exist.
class CountryNotFoundException implements Exception {
  /// Define a [CountryNotFoundException] class.
  const CountryNotFoundException([this.message = 'The country was not found']);

  /// A message describing the error.
  final String message;
}
