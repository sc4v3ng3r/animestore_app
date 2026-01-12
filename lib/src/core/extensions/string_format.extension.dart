extension StringFormat on String {
  String format(List<dynamic> values) {
    var result = this;

    for (int i = 0; i < values.length; i++) {
      final placeholder = '{%${i + 1}%}';
      result = result.replaceAll(placeholder, values[i].toString());
    }
    result = result.replaceAll(RegExp(r'\{\%\d+\%\}'), '');

    return result;
  }
}
