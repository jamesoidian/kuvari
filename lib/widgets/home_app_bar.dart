import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kuvari_app/models/kuvari_image.dart';
import 'package:kuvari_app/widgets/language_selector.dart';
import 'package:kuvari_app/pages/saved_image_stories_page.dart';
import 'package:kuvari_app/pages/info_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<KuvariImage> selectedImages;
  final Function() onSave;
  final Function(Locale) setLocale;
  final FirebaseAnalytics analytics;

  const HomeAppBar({
    super.key,
    required this.selectedImages,
    required this.onSave,
    required this.setLocale,
    required this.analytics,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: LanguageSelector(
          currentLocale: Localizations.localeOf(context),
          onLocaleChange: setLocale,
        ),
      ),
      leadingWidth: 80.0,
      title: Text(
        "KUVARI",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
      shadowColor: Colors.tealAccent,
      elevation: 6.0,
      surfaceTintColor: Colors.teal.shade700,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16.0),
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.teal.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.save_as),
          onPressed: selectedImages.isNotEmpty ? onSave : null,
          tooltip: AppLocalizations.of(context)!.saveImageStory,
        ),
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SavedImageStoriesPage(),
              ),
            );
          },
          tooltip: AppLocalizations.of(context)!.savedImageStories,
        ),
        IconButton(
          icon: const Icon(Icons.info),
          onPressed: () {
            analytics.logEvent(name: 'view_info_page');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const InfoPage(),
              ),
            );
          },
          tooltip: AppLocalizations.of(context)!.info,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
