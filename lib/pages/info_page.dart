import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kuvari_app/l10n/app_localizations.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  // Funktio linkin avaamiseen
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.infoPageTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.infoPageParagraph1,
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.link,
                    color: Colors.blue), // Ikoni ei alleviivattu
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => _launchURL(
                      'https://papunet.net/kuvatyokalut/kuvapankki/'),
                  child: const Text(
                    'Papunetin kuvapankki / Papunet bildbank',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.link,
                    color: Colors.blue), // Ikoni ei alleviivattu
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => _launchURL('https://www.rinnekodit.fi/'),
                  child: const Text(
                    'Rinnekodit Oy',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(AppLocalizations.of(context)!.infoPageParagraph2,
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.link,
                    color: Colors.blue), // Ikoni ei alleviivattu
                const SizedBox(width: 6),
                Flexible(
                  child: GestureDetector(
                    onTap: () => _launchURL(
                        'https://creativecommons.org/licenses/by-nc-sa/4.0/deed.fi'),
                    child: Text(
                      AppLocalizations.of(context)!.licenseLinkLabel,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
