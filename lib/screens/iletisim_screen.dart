import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IletisimScreen extends StatelessWidget {
  IletisimScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _adSoyadController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefonController = TextEditingController();
  final _mesajController = TextEditingController();

  Future<void> _mesajGonder(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('contactMessages').add({
        'adSoyad': _adSoyadController.text,
        'email': _emailController.text,
        'telefon': _telefonController.text,
        'mesaj': _mesajController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mesajınız başarıyla gönderildi!')),
      );

      _formKey.currentState?.reset();
      _adSoyadController.clear();
      _emailController.clear();
      _telefonController.clear();
      _mesajController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gönderim hatası: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('İletişim ve Destek')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('💬 Geri Bildirim Formu',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _adSoyadController,
                    decoration: const InputDecoration(
                      labelText: 'Ad Soyad',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Bu alan zorunludur' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-posta Adresi',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Bu alan zorunludur';
                      if (!value.contains('@')) return 'Geçerli bir e-posta girin';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _telefonController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Telefon Numarası',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Bu alan zorunludur' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _mesajController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Mesajınız',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.message),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Mesaj boş bırakılamaz' : null,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    label: const Text('Gönder'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _mesajGonder(context);
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('👨‍💻 Geliştirici ve Şikayet Maili',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.email_outlined),
              title: const Text('Ahmet Çelen'),
              subtitle: const Text('ahmetcelen@hacettepe.edu.tr'),
            ),
            const SizedBox(height: 24),
            const Text('👥 Proje Ekibi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _ekipGorev("📌 Proje Yöneticisi", ["Sude Nur Tunç"]),
            _ekipGorev("📚 İçerik Koordinatörü", [
              "İrem Nur Saral",
              "Tuba Solak",
              "Sude Nur Tunç"
            ]),
            _ekipGorev("💻 Kodlama", [
              "Ahmet Çelen - Mobil Uygulama",
              "İlkhan Arda Akmaca - Web Uygulama"
            ]),
            _ekipGorev("🎨 Grafik Tasarım Koordinatörü", [
              "İlkhan Arda Akmaca",
              "İrem Nur Saral"
            ]),
            _ekipGorev("🛠 Teknik Tasarım Koordinatörü", [
              "Ahmet Çelen",
              "Hakan Kaan Aşıcı"
            ]),
            _ekipGorev("🔄 Süreç Değerlendirme", [
              "İrem Nur Saral",
              "Tuba Solak",
              "Sude Nur Tunç"
            ]),
            _ekipGorev("🐞 Hata Analisti", ["İlkhan Arda Akmaca"]),
          ],
        ),
      ),
    );
  }

  Widget _ekipGorev(String baslik, List<String> isimler) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(baslik, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(isimler.join(', ')),
        ],
      ),
    );
  }
}
