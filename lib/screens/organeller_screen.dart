import 'package:flutter/material.dart';

class OrganellerScreen extends StatefulWidget {
  const OrganellerScreen({super.key});

  @override
  State<OrganellerScreen> createState() => _OrganellerScreenState();
}

class _OrganellerScreenState extends State<OrganellerScreen> {
  bool gosterHayvanHucre = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Organeller")),
      body: Column(
        children: [
          // Butonlar
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      gosterHayvanHucre ? Colors.teal : Colors.grey.shade300,
                ),
                onPressed: () {
                  setState(() {
                    gosterHayvanHucre = true;
                  });
                },
                child: const Text("Hayvan Hücresi"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      !gosterHayvanHucre ? Colors.teal : Colors.grey.shade300,
                ),
                onPressed: () {
                  setState(() {
                    gosterHayvanHucre = false;
                  });
                },
                child: const Text("Bitki Hücresi"),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: gosterHayvanHucre
                ? const HayvanHucresiOrganelleri()
                : const BitkiHucresiOrganelleri(),
          )
        ],
      ),
    );
  }
}

class HayvanHucresiOrganelleri extends StatefulWidget {
  const HayvanHucresiOrganelleri({super.key});

  @override
  State<HayvanHucresiOrganelleri> createState() =>
      _HayvanHucresiOrganelleriState();
}

class _HayvanHucresiOrganelleriState extends State<HayvanHucresiOrganelleri> {
  String secilenOrganel = 'Çekirdek';
  String organelBilgisi =
      'Hücrenin yönetim merkezidir, DNA buradadır.';

  final Map<String, String> organelVerisi = {
    'Hücre Zarı': 'Hücreyi dış ortamdan ayırır ve madde geçişini kontrol eder.',
    'Sitoplazma': 'Organellerin içinde bulunduğu jölemsi sıvıdır.',
    'Çekirdek': 'Hücrenin yönetim merkezidir, DNA buradadır.',
    'Çekirdek Zarı': 'Çekirdeği çevreleyen çift katlı zar yapısıdır.',
    'Çekirdekçik': 'Çekirdeğin içindedir, ribozom üretiminden sorumludur.',
    'Mitokondri': 'Enerji (ATP) üretimini sağlar, hücrenin enerji santralidir.',
    'Koful': 'Atık maddeleri depolar, su dengesini sağlar.',
    'Lizozom': 'Hücre içi sindirimden sorumludur.',
    'Ribozom': 'Protein sentezi yapar.',
    'Golgi Cisimciği': 'Proteinleri paketler ve hücre dışına gönderir.',
    'Sentrozom': 'Hücre bölünmesinde görev alır.',
    'Düz Endoplazmik Retikulum': 'Yağ üretiminde görev alır.',
    'Kıvrımlı Endoplazmik Retikulum': 'Üzerindeki ribozomlarla protein üretir.',
  };

  void organelSec(String organel) {
    setState(() {
      secilenOrganel = organel;
      organelBilgisi = organelVerisi[organel] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              const SizedBox(height: 16),
              Image.asset('assets/hayvan_hucresi.png'),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: organelVerisi.keys.map((organel) {
                      return ElevatedButton(
                        onPressed: () => organelSec(organel),
                        child: Text(organel, textAlign: TextAlign.center),
                      );
                    }).toList(),
                  ),
                ),
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
        ),
      ],
    );
  }
}

class BitkiHucresiOrganelleri extends StatefulWidget {
  const BitkiHucresiOrganelleri({super.key});

  @override
  State<BitkiHucresiOrganelleri> createState() =>
      _BitkiHucresiOrganelleriState();
}

class _BitkiHucresiOrganelleriState extends State<BitkiHucresiOrganelleri> {
  String secilenOrganel = 'Çekirdek';
  String organelBilgisi =
      'Hücrenin yönetim merkezidir, DNA buradadır.';

  final Map<String, String> organelVerisi = {
    'Hücre Zarı': 'Madde giriş çıkışını sağlar.',
    'Hücre Çeperi': 'Bitki hücresine şekil verir ve korur.',
    'Sitoplazma': 'Organellerin içinde bulunduğu sıvıdır.',
    'Çekirdek': 'Yönetim merkezidir.',
    'Mitokondri': 'Enerji üretir.',
    'Koful': 'Depolama görevini yapar.',
    'Ribozom': 'Protein üretir.',
    'Golgi Cisimciği': 'Proteinleri paketler.',
    'Sentrozom': 'Hücre bölünmesinde görev alır, iğ ipliklerini oluşturarak kromozomların düzgün dağılmasını sağlar.',
    'Endoplazmik Retikulum': 'Madde taşıma ve üretiminde görev alır.',
    'Kloroplast': 'Fotosentez yapar, sadece bitkilerde bulunur.',
  };

  void organelSec(String organel) {
    setState(() {
      secilenOrganel = organel;
      organelBilgisi = organelVerisi[organel] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              const SizedBox(height: 16),
              Image.asset('assets/bitki_hucresi.png'),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: organelVerisi.keys.map((organel) {
                      return ElevatedButton(
                        onPressed: () => organelSec(organel),
                        child: Text(organel, textAlign: TextAlign.center),
                      );
                    }).toList(),
                  ),
                ),
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
        ),
      ],
    );
  }
}
