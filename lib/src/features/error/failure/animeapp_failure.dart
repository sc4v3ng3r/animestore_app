abstract class AnimeappFailure {
  String message;
  AnimeappFailure({required this.message});
}

class NetworkFailure extends AnimeappFailure {
  final int? code;
  NetworkFailure(String message, {this.code}) : super(message: message);
}

class SearchFailure extends AnimeappFailure {
  final int? code;
  final String message;

  SearchFailure({required this.message, this.code}) : super(message: message);
}
