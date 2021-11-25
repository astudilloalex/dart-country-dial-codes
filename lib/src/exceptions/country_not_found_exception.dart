class CountryNotFoundException implements Exception {
  const CountryNotFoundException([this.message = 'The country was not found']);
  final String message;
}
