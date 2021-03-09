// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Animes`
  String get animes {
    return Intl.message(
      'Animes',
      name: 'animes',
      desc: '',
      args: [],
    );
  }

  /// `Explore Genres`
  String get exploreGenres {
    return Intl.message(
      'Explore Genres',
      name: 'exploreGenres',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Latest Episodes`
  String get latestEpisodes {
    return Intl.message(
      'Latest Episodes',
      name: 'latestEpisodes',
      desc: '',
      args: [],
    );
  }

  /// `Most Viewed`
  String get mostViewedAnimes {
    return Intl.message(
      'Most Viewed',
      name: 'mostViewedAnimes',
      desc: '',
      args: [],
    );
  }

  /// `My List`
  String get myAnimeList {
    return Intl.message(
      'My List',
      name: 'myAnimeList',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Top Animes`
  String get topAnimes {
    return Intl.message(
      'Top Animes',
      name: 'topAnimes',
      desc: '',
      args: [],
    );
  }

  /// `Recently Updated`
  String get recentlyUpdated {
    return Intl.message(
      'Recently Updated',
      name: 'recentlyUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Add to List`
  String get addToList {
    return Intl.message(
      'Add to List',
      name: 'addToList',
      desc: '',
      args: [],
    );
  }

  /// `More Details`
  String get animeDetails {
    return Intl.message(
      'More Details',
      name: 'animeDetails',
      desc: '',
      args: [],
    );
  }

  /// `Episodes`
  String get episodes {
    return Intl.message(
      'Episodes',
      name: 'episodes',
      desc: '',
      args: [],
    );
  }

  /// `Remove From List`
  String get removeFromList {
    return Intl.message(
      'Remove From List',
      name: 'removeFromList',
      desc: '',
      args: [],
    );
  }

  /// `Resume`
  String get resume {
    return Intl.message(
      'Resume',
      name: 'resume',
      desc: '',
      args: [],
    );
  }

  /// `Episodes Unavailable`
  String get episodesUnavailable {
    return Intl.message(
      'Episodes Unavailable',
      name: 'episodesUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Added to List`
  String get addedToList {
    return Intl.message(
      'Added to List',
      name: 'addedToList',
      desc: '',
      args: [],
    );
  }

  /// `Removed from List`
  String get removedFromList {
    return Intl.message(
      'Removed from List',
      name: 'removedFromList',
      desc: '',
      args: [],
    );
  }

  /// `Data Unavailable`
  String get dataUnavailable {
    return Intl.message(
      'Data Unavailable',
      name: 'dataUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message(
      'Try Again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Author`
  String get author {
    return Intl.message(
      'Author',
      name: 'author',
      desc: '',
      args: [],
    );
  }

  /// `Director:`
  String get director {
    return Intl.message(
      'Director:',
      name: 'director',
      desc: '',
      args: [],
    );
  }

  /// `Episodes`
  String get episodesNumber {
    return Intl.message(
      'Episodes',
      name: 'episodesNumber',
      desc: '',
      args: [],
    );
  }

  /// `Genre`
  String get genre {
    return Intl.message(
      'Genre',
      name: 'genre',
      desc: '',
      args: [],
    );
  }

  /// `Studio`
  String get studio {
    return Intl.message(
      'Studio',
      name: 'studio',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Was not possible connect with the server. Try again later.`
  String get problemsWithTheServer {
    return Intl.message(
      'Was not possible connect with the server. Try again later.',
      name: 'problemsWithTheServer',
      desc: '',
      args: [],
    );
  }

  /// `Anime, Studio, Genre...`
  String get searchHint {
    return Intl.message(
      'Anime, Studio, Genre...',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `No Results`
  String get noResults {
    return Intl.message(
      'No Results',
      name: 'noResults',
      desc: '',
      args: [],
    );
  }

  /// `Error trying search!`
  String get searchErrorMessage {
    return Intl.message(
      'Error trying search!',
      name: 'searchErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `View all`
  String get viewAll {
    return Intl.message(
      'View all',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get info {
    return Intl.message(
      'About',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Anime Store`
  String get animeStore {
    return Intl.message(
      'Anime Store',
      name: 'animeStore',
      desc: '',
      args: [],
    );
  }

  /// `License`
  String get animeStoreLicenseTitle {
    return Intl.message(
      'License',
      name: 'animeStoreLicenseTitle',
      desc: '',
      args: [],
    );
  }

  /// `Anime Store terms of license`
  String get animeStoreLicensesubtitle {
    return Intl.message(
      'Anime Store terms of license',
      name: 'animeStoreLicensesubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get appInfoSubtitle {
    return Intl.message(
      'Info',
      name: 'appInfoSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Application name`
  String get appNameTitle {
    return Intl.message(
      'Application name',
      name: 'appNameTitle',
      desc: '',
      args: [],
    );
  }

  /// `Build number`
  String get buildNumberTitle {
    return Intl.message(
      'Build number',
      name: 'buildNumberTitle',
      desc: '',
      args: [],
    );
  }

  /// `Open source libraries`
  String get openSourceLibraryTitle {
    return Intl.message(
      'Open source libraries',
      name: 'openSourceLibraryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Open source libraries used by Anime Store`
  String get openSourceLibrarysubtitle {
    return Intl.message(
      'Open source libraries used by Anime Store',
      name: 'openSourceLibrarysubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get versionTitle {
    return Intl.message(
      'Version',
      name: 'versionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Quit`
  String get quit {
    return Intl.message(
      'Quit',
      name: 'quit',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous {
    return Intl.message(
      'Previous',
      name: 'previous',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Do you want clear all the list?`
  String get messageClearList {
    return Intl.message(
      'Do you want clear all the list?',
      name: 'messageClearList',
      desc: '',
      args: [],
    );
  }

  /// `Clear List`
  String get titleClearList {
    return Intl.message(
      'Clear List',
      name: 'titleClearList',
      desc: '',
      args: [],
    );
  }

  /// `Suggestion`
  String get suggestion {
    return Intl.message(
      'Suggestion',
      name: 'suggestion',
      desc: '',
      args: [],
    );
  }

  /// `Suggestions unavailable`
  String get noSuggestions {
    return Intl.message(
      'Suggestions unavailable',
      name: 'noSuggestions',
      desc: '',
      args: [],
    );
  }

  /// `Mark as viewed`
  String get markAsViewed {
    return Intl.message(
      'Mark as viewed',
      name: 'markAsViewed',
      desc: '',
      args: [],
    );
  }

  /// `Mark as unviewed`
  String get markAsUnviewed {
    return Intl.message(
      'Mark as unviewed',
      name: 'markAsUnviewed',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Video unavailable`
  String get videoUnavailable {
    return Intl.message(
      'Video unavailable',
      name: 'videoUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Coming soon...`
  String get episodesComingSoon {
    return Intl.message(
      'Coming soon...',
      name: 'episodesComingSoon',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}