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
      'Tämä sovellus on syntynyt yhden yksityishenkilön vapaaehtoistyönä. Sovellus käyttää sekä Papunetin että OpenSymbols-kuvapankkia ja se on kehitetty ilmaiseksi apuvälineeksi, erityisesti vaihtoehtoisen kommunikoinnin tueksi. Inspiraatio sovelluksen kehittämiseen on peräisin Rinnekotien asumisyksiköstä käytännön arjen tarpeista.';

  @override
  String get papunetLinkLabel => 'Papunetin kuvapankki';

  @override
  String get openSymbolsLinkLabel => 'OpenSymbols';

  @override
  String get rinnekoditLinkLabel => 'Rinnekodit';

  @override
  String get infoPageParagraph2 =>
      'Papunetin kuvapankin kuvat on lisensoitu Nimeä-EiKaupallinen-JaaSamoin-lisenssillä (Creative Commons). Sovellusta ja kuvia saa käyttää maksutta arjessa, opetuksessa, kuntoutuksessa ja työpaikoilla kommunikoinnin tukena, mutta kuvia ei saa myydä tai käyttää kaupallisissa tuotteissa. OpenSymbols on kokoelma avoimesti lisensoituja kuvasymboleita, joita voidaan käyttää puhetta tukevassa ja korvaavassa kommunikoinnissa.';

  @override
  String get licenseLinkLabel => 'NIMEÄ-EIKAUPALLINEN-JAASAMOIN 4.0';

  @override
  String get searchError => 'Virhe haussa:';

  @override
  String get selectedImages => 'Valitut kuvat';

  @override
  String get openSymbolsCategoryError =>
      'OpenSymbols ei tue kuvatyypin valintaa.';

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
  String get categories => 'Kuvatyypit';

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
  String get selectCategories => 'Valitse kuvatyypit';

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

  @override
  String get manageTags => 'Hallitse tägejä';

  @override
  String get addTag => 'Lisää tägi';

  @override
  String get searchTags => 'Hae tägejä...';

  @override
  String get tagName => 'Tägin nimi';

  @override
  String get createTag => 'Luo tägi';

  @override
  String get filterByTags => 'Suodata tägeillä';

  @override
  String get searchStories => 'Hae kuvajonoja tägin nimellä...';

  @override
  String get none => 'Ei mitään';

  @override
  String get editTag => 'Muokkaa tägiä';

  @override
  String get deleteTag => 'Poista tägi';

  @override
  String tagInUseWarning(Object count) {
    return 'Tämä tägi on käytössä $count kuvajonossa. Poistetaanko silti?';
  }

  @override
  String get unused => 'Ei käytössä';

  @override
  String get tagInfoLabel => 'Lisää tägejä painamalla kuvajonon nimeä pitkään';

  @override
  String get multipleTagsInfoLabel => 'Kuvajonolla voi olla monta tägiä';

  @override
  String get emptyQueueGuidance =>
      'Valitsemasi kuvat tulevat tähän jonoon. Voit koota viestin, päiväjärjestyksen tai valintataulun.';

  @override
  String viewImageStoryWithCount(int count) {
    return 'Näytä kuvajono ($count)';
  }

  @override
  String get infoQuickStartTitle => 'Pikaopas';

  @override
  String get infoQuickStartSubtitle =>
      'Näin aloitat Kuvarin käytön arjen kommunikoinnissa:';

  @override
  String get infoQuickStartStep1Title => '1. Etsi kuvia';

  @override
  String get infoQuickStartStep1Desc =>
      'Kirjoita hakusana (esim. ruoka, pukeutuminen tai tunne) hakukenttään ja valitse sopivat kuvat.';

  @override
  String get infoQuickStartStep2Title => '2. Kokoa ja muokkaa jonoa';

  @override
  String get infoQuickStartStep2Desc =>
      'Valitsemasi kuvat kertyvät etusivun jonoon. Voit vierittää jonoa sivusuunnassa, muuttaa järjestystä pitkään painamalla ja poistaa kuvia ruksista.';

  @override
  String get infoQuickStartStep3Title => '3. Näytä ja kuuntele';

  @override
  String get infoQuickStartStep3Desc =>
      'Avaa kuvajono katseluun painamalla \"Näytä kuvajono\" ja kuuntele sana puhesynteesillä napauttamalla kuvaa tai kaiutinkuvaketta.';

  @override
  String get infoQuickStartStep4Title => '4. Tallenna toistuvaa käyttöä varten';

  @override
  String get infoQuickStartStep4Desc =>
      'Voit tallentaa kootun kuvajonon tarinaksi tallennuskuvakkeesta, jolloin sama päiväjärjestys tai valintataulu on helposti käytettävissä uudelleen.';

  @override
  String get infoQuickStartStep5Title => '5. Järjestele ja hae tägeillä';

  @override
  String get infoQuickStartStep5Desc =>
      'Voit liittää tallennettuihin kuvajonoihin aihekohtaisia tägejä (esim. aamu, ruokailu tai leikki). Löydät kuvajonot myöhemmin helposti hakemalla tai suodattamalla tägien mukaan.';

  @override
  String get infoUseCasesTitle => 'Käytännön tilanteet';

  @override
  String get infoUseCasesSubtitle =>
      'Vinkkejä AAC-kommunikointiin arjen vuorovaikutuksessa:';

  @override
  String get infoUseCaseChoiceTitle => 'Valinnan tekeminen';

  @override
  String get infoUseCaseChoiceDesc =>
      'Lisää jonoon 2–3 vaihtoehtoa (esim. mehu tai vesi, ulkoilu tai peli). Anna viestijälle rauhassa aikaa osoittaa haluamaansa kuvaa ja vahvista valinta ääneen.';

  @override
  String get infoUseCaseRoutineTitle => 'Päiväjärjestys ja toimintaketjut';

  @override
  String get infoUseCaseRoutineDesc =>
      'Järjestä peräkkäiset toiminnot aikajärjestykseen (esim. aamutoimet tai siirtymät). Ennakoitavuus vähentää epävarmuutta ja tukee arjen sujuvuutta.';

  @override
  String get infoUseCaseSpeechTitle => 'Osoittaminen ja puhesynteesi';

  @override
  String get infoUseCaseSpeechDesc =>
      'Käytä puhepainiketta samalla kun osoitat kuvaa. Kuvan ja puhutun sanan yhdistäminen tukee puheen ymmärtämistä ja sanaston oppimista.';

  @override
  String get infoAboutTitle => 'Tietoa ja lähteet';

  @override
  String get editOnHomePage => 'Muokkaa kotisivulla';

  @override
  String get replaceQueueDialogTitle => 'Korvataanko nykyinen kuvajono?';

  @override
  String replaceQueueDialogBody(int count, String storyName) {
    return 'Kotisivulla on jo valittuna $count kuvaa. Haluatko korvata ne kuvajonon \"$storyName\" kuvilla?';
  }

  @override
  String get replaceAndEdit => 'Korvaa ja muokkaa';

  @override
  String editingStoryStarted(String storyName) {
    return 'Muokataan kuvajonoa: $storyName';
  }

  @override
  String editModeBannerTitle(String storyName) {
    return 'Muokataan: $storyName';
  }

  @override
  String get saveChanges => 'Tallenna muutokset';

  @override
  String get stopEditing => 'Lopeta muokkaus';

  @override
  String get discardChangesDialogTitle => 'Lopetetaanko muokkaus?';

  @override
  String get discardChangesDialogBody =>
      'Kuvajonoon on tehty muutoksia, joita ei ole tallennettu. Haluatko varmasti hylätä muutokset?';

  @override
  String get discardChanges => 'Hylkää muutokset';

  @override
  String get clearQueueDialogTitle => 'Tyhjennetäänkö kuvajono?';

  @override
  String get clearQueueDialogBody =>
      'Haluatko varmasti tyhjentää muokattavan kuvajonon kaikki kuvat?';

  @override
  String updateExistingStory(String storyName) {
    return 'Päivitä: $storyName';
  }

  @override
  String get updateExistingStoryDescription =>
      'Korvaa tallennettu versio säilyttäen tägit';

  @override
  String get saveAsNewStory => 'Tallenna uutena kuvajonona...';

  @override
  String get saveAsNewStoryDescription => 'Luo uusi kuvajono uudella nimellä';

  @override
  String get saveAsNewStoryTitle => 'Tallenna uutena';

  @override
  String storyCopySuffix(String storyName) {
    return '$storyName (kopio)';
  }

  @override
  String storyUpdated(String name) {
    return 'Kuvajono \"$name\" päivitetty.';
  }

  @override
  String get back => 'Takaisin';
}
