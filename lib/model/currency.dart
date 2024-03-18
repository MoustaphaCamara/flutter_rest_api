class Currency {
  final String code;
  final String name;

  Currency(this.name, this.code);

  @override
  String toString() {
    return '$code $name';
  }
}
