import 'dart:async';
import 'package:flutter/material.dart';
import 'package:biohackers/components/floating_emojis_background.dart';

class UygulamaScreen extends StatefulWidget {
  const UygulamaScreen({super.key});

  @override
  State<UygulamaScreen> createState() => _UygulamaScreenState();
}

class _UygulamaScreenState extends State<UygulamaScreen> {
  final List<Map<String, dynamic>> sorular = [
    {
      'soru': 'Mitokondri enerji üretir.',
      'dogruMu': true,
      'aciklama': 'Mitokondri, hücrenin enerji santralidir.'
    },
    {
      'soru': 'Ribozom sindirim yapar.',
      'dogruMu': false,
      'aciklama': 'Ribozom protein sentezi yapar, sindirim yapmaz.'
    },
    {
      'soru': 'Hücre duvarı hayvan hücresinde bulunur.',
      'dogruMu': false,
      'aciklama': 'Hücre duvarı sadece bitki hücresinde bulunur.'
    },
    {
      'soru': 'Çekirdek hücrenin yönetim merkezidir.',
      'dogruMu': true,
      'aciklama': 'Çekirdek DNA’yı içerir ve hücreyi yönetir.'
    },
    {
      'soru': 'Golgi aygıtı protein sentezler.',
      'dogruMu': false,
      'aciklama': 'Golgi, sentezlenen proteinleri işler ve paketler.'
    },
  ];

  int aktifSoru = 0;
  int dogruSayisi = 0;
  bool? sonCevapDogru;
  bool oyunBittiMi = false;
  bool cozumlerGorunuyor = false;

  void cevapla(bool cevap) {
    final soru = sorular[aktifSoru];
    final dogruMu = soru['dogruMu'] as bool;

    setState(() {
      sonCevapDogru = cevap == dogruMu;
      if (sonCevapDogru!) dogruSayisi++;
    });

    Timer(const Duration(milliseconds: 1000), () {
      if (aktifSoru < sorular.length - 1) {
        setState(() {
          aktifSoru++;
          sonCevapDogru = null;
        });
      } else {
        setState(() {
          oyunBittiMi = true;
        });
      }
    });
  }

  Widget _yildizlar() {
    final oran = dogruSayisi / sorular.length;
    int yildizSayisi = (oran * 5).round();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => Icon(
          index < yildizSayisi ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 36,
        ),
      ),
    );
  }

  Widget _cozumlerListesi() {
    return ListView.builder(
      itemCount: sorular.length,
      itemBuilder: (context, index) {
        final soru = sorular[index];
        final dogruMu = soru['dogruMu'] as bool;
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade800
              : Colors.white.withOpacity(0.9),
          child: ListTile(
            leading: Icon(
              dogruMu ? Icons.check : Icons.close,
              color: dogruMu ? Colors.green : Colors.red,
            ),
            title: Text(
              soru['soru'],
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            subtitle: Text(
              "Açıklama: ${soru['aciklama']}",
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white70
                    : Colors.black54,
              ),
            ),
          ),
        );
      },
    );
  }

  void _tekrarOyna() {
    setState(() {
      aktifSoru = 0;
      dogruSayisi = 0;
      sonCevapDogru = null;
      oyunBittiMi = false;
      cozumlerGorunuyor = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Scaffold(
      body: FloatingEmojisBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: cozumlerGorunuyor
                ? Column(
                    children: [
                      Text(
                        "📖 Çözümler",
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                      const SizedBox(height: 16),
                      Expanded(child: _cozumlerListesi()),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            cozumlerGorunuyor = false;
                          });
                        },
                        icon: const Icon(Icons.arrow_back),
                        label: const Text("Geri Dön"),
                      ),
                    ],
                  )
                : oyunBittiMi
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Tebrikler!",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: textColor),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Doğru sayısı: $dogruSayisi / ${sorular.length}",
                            style: TextStyle(fontSize: 20, color: textColor),
                          ),
                          const SizedBox(height: 16),
                          _yildizlar(),
                          const SizedBox(height: 30),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            alignment: WrapAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.home),
                                label: const Text("Ana Menüye Dön"),
                              ),
                              ElevatedButton.icon(
                                onPressed: _tekrarOyna,
                                icon: const Icon(Icons.replay),
                                label: const Text("Tekrar Oyna"),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    cozumlerGorunuyor = true;
                                  });
                                },
                                icon: const Icon(Icons.menu_book),
                                label: const Text("Çözümleri Gör"),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Soru ${aktifSoru + 1}",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: textColor),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            sorular[aktifSoru]['soru'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: textColor),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () => cevapla(true),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                ),
                                child: const Text(
                                  "Doğru",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => cevapla(false),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                ),
                                child: const Text(
                                  "Yanlış",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          if (sonCevapDogru != null)
                            Icon(
                              sonCevapDogru!
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: sonCevapDogru!
                                  ? Colors.green
                                  : Colors.red,
                              size: 48,
                            ),
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}