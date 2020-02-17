import 'package:anime_app/i18n/LocalizationEN.dart';
import 'package:anime_app/i18n/LocalizationPT.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class AnimeStoreLocalization {
  static AnimeStoreLocalization of(BuildContext context){
    return Localizations.of<AnimeStoreLocalization>(context, AnimeStoreLocalization);
  }

  String get topAnimes;

  String get mostViewedAnimes;

  String get recentlyUpdated;

  String get myAnimeList;

  String get exploreGenres;

  String get latestEpisodes;

  String get home;

  String get animes;

  String get search;

  String get episodes;

  String get animeDetails;

  String get resume;

  String get addToList;

  String get removeFromList;

  String get episodesUnavailable;

  String get addedToList;

  String get removedFromList;

  String get dataUnavailable;

  String get tryAgain;

  String get genre;

  String get studio;
  String get author;
  String get director;
  String get year;
  String get episodesNumber;

  String get problemsWithTheServer;

  String get searchHint;

  String get noResults;

  String get searchErrorMessage;

  String get viewAll;

  String get info;

  String get animeStore;

  String get appInfoSubtitle;

  String get animeStoreLicenseTitle;

  String get animeStoreLicensesubtitle;

  String get openSourceLibraryTitle;

  String get openSourceLibrarysubtitle;

  String get appNameTitle;

  String get versionTitle;

  String get buildNumberTitle;

  String get quit;

  String get next;

  String get previous;

  String get confirm;

  String get cancel;

  String get titleClearList;

  String get messageClearList;

  String get suggestion;

  String get noSuggestions;

  String get markAsViewed;

  String get markAsUnviewed;

  String get videoUnavailable;

  String get back;

  String get episodesComingSoon;
}

class AnimeStoreLocalizationsDelegate extends LocalizationsDelegate<AnimeStoreLocalization>{

  const AnimeStoreLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'pt'].contains(locale.languageCode);

  @override
  Future<AnimeStoreLocalization> load(Locale locale) => _load(locale);

  static Future<AnimeStoreLocalization> _load(Locale locale) async {
    final String name = (locale.countryCode == null || locale.countryCode.isEmpty) ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    Intl.defaultLocale = localeName;

    if( locale.languageCode == "en" ) {
      return LocalizationEN() as AnimeStoreLocalization;
    }

    if (locale.languageCode == 'pt')
      return LocalizationPT() as AnimeStoreLocalization;

    return LocalizationEN() as AnimeStoreLocalization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AnimeStoreLocalization> old) => false;

}

