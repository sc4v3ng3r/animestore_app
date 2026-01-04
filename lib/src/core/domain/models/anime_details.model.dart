import './item.model.dart';

/// This class holds read only details information
/// about a specific anime. All these information are
/// provided by animetube.site brazilian website and some of
/// them could be wrong or even not available.

abstract class AnimeDetails {
  static const TITLE = "titulo";
  static const AUTHOR = "Autor";
  static const FORMAT = "Formato";
  static const GENRE = "Gênero";
  static const DIRECTOR = "Diretor";
  static const STUDIO = "Estúdio";
  static const CC = "Tipo de Episódio";
  static const IMAGE_URL = "imageUrl";
  static const EPISODES_LIST = "episodios_lista";
  static const EPISODES_NUMBER = "episodios";
  static const DESCRIPTION = "sinopse";
  static const YEAR = "Ano";
  static const OVAS = "Ovas";
  static const MOVIES = "Filmes";

  /// The data json map.
  // final Map<String, dynamic> _data;

  /// The list of anime episode Items.
  final List<Item> episodes;

  /// The anime title
  final String title;
  // final String title => _data[TITLE];

  /// The anime author
  final String author;

  final String format;

  /// A String with the anime genres.
  final String genre;

  /// The anime director
  final String director;

  /// Anime closed caption type. Can be dubbed OR legend.
  final String closedCaption;

  /// The a studio that produces this anime.
  final String studio;

  /// Anime cover image Url.
  final String imageUrl;

  /// The anime year
  final String year;

  /// Anime movies Url
  final String movies;

  final String ovas;

  /// The anime resume or synopsis
  final String resume;

  /// The number of episodes
  final String episodesNumber;

  AnimeDetails(
      {required this.title,
      this.episodes = const [],
      this.author = '',
      this.format = '',
      this.genre = '',
      this.director = '',
      this.closedCaption = '',
      this.studio = '',
      this.imageUrl = '',
      this.year = '',
      this.movies = '',
      this.ovas = '',
      this.resume = '',
      this.episodesNumber = ''});
}
