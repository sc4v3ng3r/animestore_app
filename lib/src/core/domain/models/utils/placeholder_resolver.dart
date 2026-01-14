class PlaceholderResolver {
  static dynamic resolve(dynamic value, List<String> params) {
    if (value is String) {
      return _resolveString(value, params);
    }

    if (value is Map) {
      return value.map(
        (k, v) => MapEntry(k, resolve(v, params)),
      );
    }

    if (value is List) {
      return value.map((e) => resolve(e, params)).toList();
    }

    return value;
  }

  static String _resolveString(String template, List<String> params) {
    var result = template;

    for (var i = 0; i < params.length; i++) {
      result = result.replaceAll('%${i + 1}%', params[i]);
    }

    return result;
  }
}
