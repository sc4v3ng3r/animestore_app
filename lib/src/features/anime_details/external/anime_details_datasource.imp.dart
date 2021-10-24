import 'package:anime_app/src/features/anime_details/infra/datasource/anime_details_datasource.dart';
import 'package:anime_app/src/features/error/exception/animeapp_exception.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';

class AnimeDetailsDatasourceImp extends AnimeDetailsDataSource {
  final AniTubeApi api;

  AnimeDetailsDatasourceImp(this.api);

  @override
  Future<AnimeDetails> getAnimeDetails({required String animeId}) async {
    try {
      final data = await api.getAnimeDetails(animeId);
      return data;
    } catch (ex) {
      throw AppDatasourceExpcetion(
        message: "AnimeDetailsDatasourceImp exception ${ex.toString()}",
        code: 700,
      );
    }
  }
}
