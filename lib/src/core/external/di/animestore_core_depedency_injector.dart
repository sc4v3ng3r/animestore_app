import 'package:dompen/dompen.dart';
import 'package:get_it/get_it.dart';

import '../../infrastructure/di/animestore_dependecy_injector.dart';
import '../global_declarations.dart';
import '../http/animestore_http_client.impl.dart';
import '../parser/animestore_html_parser.impl.dart';

class AnimestoreCoreDepedencyInjector extends AnimestoreDependecyInjector {
  final GetIt _getIt;

  AnimestoreCoreDepedencyInjector(this._getIt);

  @override
  void inject() {
    if (!_getIt.isRegistered<AnimestoreHtmlParserImpl>()) {
      _getIt.registerFactory<AnimestoreHtmlParserImpl>(
        () => AnimestoreHtmlParserImpl(DompenHtmlEngineImpl()),
      );
    }

    if (!_getIt.isRegistered<AnimestoreHttpClientImpl>()) {
      _getIt.registerFactory<AnimestoreHttpClientImpl>(
          () => AnimestoreHttpClientImpl(dioClient));
    }
  }
}
