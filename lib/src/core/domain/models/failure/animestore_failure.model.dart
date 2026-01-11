abstract class AnimestoreFailure implements Exception {
  final String description;

  const AnimestoreFailure({required this.description});
}

class AnimestoreNetworFailure extends AnimestoreFailure {
  const AnimestoreNetworFailure({required super.description});
}
