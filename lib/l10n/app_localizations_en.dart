// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get searchHint => 'Search images e.g. smile';

  @override
  String get noResults => 'No results';

  @override
  String get infoPageTitle => 'About the app';

  @override
  String get infoPageParagraph1 =>
      'This application was created by a private individual as voluntary work. The application uses the Papunet image bank and has been developed for non-commercial purposes, especially to support alternative communication. The inspiration for developing the application comes from the practical everyday needs of Rinnekodit housing units.';

  @override
  String get papunetLinkLabel => 'Papunet Image Bank';

  @override
  String get rinnekoditLinkLabel => 'Rinnekodit';

  @override
  String get infoPageParagraph2 =>
      'The images in the Papunet image bank are licensed under the Attribution-NonCommercial-ShareAlike license (Creative Commons). The license prohibits the use of images for commercial purposes.';

  @override
  String get licenseLinkLabel => 'ATTRIBUTION-NONCOMMERCIAL-SHAREALIKE 4.0';

  @override
  String get searchError => 'Error in search:';

  @override
  String get selectedImages => 'Selected images';

  @override
  String get noSelectedImages => 'No selected images.';

  @override
  String get clear => 'Clear';

  @override
  String get saveImageStory => 'Save image story';

  @override
  String get savedImageStories => 'Saved image stories';

  @override
  String get info => 'About the app';

  @override
  String get language => 'Language';

  @override
  String get categories => 'Select categories';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'OK';

  @override
  String get home => 'Home';

  @override
  String get imageViewer => 'Image Viewer';

  @override
  String get noImagesToView => 'No images to view.';

  @override
  String get search => 'Search';

  @override
  String get selectCategories => 'Select categories';

  @override
  String get error => 'Error';

  @override
  String get categoryArasaac => 'Arasaac';

  @override
  String get categoryKuvako => 'KUVAKO';

  @override
  String get categoryMulberry => 'Mulberry';

  @override
  String get categoryDrawing => 'Drawing';

  @override
  String get categorySclera => 'Sclera';

  @override
  String get categoryToisto => 'Repetition';

  @override
  String get categoryPhoto => 'Photo';

  @override
  String get categorySign => 'Sign';

  @override
  String get delete => 'Delete';

  @override
  String get scrollLeft => 'Scroll left';

  @override
  String get scrollRight => 'Scroll right';

  @override
  String get emptySelectedImagesConfirm =>
      'Are you sure you want to clear all selected images?';

  @override
  String get noSavedImageStories => 'No saved image stories.';

  @override
  String imageStorySaved(Object name) {
    return 'Image story \"$name\" saved.';
  }

  @override
  String imageStoryDeleted(Object name) {
    return 'Image story \"$name\" deleted.';
  }

  @override
  String get viewImageStory => 'View image story';

  @override
  String get giveImageStoryName => 'Give image story name';

  @override
  String get name => 'Name';

  @override
  String get save => 'Save';

  @override
  String get clearImageStory => 'Clear image story';

  @override
  String get yes => 'Yes';

  @override
  String get showImages => 'Show images';

  @override
  String get noSavedStories => 'You have no saved image stories.';

  @override
  String get deleteInfoLabel => 'Delete row by swiping left';
}
