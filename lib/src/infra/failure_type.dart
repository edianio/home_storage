enum FailureType {
  network('NETWORK'),
  server('SERVER'),
  unexpected('UNEXPECTED');

  final String value;

  const FailureType(this.value);
}
