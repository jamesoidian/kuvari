// lib/pages/info_page.dart

import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  static const String infoText = '''
Tämä sovellus käyttää Papunetin kuvapankkia (https://papunet.net/kuvatyokalut/kuvapankki/) ja on kehitetty epäkaupallisiin tarkoituksiin ensisijaisesti tukemaan vaihtoehtoista kommunikaatiota ohjaustyössä. Inspiraatio sovelluksen kehittämiseen on peräisin Rinnekotien asumisyksikön työntekijöiltä.

Papunetin kuvapankin kuvat on lisensoitu Nimeä-Epäkaupallinen-JaaSamoin-lisenssillä (Creative Commons: https://creativecommons.org/licenses/by-nc-sa/3.0/deed.fi). Lisenssi kieltää kuvien käytön kaupallisiin tarkoituksiin, esimerkiksi maksullisissa tuotteissa.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tietoa sovelluksesta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            infoText,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
