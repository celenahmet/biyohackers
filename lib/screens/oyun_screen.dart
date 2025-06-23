import 'package:flutter/material.dart';
import '../models/organel_model.dart';

class OyunScreen extends StatefulWidget {
  const OyunScreen({super.key});

  @override
  State<OyunScreen> createState() => _OyunScreenState();
}

class _OyunScreenState extends State<OyunScreen> {
  final List<Organel> organeller = [
    Organel('Çekirdek', 'Hücrenin yönetim merkezidir.'),
    Organel('Mitokondri', 'Enerji üretir.'),
    Organel('Ribozom', 'Protein sentezi yapar.'),
    Organel('Golgi', 'Proteinleri paketler.'),
  ];

  final Map<String, String> matched = {};

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chipBgColor = isDark ? Colors.teal.shade300 : Colors.teal.shade100;
    final feedbackBgColor = isDark ? Colors.blueGrey : Colors.blue;
    final dropDefaultColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    final matchedColor = isDark ? Colors.green.shade700 : Colors.green.shade100;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(title: const Text("Organelleri Eşleştir")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Organel adını görev açıklamasıyla eşleştir 👇",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: textColor),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Sol: Organel isimleri (Drag kaynakları)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: organeller.map((organel) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Draggable<String>(
                            data: organel.name,
                            feedback: Material(
                              color: Colors.transparent,
                              child: Chip(
                                label: Text(
                                  organel.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: feedbackBgColor,
                              ),
                            ),
                            childWhenDragging: Opacity(
                              opacity: 0.4,
                              child: Chip(
                                label: Text(organel.name),
                                backgroundColor: chipBgColor,
                              ),
                            ),
                            child: Chip(
                              label: Text(organel.name),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              backgroundColor: chipBgColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const VerticalDivider(),

                  /// Sağ: Görev açıklamaları (Drop hedefleri)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: organeller.map((organel) {
                        final matchedName = matched[organel.duty];
                        final isMatched = matchedName == organel.name;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: DragTarget<String>(
                            builder: (context, candidateData, rejectedData) {
                              return Container(
                                padding: const EdgeInsets.all(12),
                                height: 70,
                                decoration: BoxDecoration(
                                  color: isMatched ? matchedColor : dropDefaultColor,
                                  border: Border.all(color: Colors.black26),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    organel.duty,
                                    style: TextStyle(fontSize: 14, color: textColor),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            },
                            onAccept: (draggedName) {
                              if (draggedName == organel.name) {
                                setState(() {
                                  matched[organel.duty] = draggedName;
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Yanlış eşleştirme!"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
