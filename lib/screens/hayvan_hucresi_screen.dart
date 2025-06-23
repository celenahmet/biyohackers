import 'package:flutter/material.dart';
import 'bitki_hucresi_screen.dart';

class HayvanHucresiScreen extends StatefulWidget {
  const HayvanHucresiScreen({super.key});

  @override
  State<HayvanHucresiScreen> createState() => _HayvanHucresiScreenState();
}

class _HayvanHucresiScreenState extends State<HayvanHucresiScreen> {
  String seciliOrganel = 'Çekirdek';

  final Map<String, String> bilgiler = {
  'Çekirdek': 'Görevi: Hücrenin yönetim merkezidir. DNA buradadır.',
  'Mitokondri': 'Görevi: Hücrenin enerji santralidir.',
  'Küçük Koful': 'Görevi: Atık madde ve sıvı depolar.',
  'Ribozom': 'Görevi: Protein üretir.',
  'Lizozom': 'Görevi: Hücre içi sindirim yapar.',
  'Golgi Cisimciği': 'Görevi: Proteinleri paketler.',
  'Hücre Zarı': 'Görevi: Madde alışverişini kontrol eder, hücreyi korur.',
  'Sitoplazma': 'Görevi: Organellerin yer aldığı sıvıdır, metabolik faaliyetler burada gerçekleşir.',
  'Çekirdekçik': 'Görevi: Ribozom üretir.',
  'Çekirdek Zarı': 'Görevi: Çekirdeği sitoplazmadan ayırır, madde geçişini sağlar.',
  'Sentrozom': 'Görevi: Hücre bölünmesinde görev alır.',
  'Düz Endoplazmik Retikulum': 'Görevi: Yağ ve karbonhidrat sentezi yapar.',
  'Kıvrımlı Endoplazmik Retikulum': 'Görevi: Protein üretiminde rol oynar, ribozom taşır.',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hayvan Hücresi")),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Image.asset('assets/hayvan_hucresi.png'),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: bilgiler.keys.map((organel) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          seciliOrganel = organel;
                        });
                      },
                      child: Text(organel),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {}, // Hayvan hücresi zaten aktif
                      child: const Text("Hayvan Hücresi"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const BitkiHucresiScreen()),
                        );
                      },
                      child: const Text("Bitki Hücresi"),
                    ),
                  ],
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
                    seciliOrganel,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    bilgiler[seciliOrganel] ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
