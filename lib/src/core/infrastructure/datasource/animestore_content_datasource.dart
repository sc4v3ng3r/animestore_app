import '../../domain/models/content/animestore_content_settings.model.dart';

abstract class AnimestoreContentDatasource<T> {
  T exec(AnimeStoreContentSettings settings);
}
