import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_sv.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('fi'),
    Locale('sv'),
    Locale('en')
  ];

  /// No description provided for @searchHint.
  ///
  /// In fi, this message translates to:
  /// **'Hae kuvia hakusanalla esim. hymy'**
  String get searchHint;

  /// No description provided for @noResults.
  ///
  /// In fi, this message translates to:
  /// **'Ei hakutuloksia'**
  String get noResults;

  /// No description provided for @infoPageTitle.
  ///
  /// In fi, this message translates to:
  /// **'Tietoa sovelluksesta'**
  String get infoPageTitle;

  /// No description provided for @infoPageParagraph1.
  ///
  /// In fi, this message translates to:
  /// **'Tämä sovellus on syntynyt yhden yksityishenkilön vapaaehtoistyönä. Sovellus käyttää sekä Papunetin että OpenSymbols kuvapankkia ja se on kehitetty epäkaupallisiin tarkoituksiin, erityisesti vaihtoehtoisen kommunikoinnin tueksi. Inspiraatio sovelluksen kehittämiseen on peräisin Rinnekotien asumisyksiköstä käytännön arjen tarpeista.'**
  String get infoPageParagraph1;

  /// No description provided for @papunetLinkLabel.
  ///
  /// In fi, this message translates to:
  /// **'Papunetin kuvapankki'**
  String get papunetLinkLabel;

  /// No description provided for @openSymbolsLinkLabel.
  ///
  /// In fi, this message translates to:
  /// **'OpenSymbols'**
  String get openSymbolsLinkLabel;

  /// No description provided for @rinnekoditLinkLabel.
  ///
  /// In fi, this message translates to:
  /// **'Rinnekodit'**
  String get rinnekoditLinkLabel;

  /// No description provided for @infoPageParagraph2.
  ///
  /// In fi, this message translates to:
  /// **'Papunetin kuvapankin kuvat on lisensoitu Nimeä-EiKaupallinen-JaaSamoin-lisenssillä (Creative Commons). OpenSymbols on kokoelma avoimesti lisensoituja kuvasymboleita, joita voidaan käyttää puhetta tukevassa ja korvaavassa kommunikoinnissa.'**
  String get infoPageParagraph2;

  /// No description provided for @licenseLinkLabel.
  ///
  /// In fi, this message translates to:
  /// **'NIMEÄ-EIKAUPALLINEN-JAASAMOIN 4.0'**
  String get licenseLinkLabel;

  /// No description provided for @searchError.
  ///
  /// In fi, this message translates to:
  /// **'Virhe haussa:'**
  String get searchError;

  /// No description provided for @selectedImages.
  ///
  /// In fi, this message translates to:
  /// **'Valitut kuvat'**
  String get selectedImages;

  /// No description provided for @noSelectedImages.
  ///
  /// In fi, this message translates to:
  /// **'Ei valittuja kuvia.'**
  String get noSelectedImages;

  /// No description provided for @clear.
  ///
  /// In fi, this message translates to:
  /// **'Tyhjennä'**
  String get clear;

  /// No description provided for @saveImageStory.
  ///
  /// In fi, this message translates to:
  /// **'Tallenna kuvajono'**
  String get saveImageStory;

  /// No description provided for @savedImageStories.
  ///
  /// In fi, this message translates to:
  /// **'Tallennetut kuvajonot'**
  String get savedImageStories;

  /// No description provided for @info.
  ///
  /// In fi, this message translates to:
  /// **'Tietoa sovelluksesta'**
  String get info;

  /// No description provided for @language.
  ///
  /// In fi, this message translates to:
  /// **'Kieli'**
  String get language;

  /// No description provided for @categories.
  ///
  /// In fi, this message translates to:
  /// **'Valitse kategoriat'**
  String get categories;

  /// No description provided for @cancel.
  ///
  /// In fi, this message translates to:
  /// **'Peruuta'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In fi, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @home.
  ///
  /// In fi, this message translates to:
  /// **'Etusivu'**
  String get home;

  /// No description provided for @imageViewer.
  ///
  /// In fi, this message translates to:
  /// **'Kuvien katselu'**
  String get imageViewer;

  /// No description provided for @noImagesToView.
  ///
  /// In fi, this message translates to:
  /// **'Ei kuvia katsottavaksi.'**
  String get noImagesToView;

  /// No description provided for @search.
  ///
  /// In fi, this message translates to:
  /// **'Hae'**
  String get search;

  /// No description provided for @selectCategories.
  ///
  /// In fi, this message translates to:
  /// **'Valitse kategoriat'**
  String get selectCategories;

  /// No description provided for @error.
  ///
  /// In fi, this message translates to:
  /// **'Virhe'**
  String get error;

  /// No description provided for @categoryArasaac.
  ///
  /// In fi, this message translates to:
  /// **'Arasaac'**
  String get categoryArasaac;

  /// No description provided for @categoryKuvako.
  ///
  /// In fi, this message translates to:
  /// **'KUVAKO'**
  String get categoryKuvako;

  /// No description provided for @categoryMulberry.
  ///
  /// In fi, this message translates to:
  /// **'Mulberry'**
  String get categoryMulberry;

  /// No description provided for @categoryDrawing.
  ///
  /// In fi, this message translates to:
  /// **'Piirroskuva'**
  String get categoryDrawing;

  /// No description provided for @categorySclera.
  ///
  /// In fi, this message translates to:
  /// **'Sclera'**
  String get categorySclera;

  /// No description provided for @categoryToisto.
  ///
  /// In fi, this message translates to:
  /// **'Toisto'**
  String get categoryToisto;

  /// No description provided for @categoryPhoto.
  ///
  /// In fi, this message translates to:
  /// **'Valokuva'**
  String get categoryPhoto;

  /// No description provided for @categorySign.
  ///
  /// In fi, this message translates to:
  /// **'Viittoma'**
  String get categorySign;

  /// No description provided for @delete.
  ///
  /// In fi, this message translates to:
  /// **'Poista'**
  String get delete;

  /// No description provided for @scrollLeft.
  ///
  /// In fi, this message translates to:
  /// **'Selaa vasemmalle'**
  String get scrollLeft;

  /// No description provided for @scrollRight.
  ///
  /// In fi, this message translates to:
  /// **'Selaa oikealle'**
  String get scrollRight;

  /// No description provided for @emptySelectedImagesConfirm.
  ///
  /// In fi, this message translates to:
  /// **'Haluatko varmasti tyhjentää kaikki valitut kuvat?'**
  String get emptySelectedImagesConfirm;

  /// No description provided for @noSavedImageStories.
  ///
  /// In fi, this message translates to:
  /// **'Ei tallennettuja kuvajonoja.'**
  String get noSavedImageStories;

  /// Message shown when an image story is saved
  ///
  /// In fi, this message translates to:
  /// **'Kuvajono \"{name}\" tallennettu.'**
  String imageStorySaved(Object name);

  /// Message shown when an image story is deleted
  ///
  /// In fi, this message translates to:
  /// **'Kuvajono \"{name}\" poistettu.'**
  String imageStoryDeleted(Object name);

  /// No description provided for @viewImageStory.
  ///
  /// In fi, this message translates to:
  /// **'Näytä kuvajono'**
  String get viewImageStory;

  /// No description provided for @giveImageStoryName.
  ///
  /// In fi, this message translates to:
  /// **'Anna kuvajonon nimi'**
  String get giveImageStoryName;

  /// No description provided for @name.
  ///
  /// In fi, this message translates to:
  /// **'Nimi'**
  String get name;

  /// No description provided for @save.
  ///
  /// In fi, this message translates to:
  /// **'Tallenna'**
  String get save;

  /// No description provided for @clearImageStory.
  ///
  /// In fi, this message translates to:
  /// **'Tyhjennä kuvajono'**
  String get clearImageStory;

  /// No description provided for @yes.
  ///
  /// In fi, this message translates to:
  /// **'Kyllä'**
  String get yes;

  /// No description provided for @showImages.
  ///
  /// In fi, this message translates to:
  /// **'Näytä kuvat'**
  String get showImages;

  /// No description provided for @noSavedStories.
  ///
  /// In fi, this message translates to:
  /// **'Sinulla ei ole tallennettuja kuvatarinoita.'**
  String get noSavedStories;

  /// No description provided for @deleteInfoLabel.
  ///
  /// In fi, this message translates to:
  /// **'Poista jono pyyhkäisemällä vasemmalle'**
  String get deleteInfoLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fi', 'sv'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fi':
      return AppLocalizationsFi();
    case 'sv':
      return AppLocalizationsSv();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
