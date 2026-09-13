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
      'This application was created by a private individual as voluntary work. The application uses the Papunet image bank and OpenSymbols and has been developed for non-commercial purposes, especially to support alternative communication. The inspiration for developing the application comes from the practical everyday needs of Rinnekodit housing units.';

  @override
  String get papunetLinkLabel => 'Papunet Image Bank';

  @override
  String get openSymbolsLinkLabel => 'OpenSymbols';

  @override
  String get rinnekoditLinkLabel => 'Rinnekodit';

  @override
  String get infoPageParagraph2 =>
      'The images in the Papunet image bank are licensed under the Attribution-NonCommercial-ShareAlike license (Creative Commons). The license prohibits the use of images for commercial purposes. OpenSymbols is a collection of open-licensed picture symbols that can be used for augmentative communication.';

  @override
  String get licenseLinkLabel => 'ATTRIBUTION-NONCOMMERCIAL-SHAREALIKE 4.0';

  @override
  String get searchError => 'Error in search:';

  @override
  String get selectedImages => 'Selected images';

  @override
  String get openSymbolsCategoryError =>
      'OpenSymbols does not support image type selection.';

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
  String get categories => 'Image types';

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
  String get selectCategories => 'Select image types';

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

  @override
  String get manageTags => 'Manage Tags';

  @override
  String get addTag => 'Add Tag';

  @override
  String get searchTags => 'Search tags...';

  @override
  String get tagName => 'Tag Name';

  @override
  String get createTag => 'Create Tag';

  @override
  String get filterByTags => 'Filter by tags';

  @override
  String get searchStories => 'Search stories...';

  @override
  String get none => 'None';

  @override
  String get editTag => 'Edit Tag';

  @override
  String get deleteTag => 'Delete Tag';

  @override
  String tagInUseWarning(Object count) {
    return 'This tag is used in $count stories. Delete anyway?';
  }

  @override
  String get unused => 'Unused';

  @override
  String get tagInfoLabel => 'Add tags by long-pressing an image story';

  @override
  String get emptyQueueGuidance =>
      'Your selected images appear in this queue. You can compose a message, daily schedule, or choice board.';

  @override
  String viewImageStoryWithCount(int count) {
    return 'View story ($count)';
  }

  @override
  String get infoQuickStartTitle => 'Quick Start';

  @override
  String get infoQuickStartSubtitle =>
      'How to get started with Kuvari for visual communication:';

  @override
  String get infoQuickStartStep1Title => '1. Search symbols';

  @override
  String get infoQuickStartStep1Desc =>
      'Type a keyword (e.g., food, clothing, or emotion) in the search field and select relevant symbols.';

  @override
  String get infoQuickStartStep2Title => '2. Assemble and edit the queue';

  @override
  String get infoQuickStartStep2Desc =>
      'Selected images collect in the queue on the home screen. You can scroll horizontally, reorder by long-pressing, and remove images with the remove button.';

  @override
  String get infoQuickStartStep3Title => '3. View and listen';

  @override
  String get infoQuickStartStep3Desc =>
      'Open the image sequence in viewer by tapping \"View story\" and listen to words with speech synthesis by tapping the image or speaker icon.';

  @override
  String get infoQuickStartStep4Title => '4. Save for repeated use';

  @override
  String get infoQuickStartStep4Desc =>
      'Save the assembled image sequence as a story using the bookmark icon so the same daily routine or choice board is easy to reuse.';

  @override
  String get infoUseCasesTitle => 'Practical Situations';

  @override
  String get infoUseCasesSubtitle =>
      'AAC communication strategies for everyday interactions:';

  @override
  String get infoUseCaseChoiceTitle => 'Making Choices';

  @override
  String get infoUseCaseChoiceDesc =>
      'Add 2–3 symbols to the queue (e.g., juice or water, outdoor play or game). Give the communicator ample time to point or choose, then verbally confirm.';

  @override
  String get infoUseCaseRoutineTitle => 'Daily Routines & Sequences';

  @override
  String get infoUseCaseRoutineDesc =>
      'Arrange consecutive activities in chronological order (e.g., morning routine, therapy transitions). Predictability provides structure and lowers anxiety.';

  @override
  String get infoUseCaseSpeechTitle => 'Pointing & Speech Modeling';

  @override
  String get infoUseCaseSpeechDesc =>
      'Use the speech button while pointing to the symbol. Pairing spoken words with visual symbols reinforces language modeling and comprehension.';

  @override
  String get infoAboutTitle => 'About & Attributions';
}
