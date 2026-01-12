import 'dart:convert' as json;
import 'package:dompen/dompen.dart';

import '../../infrastructure/parser/animestore_content_parser.dart';

class AnimestoreHtmlParserImpl extends AnimestoreContentParser {
  final DompenHtmlEngineImpl _parserEngine;

  AnimestoreHtmlParserImpl(this._parserEngine);

  @override
  Map<String, dynamic> parse(
      {required String contentToParse,
      required Map<String, dynamic> declaration}) {
    final DompenSettings dompenSettings = DompenSettings(
      parseContent: contentToParse,
      declaration: json.jsonEncode(declaration),
    );
    return _parserEngine.parse(settings: dompenSettings);
  }
}
