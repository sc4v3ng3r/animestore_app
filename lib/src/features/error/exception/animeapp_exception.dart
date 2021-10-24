abstract class AnimeappException {
  String? message;
  int? code;
  AnimeappException(this.message, this.code);
}

class AppDatasourceExpcetion extends AnimeappException {
  AppDatasourceExpcetion({required String message, required int code})
      : super(message, code);
}

class AppExecutionException extends AnimeappException {
  AppExecutionException() : super("Erro executando o codigo", 700);
}
