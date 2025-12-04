// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get searchHint => 'Hae kuvia hakusanalla esim. hymy';

  @override
  String get noResults => 'Ei hakutuloksia';

  @override
  String get infoPageTitle => 'Tietoa sovelluksesta';

  @override
  String get infoPageParagraph1 =>
      'Tämä sovellus on syntynyt yhden yksityishenkilön vapaaehtoistyönä. Sovellus käyttää Papunetin kuvapankkia ja se on kehitetty epäkaupallisiin tarkoituksiin, erityisesti vaihtoehtoisen kommunikoinnin tueksi. Inspiraatio sovelluksen kehittämiseen on peräisin Rinnekotien asumisyksiköstä käytännön arjen tarpeista.';

  @override
  String get papunetLinkLabel => 'Papunetin kuvapankki';

  @override
  String get rinnekoditLinkLabel => 'Rinnekodit';

  @override
  String get infoPageParagraph2 =>
      'Papunetin kuvapankin kuvat on lisensoitu Nimeä-EiKaupallinen-JaaSamoin-lisenssillä (Creative Commons). Lisenssi kieltää kuvien käytön kaupallisiin tarkoituksiin.';

  @override
  String get licenseLinkLabel => 'NIMEÄ-EIKAUPALLINEN-JAASAMOIN 4.0';

  @override
  String get searchError => 'Virhe haussa:';

  @override
  String get selectedImages => 'Valitut kuvat';

  @override
  String get noSelectedImages => 'Ei valittuja kuvia.';

  @override
  String get clear => 'Tyhjennä';

  @override
  String get saveImageStory => 'Tallenna kuvajono';

  @override
  String get savedImageStories => 'Tallennetut kuvajonot';

  @override
  String get info => 'Tietoa sovelluksesta';

  @override
  String get language => 'Kieli';

  @override
  String get categories => 'Valitse kategoriat';

  @override
  String get cancel => 'Peruuta';

  @override
  String get ok => 'OK';

  @override
  String get home => 'Etusivu';

  @override
  String get imageViewer => 'Kuvien katselu';

  @override
  String get noImagesToView => 'Ei kuvia katsottavaksi.';

  @override
  String get search => 'Hae';

  @override
  String get selectCategories => 'Valitse kategoriat';

  @override
  String get error => 'Virhe';

  @override
  String get categoryArasaac => 'Arasaac';

  @override
  String get categoryKuvako => 'KUVAKO';

  @override
  String get categoryMulberry => 'Mulberry';

  @override
  String get categoryDrawing => 'Piirroskuva';

  @override
  String get categorySclera => 'Sclera';

  @override
  String get categoryToisto => 'Toisto';

  @override
  String get categoryPhoto => 'Valokuva';

  @override
  String get categorySign => 'Viittoma';

  @override
  String get delete => 'Poista';

  @override
  String get scrollLeft => 'Selaa vasemmalle';

  @override
  String get scrollRight => 'Selaa oikealle';

  @override
  String get emptySelectedImagesConfirm =>
      'Haluatko varmasti tyhjentää kaikki valitut kuvat?';

  @override
  String get noSavedImageStories => 'Ei tallennettuja kuvajonoja.';

  @override
  String imageStorySaved(Object name) {
    return 'Kuvajono \"$name\" tallennettu.';
  }

  @override
  String imageStoryDeleted(Object name) {
    return 'Kuvajono \"$name\" poistettu.';
  }

  @override
  String get viewImageStory => 'Näytä kuvajono';

  @override
  String get giveImageStoryName => 'Anna kuvajonon nimi';

  @override
  String get name => 'Nimi';

  @override
  String get save => 'Tallenna';

  @override
  String get clearImageStory => 'Tyhjennä kuvajono';

  @override
  String get yes => 'Kyllä';

  @override
  String get showImages => 'Näytä kuvat';

  @override
  String get noSavedStories => 'Sinulla ei ole tallennettuja kuvatarinoita.';

  @override
  String get deleteInfoLabel => 'Poista jono pyyhkäisemällä vasemmalle';
}
