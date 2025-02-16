import 'package:flutter/material.dart';
import 'package:kuvari_app/widgets/kuvari_search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeSearchSection extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback onClear;
  final VoidCallback onTap;
  final VoidCallback onSelectCategories;
  final bool showFilterBadge;

  const HomeSearchSection({
    Key? key,
    required this.controller,
    required this.onSearch,
    required this.onClear,
    required this.onTap,
    required this.onSelectCategories,
    required this.showFilterBadge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: KuvariSearchBar(
            controller: controller,
            onSearch: onSearch,
            onClear: onClear,
            onTap: onTap,
          ),
        ),
        IconButton(
          icon: Stack(
            children: [
              const Icon(Icons.filter_list),
              if (showFilterBadge)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          onPressed: onSelectCategories,
          tooltip: AppLocalizations.of(context)!.selectCategories,
        ),
      ],
    );
  }
}
