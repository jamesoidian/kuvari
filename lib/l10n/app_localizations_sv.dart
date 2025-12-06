// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get searchHint => 'Sök bilder med sökordet t.ex. leende';

  @override
  String get noResults => 'Inga sökresultat';

  @override
  String get infoPageTitle => 'Om applikationen';

  @override
  String get infoPageParagraph1 =>
      'Denna applikation har skapats av en privatperson som frivilligt arbete. Applikationen använder både Papunets bildbank och OpenSymbols och har utvecklats för ideellt bruk, särskilt för att stödja alternativ kommunikation. Inspirationen till att utveckla applikationen kommer från praktiska behov i vardagen på Rinnekodernas boendeenhet.';

  @override
  String get papunetLinkLabel => 'Papunets bildbank';

  @override
  String get openSymbolsLinkLabel => 'OpenSymbols';

  @override
  String get rinnekoditLinkLabel => 'Rinnekodit';

  @override
  String get infoPageParagraph2 =>
      'Bilderna i Papunets bildbank är licensierade under licensen Erkännande-IckeKommersiell-DelaLika (Creative Commons). OpenSymbols är en kokoelma av lisensoerade bildsymboler, som kan användas för att stödja alternativ kommunikation. OpenSymbols är en samling öppet licensierade bildsymboler som kan användas för alternativ och kompletterande kommunikation.';

  @override
  String get licenseLinkLabel => 'ERKÄNNANDE-ICKEKOMMERSIELL-DELALIKA 4.0';

  @override
  String get searchError => 'Fel vid sökning:';

  @override
  String get selectedImages => 'Valda bilder';

  @override
  String get openSymbolsCategoryError => 'OpenSymbols stöder inte kategorival.';

  @override
  String get noSelectedImages => 'Inga valda bilder.';

  @override
  String get clear => 'Rensa';

  @override
  String get saveImageStory => 'Spara bildsekvens';

  @override
  String get savedImageStories => 'Sparade bildsekvenser';

  @override
  String get info => 'Om applikationen';

  @override
  String get language => 'Språk';

  @override
  String get categories => 'Välj kategorier';

  @override
  String get cancel => 'Avbryt';

  @override
  String get ok => 'OK';

  @override
  String get home => 'Hem';

  @override
  String get imageViewer => 'Bildvisare';

  @override
  String get noImagesToView => 'Inga bilder att visa.';

  @override
  String get search => 'Sök';

  @override
  String get selectCategories => 'Välj kategorier';

  @override
  String get error => 'Fel';

  @override
  String get categoryArasaac => 'Arasaac';

  @override
  String get categoryKuvako => 'KUVAKO';

  @override
  String get categoryMulberry => 'Mulberry';

  @override
  String get categoryDrawing => 'Ritning';

  @override
  String get categorySclera => 'Sclera';

  @override
  String get categoryToisto => 'Upprepning';

  @override
  String get categoryPhoto => 'Fotografi';

  @override
  String get categorySign => 'Tecken';

  @override
  String get delete => 'Radera';

  @override
  String get scrollLeft => 'Bläddra vänster';

  @override
  String get scrollRight => 'Bläddra höger';

  @override
  String get emptySelectedImagesConfirm =>
      'Vill du verkligen rensa alla valda bilder?';

  @override
  String get noSavedImageStories => 'Inga sparade bildsekvenser.';

  @override
  String imageStorySaved(Object name) {
    return 'Bildsekvensen \"$name\" har sparats.';
  }

  @override
  String imageStoryDeleted(Object name) {
    return 'Bildsekvensen \"$name\" har raderats.';
  }

  @override
  String get viewImageStory => 'Visa bildsekvens';

  @override
  String get giveImageStoryName => 'Ange namn på bildsekvensen';

  @override
  String get name => 'Namn';

  @override
  String get save => 'Spara';

  @override
  String get clearImageStory => 'Rensa bildsekvens';

  @override
  String get yes => 'Ja';

  @override
  String get showImages => 'Visa bilder';

  @override
  String get noSavedStories => 'Du har inga sparade bildberättelser.';

  @override
  String get deleteInfoLabel => 'Radera raden genom att svepa åt vänster';
}
