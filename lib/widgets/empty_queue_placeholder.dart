import 'package:flutter/material.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';

/// An instructive placeholder card displayed when the collection queue is empty.
///
/// Matches the dimensions of [SelectedImagesCarousel] (~90px total height)
/// to ensure zero layout shift when symbols are added or cleared.
class EmptyQueuePlaceholder extends StatelessWidget {
  final VoidCallback? onTap;

  const EmptyQueuePlaceholder({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Semantics(
      button: true,
      label: localizations.emptyQueueGuidance,
      hint: localizations.searchHint,
      child: Material(
        color: Colors.teal.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            height: 90.0,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.teal.shade200,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.teal.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.collections_bookmark_outlined,
                    color: Colors.teal,
                    size: 28.0,
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    localizations.emptyQueueGuidance,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.teal.shade900,
                      height: 1.3,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
