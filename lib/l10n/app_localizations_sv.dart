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
      'Denna applikation har skapats av en privatperson som frivilligt arbete. Applikationen använder både Papunets bildbank och OpenSymbols och har utvecklats som ett kostnadsfritt hjälpmedel, särskilt för att stödja alternativ kommunikation. Inspirationen till att utveckla applikationen kommer från praktiska behov i vardagen på Rinnekodernas boendeenhet.';

  @override
  String get papunetLinkLabel => 'Papunets bildbank';

  @override
  String get openSymbolsLinkLabel => 'OpenSymbols';

  @override
  String get rinnekoditLinkLabel => 'Rinnekodit';

  @override
  String get infoPageParagraph2 =>
      'Bilderna i Papunets bildbank är licensierade under licensen Erkännande-IckeKommersiell-DelaLika (Creative Commons). Bilderna och applikationen får användas kostnadsfritt i vardagen, undervisning, rehabilitering och på arbetsplatser som stöd för kommunikation, men bilderna får inte säljas eller användas i kommersiella produkter. OpenSymbols är en samling öppet licensierade bildsymboler som kan användas för alternativ och kompletterande kommunikation.';

  @override
  String get licenseLinkLabel => 'ERKÄNNANDE-ICKEKOMMERSIELL-DELALIKA 4.0';

  @override
  String get searchError => 'Fel vid sökning:';

  @override
  String get selectedImages => 'Valda bilder';

  @override
  String get openSymbolsCategoryError =>
      'OpenSymbols stöder inte val av bildtyp.';

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
  String get categories => 'Bildtyper';

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
  String get selectCategories => 'Välj bildtyper';

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

  @override
  String get manageTags => 'Hantera taggar';

  @override
  String get addTag => 'Lägg till tagg';

  @override
  String get searchTags => 'Sök taggar...';

  @override
  String get tagName => 'Taggnamn';

  @override
  String get createTag => 'Skapa tagg';

  @override
  String get filterByTags => 'Filtrera efter taggar';

  @override
  String get searchStories => 'Sök bildsekvenser med taggnamn...';

  @override
  String get none => 'Ingen';

  @override
  String get editTag => 'Redigera tagg';

  @override
  String get deleteTag => 'Radera tagg';

  @override
  String tagInUseWarning(Object count) {
    return 'Denna tagg används i $count bildsekvenser. Radera ändå?';
  }

  @override
  String get unused => 'Oanvänd';

  @override
  String get tagInfoLabel =>
      'Lägg till taggar genom att trycka länge på bildsekvensens namn';

  @override
  String get multipleTagsInfoLabel => 'En bildsekvens kan ha flera taggar';

  @override
  String get emptyQueueGuidance =>
      'Dina valda bilder hamnar i denna sekvens. Du kan skapa ett meddelande, en dagsordning eller en valbricka.';

  @override
  String viewImageStoryWithCount(int count) {
    return 'Visa bildsekvens ($count)';
  }

  @override
  String get infoQuickStartTitle => 'Snabbguide';

  @override
  String get infoQuickStartSubtitle =>
      'Så här kommer du igång med Kuvari i vardagskommunikationen:';

  @override
  String get infoQuickStartStep1Title => '1. Sök bilder';

  @override
  String get infoQuickStartStep1Desc =>
      'Skriv ett sökord (t.ex. mat, kläder eller känslor) i sökrutan och välj passande bilder.';

  @override
  String get infoQuickStartStep2Title => '2. Bygg och ändra i kön';

  @override
  String get infoQuickStartStep2Desc =>
      'Valda bilder samlas i kön på startsidan. Du kan rulla kön i sidled, ändra ordning genom att trycka länge och ta bort bilder med krysset.';

  @override
  String get infoQuickStartStep3Title => '3. Visa och lyssna';

  @override
  String get infoQuickStartStep3Desc =>
      'Öppna bildsekvensen för visning genom att trycka på \"Visa bildsekvens\" och lyssna på ordet med talsyntes genom att trycka på bilden eller högtalarikonen.';

  @override
  String get infoQuickStartStep4Title => '4. Spara för återkommande användning';

  @override
  String get infoQuickStartStep4Desc =>
      'Du kan spara bildsekvensen som en berättelse via spara-ikonen så att samma dagsordning eller valkarta är lätt att använda igen.';

  @override
  String get infoQuickStartStep5Title => '5. Organisera och sök med taggar';

  @override
  String get infoQuickStartStep5Desc =>
      'Du kan koppla ämnesspecifika taggar till sparade bildsekvenser (t.ex. morgon, måltid eller lek). Du hittar enkelt bildsekvenserna senare genom att söka eller filtrera med taggar.';

  @override
  String get infoUseCasesTitle => 'Praktiska situationer';

  @override
  String get infoUseCasesSubtitle => 'Tips för AKK-kommunikation i vardagen:';

  @override
  String get infoUseCaseChoiceTitle => 'Att göra val';

  @override
  String get infoUseCaseChoiceDesc =>
      'Lägg till 2–3 alternativ i sekvensen (t.ex. saft eller vatten, utelek eller spel). Ge kommunikatören gott om tid att peka och bekräfta valet verbalt.';

  @override
  String get infoUseCaseRoutineTitle => 'Dagsordning och rutiner';

  @override
  String get infoUseCaseRoutineDesc =>
      'Ordna aktiviteter i kronologisk följd (t.ex. morgonrutin eller övergångar). Förutsägbarhet skapar trygghet och struktur i vardagen.';

  @override
  String get infoUseCaseSpeechTitle => 'Pekning och talsyntes';

  @override
  String get infoUseCaseSpeechDesc =>
      'Tryck på talsyntesknappen samtidigt som du pekar på bilden. Att kombinera bild och talat ord stödjer språkförståelse och inlärning.';

  @override
  String get infoAboutTitle => 'Information och källor';
}
