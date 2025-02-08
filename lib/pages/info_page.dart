import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      appBar: AppBar(title: const Text('Tietoa sovelluksesta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tämä sovellus on syntynyt ydhen yksityishenkilön vapaaehtoistyönä. '
              'Sovellus käyttää Papunetin kuvapankkia ja se on kehitetty '
              'epäkaupallisiin tarkoituksiin, erityisesti vaihtoehtoisen kommunikoinnin tueksi. '
              'Inspiraatio sovelluksen kehittämiseen on peräisin Rinnekotien asumisyksiköstä käytännön arjen tarpeista.',
              style: TextStyle(fontSize: 16),
            ),
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
                    'Papunetin kuvapankki',
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
                    'Rinnekodit',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Papunetin kuvapankin kuvat on lisensoitu Nimeä-Eikaupallinen-JaaSamoin-lisenssillä (Creative Commons). '
              'Lisenssi kieltää kuvien käytön kaupallisiin tarkoituksiin.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.link,
                    color: Colors.blue), // Ikoni ei alleviivattu
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => _launchURL(
                      'https://creativecommons.org/licenses/by-nc-sa/4.0/deed.fi'),
                  child: const Text(
                    'NIMEÄ-EIKAUPALLINEN-JAASAMOIN 4.0',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
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
