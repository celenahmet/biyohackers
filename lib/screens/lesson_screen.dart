import 'package:flutter/material.dart';

class OrganellerScreen extends StatefulWidget {
  const OrganellerScreen({super.key});

  @override
  State<OrganellerScreen> createState() => _OrganellerScreenState();
}

class _OrganellerScreenState extends State<OrganellerScreen> {
  String secilenOrganel = 'Çekirdek';
  String organelBilgisi =
      'Görevi: Hücrenin yönetim merkezidir. Kalıtım materyali olan DNA buradadır. Hücrenin bölünmesini ve faaliyetlerini kontrol eder.';

  final Map<String, String> organelVerisi = {
    'Çekirdek':
        'Görevi: Hücrenin yönetim merkezidir. Kalıtım materyali olan DNA buradadır. Hücrenin bölünmesini ve faaliyetlerini kontrol eder.',
    'Mitokondri': 'Görevi: Hücrenin enerji üretim merkezidir.',
    'Ribozom': 'Görevi: Protein sentezini gerçekleştirir.',
    'Golgi Cisimciği': 'Görevi: Proteinleri paketler ve taşır.',
    'Lizozom': 'Görevi: Hücre içi sindirimde görevlidir.',
  };

  void organelSec(String organel) {
    setState(() {
      secilenOrganel = organel;
      organelBilgisi = organelVerisi[organel] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Organeller")),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Image.asset('assets/hayvan_hucresi.png'),
                Wrap(
                  spacing: 8,
                  children: organelVerisi.keys.map((organel) {
                    return ElevatedButton(
                      onPressed: () => organelSec(organel),
                      child: Text(organel),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const VerticalDivider(),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    secilenOrganel,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    organelBilgisi,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hayvan Hücresi')),
      body: Center(
        child: Text('Bu sayfa ders içeriği gösterecek.'),
      ),
    );
  }
}
