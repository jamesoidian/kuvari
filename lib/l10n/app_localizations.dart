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

  /// No description provided for @openSymbolsCategoryError.
  ///
  /// In fi, this message translates to:
  /// **'OpenSymbols ei tue kuvatyypin valintaa.'**
  String get openSymbolsCategoryError;

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
  /// **'Kuvatyypit'**
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
  /// **'Valitse kuvatyypit'**
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

  /// No description provided for @manageTags.
  ///
  /// In fi, this message translates to:
  /// **'Hallitse avainsanoja'**
  String get manageTags;

  /// No description provided for @addTag.
  ///
  /// In fi, this message translates to:
  /// **'Lisää avainsana'**
  String get addTag;

  /// No description provided for @searchTags.
  ///
  /// In fi, this message translates to:
  /// **'Hae avainsanoja...'**
  String get searchTags;

  /// No description provided for @tagName.
  ///
  /// In fi, this message translates to:
  /// **'Avainsanan nimi'**
  String get tagName;

  /// No description provided for @createTag.
  ///
  /// In fi, this message translates to:
  /// **'Luo avainsana'**
  String get createTag;

  /// No description provided for @filterByTags.
  ///
  /// In fi, this message translates to:
  /// **'Suodata avainsanoilla'**
  String get filterByTags;

  /// No description provided for @searchStories.
  ///
  /// In fi, this message translates to:
  /// **'Hae tarinoita...'**
  String get searchStories;

  /// No description provided for @none.
  ///
  /// In fi, this message translates to:
  /// **'Ei mitään'**
  String get none;

  /// No description provided for @editTag.
  ///
  /// In fi, this message translates to:
  /// **'Muokkaa avainsanaa'**
  String get editTag;

  /// No description provided for @deleteTag.
  ///
  /// In fi, this message translates to:
  /// **'Poista avainsana'**
  String get deleteTag;

  /// No description provided for @tagInUseWarning.
  ///
  /// In fi, this message translates to:
  /// **'Tämä avainsana on käytössä {count} tarinassa. Poistetaanko silti?'**
  String tagInUseWarning(Object count);

  /// No description provided for @unused.
  ///
  /// In fi, this message translates to:
  /// **'Ei käytössä'**
  String get unused;

  /// No description provided for @tagInfoLabel.
  ///
  /// In fi, this message translates to:
  /// **'Lisää avainsanoja painamalla kuvajonoa pitkään'**
  String get tagInfoLabel;

  /// Guidance text displayed in the collection queue empty state card
  ///
  /// In fi, this message translates to:
  /// **'Valitsemasi kuvat tulevat tähän jonoon. Voit koota viestin, päiväjärjestyksen tai valintataulun.'**
  String get emptyQueueGuidance;

  /// Label for the extended FAB showing count of queued images
  ///
  /// In fi, this message translates to:
  /// **'Näytä kuvajono ({count})'**
  String viewImageStoryWithCount(int count);

  /// Title of the Quick Start card on InfoPage
  ///
  /// In fi, this message translates to:
  /// **'Pikaopas'**
  String get infoQuickStartTitle;

  /// Subtitle explaining how to start using Kuvari
  ///
  /// In fi, this message translates to:
  /// **'Näin aloitat Kuvarin käytön arjen kommunikoinnissa:'**
  String get infoQuickStartSubtitle;

  /// Step 1 title in Quick Start
  ///
  /// In fi, this message translates to:
  /// **'1. Etsi kuvia'**
  String get infoQuickStartStep1Title;

  /// Step 1 description in Quick Start
  ///
  /// In fi, this message translates to:
  /// **'Kirjoita hakusana (esim. ruoka, pukeutuminen tai tunne) hakukenttään ja valitse sopivat kuvat.'**
  String get infoQuickStartStep1Desc;

  /// Step 2 title in Quick Start
  ///
  /// In fi, this message translates to:
  /// **'2. Kokoa ja muokkaa jonoa'**
  String get infoQuickStartStep2Title;

  /// Step 2 description in Quick Start
  ///
  /// In fi, this message translates to:
  /// **'Valitsemasi kuvat kertyvät etusivun jonoon. Voit vierittää jonoa sivusuunnassa, muuttaa järjestystä pitkään painamalla ja poistaa kuvia ruksista.'**
  String get infoQuickStartStep2Desc;

  /// Step 3 title in Quick Start
  ///
  /// In fi, this message translates to:
  /// **'3. Näytä ja kuuntele'**
  String get infoQuickStartStep3Title;

  /// Step 3 description in Quick Start
  ///
  /// In fi, this message translates to:
  /// **'Avaa kuvajono katseluun painamalla \"Näytä kuvajono\" ja kuuntele sana puhesynteesillä napauttamalla kuvaa tai kaiutinkuvaketta.'**
  String get infoQuickStartStep3Desc;

  /// Step 4 title in Quick Start
  ///
  /// In fi, this message translates to:
  /// **'4. Tallenna toistuvaa käyttöä varten'**
  String get infoQuickStartStep4Title;

  /// Step 4 description in Quick Start
  ///
  /// In fi, this message translates to:
  /// **'Voit tallentaa kootun kuvajonon tarinaksi kirjanmerkkikuvakkeesta, jolloin sama päiväjärjestys tai valintataulu on helposti käytettävissä uudelleen.'**
  String get infoQuickStartStep4Desc;

  /// Title of Practical Use Cases section on InfoPage
  ///
  /// In fi, this message translates to:
  /// **'Käytännön tilanteet'**
  String get infoUseCasesTitle;

  /// Subtitle for Practical Use Cases section
  ///
  /// In fi, this message translates to:
  /// **'Vinkkejä AAC-kommunikointiin arjen vuorovaikutuksessa:'**
  String get infoUseCasesSubtitle;

  /// Title for choice-making use case
  ///
  /// In fi, this message translates to:
  /// **'Valinnan tekeminen'**
  String get infoUseCaseChoiceTitle;

  /// Description for choice-making use case
  ///
  /// In fi, this message translates to:
  /// **'Lisää jonoon 2–3 vaihtoehtoa (esim. mehu tai vesi, ulkoilu tai peli). Anna viestijälle rauhassa aikaa osoittaa haluamaansa kuvaa ja vahvista valinta ääneen.'**
  String get infoUseCaseChoiceDesc;

  /// Title for daily routine and sequences use case
  ///
  /// In fi, this message translates to:
  /// **'Päiväjärjestys ja toimintaketjut'**
  String get infoUseCaseRoutineTitle;

  /// Description for daily routine and sequences use case
  ///
  /// In fi, this message translates to:
  /// **'Järjestä peräkkäiset toiminnot aikajärjestykseen (esim. aamutoimet tai siirtymät). Ennakoitavuus vähentää epävarmuutta ja tukee arjen sujuvuutta.'**
  String get infoUseCaseRoutineDesc;

  /// Title for pointing and speech modeling use case
  ///
  /// In fi, this message translates to:
  /// **'Osoittaminen ja puhesynteesi'**
  String get infoUseCaseSpeechTitle;

  /// Description for pointing and speech modeling use case
  ///
  /// In fi, this message translates to:
  /// **'Käytä puhepainiketta samalla kun osoitat kuvaa. Kuvan ja puhutun sanan yhdistäminen tukee puheen ymmärtämistä ja sanaston oppimista.'**
  String get infoUseCaseSpeechDesc;

  /// Title of About & Attributions section on InfoPage
  ///
  /// In fi, this message translates to:
  /// **'Tietoa ja lähteet'**
  String get infoAboutTitle;
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
