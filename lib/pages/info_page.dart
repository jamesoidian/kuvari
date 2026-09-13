import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';

class InfoPage extends StatelessWidget {
  final Future<bool> Function(Uri url)? urlLauncher;

  const InfoPage({super.key, this.urlLauncher});

  Future<void> _handleLaunchUrl(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    final launcher = urlLauncher ??
        (u) => launchUrl(u, mode: LaunchMode.externalApplication);
    try {
      final success = await launcher(uri);
      if (!success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${AppLocalizations.of(context)!.searchError} $url',
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${AppLocalizations.of(context)!.searchError} $e',
            ),
          ),
        );
      }
    }
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.teal.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.teal, size: 22.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStartStep({
    required int stepNumber,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26.0,
            height: 26.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              border: Border.all(color: Colors.teal.shade300),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$stepNumber',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey.shade800,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUseCaseItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.teal.shade700, size: 22.0),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey.shade800,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLinkTile({
    required BuildContext context,
    required String label,
    required String url,
  }) {
    return InkWell(
      onTap: () => _handleLaunchUrl(context, url),
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        child: Row(
          children: [
            const Icon(Icons.link, color: Colors.blue, size: 20.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Icon(Icons.open_in_new, size: 16.0, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final lang = Localizations.localeOf(context).languageCode;
    final licenseUrl = lang == 'fi'
        ? 'https://creativecommons.org/licenses/by-nc-sa/4.0/deed.fi'
        : (lang == 'sv'
            ? 'https://creativecommons.org/licenses/by-nc-sa/4.0/deed.sv'
            : 'https://creativecommons.org/licenses/by-nc-sa/4.0/');

    final cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      side: BorderSide(color: Colors.teal.shade100, width: 1.0),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.infoPageTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Card 1: Quick Start
            Card(
              elevation: 1.0,
              shape: cardShape,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader(
                      icon: Icons.bolt_outlined,
                      title: l10n.infoQuickStartTitle,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      l10n.infoQuickStartSubtitle,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    _buildQuickStartStep(
                      stepNumber: 1,
                      title: l10n.infoQuickStartStep1Title,
                      description: l10n.infoQuickStartStep1Desc,
                    ),
                    _buildQuickStartStep(
                      stepNumber: 2,
                      title: l10n.infoQuickStartStep2Title,
                      description: l10n.infoQuickStartStep2Desc,
                    ),
                    _buildQuickStartStep(
                      stepNumber: 3,
                      title: l10n.infoQuickStartStep3Title,
                      description: l10n.infoQuickStartStep3Desc,
                    ),
                    _buildQuickStartStep(
                      stepNumber: 4,
                      title: l10n.infoQuickStartStep4Title,
                      description: l10n.infoQuickStartStep4Desc,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Card 2: Practical AAC Use Cases
            Card(
              elevation: 1.0,
              shape: cardShape,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader(
                      icon: Icons.forum_outlined,
                      title: l10n.infoUseCasesTitle,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      l10n.infoUseCasesSubtitle,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    _buildUseCaseItem(
                      icon: Icons.check_circle_outline,
                      title: l10n.infoUseCaseChoiceTitle,
                      description: l10n.infoUseCaseChoiceDesc,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(height: 1.0),
                    ),
                    _buildUseCaseItem(
                      icon: Icons.schedule_outlined,
                      title: l10n.infoUseCaseRoutineTitle,
                      description: l10n.infoUseCaseRoutineDesc,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(height: 1.0),
                    ),
                    _buildUseCaseItem(
                      icon: Icons.record_voice_over_outlined,
                      title: l10n.infoUseCaseSpeechTitle,
                      description: l10n.infoUseCaseSpeechDesc,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Card 3: About & Attributions
            Card(
              elevation: 1.0,
              shape: cardShape,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader(
                      icon: Icons.info_outline,
                      title: l10n.infoAboutTitle,
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      l10n.infoPageParagraph1,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey.shade800,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      l10n.infoPageParagraph2,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey.shade800,
                        height: 1.4,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(height: 1.0),
                    ),
                    _buildLinkTile(
                      context: context,
                      label: l10n.papunetLinkLabel,
                      url: 'https://papunet.net/kuvatyokalut/kuvapankki/',
                    ),
                    _buildLinkTile(
                      context: context,
                      label: l10n.openSymbolsLinkLabel,
                      url: 'https://www.opensymbols.org/',
                    ),
                    _buildLinkTile(
                      context: context,
                      label: l10n.rinnekoditLinkLabel,
                      url: 'https://www.rinnekodit.fi/',
                    ),
                    _buildLinkTile(
                      context: context,
                      label: l10n.licenseLinkLabel,
                      url: licenseUrl,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
