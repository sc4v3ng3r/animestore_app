import '../../domain/models/content/animestore_content.model.dart';

abstract class AnimestoreContentDatasource<T> {
  T exec(AnimeStoreContentSettings settings);
}
