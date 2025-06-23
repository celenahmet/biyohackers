import 'package:flutter/material.dart';

class HucreNedirScreen extends StatelessWidget {
  const HucreNedirScreen({super.key});

  Widget _baslik(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _paragraf(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🧬 Hücre Nedir")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _baslik("🔍 Hücre Nedir?"),
            _paragraf(
                "Canlıları oluşturan, canlılık özelliği gösteren en küçük yapı ve görev birimine hücre denir. "
                "İnsanlar, hayvanlar, bitkiler ve bazı mantarlar birçok hücrenin bir araya gelmesiyle oluşurken "
                "mikroskobik canlılar tek bir hücreden oluşur."),
            _paragraf(
                "Canlıların solunum, boşaltım gibi yaşamsal olayları hücrelerde gerçekleşir. "
                "Hücreler çok küçük yapılı olduklarından dolayı büyük bir çoğunluğu gözle görülemez, "
                "mikroskopla incelenir."),
            _paragraf("📌 Özetle: Canlıların yapı taşıdır ve yaşamsal olayları kendi başına gerçekleştirebilir."),

            _baslik("🧫 Organel Nedir?"),
            _paragraf(
                "Organeller, sitoplazma içerisinde bulunan, hücrenin faaliyetlerinde rol oynayan özel yapılardır. "
                "Her biri farklı bir görevi yerine getirir: enerji üretimi, protein sentezi, depolama gibi."),
            _paragraf("📌 Özetle: Hücre içindeki görevli yapılardır, sağlıklı işleyiş için şarttır."),

            _baslik("🌱 Bitki Hücresi ve Yapıları"),
            _paragraf(
                "Bitki hücresi genellikle dikdörtgen/köşeli yapıdadır. Hayvan hücresinden farklı olarak "
                "hücre duvarı, kloroplast ve büyük koful içerir."),
            _paragraf("🧱 Hücre Zarı"),
            _paragraf("🧱 Hücre Duvarı"),
            _paragraf("🧪 Sitoplazma"),
            _paragraf("🧬 Çekirdek"),
            _paragraf("🌿 Kloroplast"),
            _paragraf("💧 Büyük Koful"),
            _paragraf("⚡ Mitokondri"),
            _paragraf("🔬 Ribozom"),
            _paragraf("📦 Endoplazmik Retikulum"),
            _paragraf("📦 Golgi Cisimciği"),

            _baslik("🐾 Hayvan Hücresi ve Yapıları"),
            _paragraf("Genellikle yuvarlak ve düzensiz şekillidir. Hücre duvarı ve kloroplast içermez."),
            _paragraf("🧱 Hücre Zarı"),
            _paragraf("🧪 Sitoplazma"),
            _paragraf("🧬 Çekirdek"),
            _paragraf("💧 Küçük Koful"),
            _paragraf("⚡ Mitokondri"),
            _paragraf("🔬 Ribozom"),
            _paragraf("📦 Endoplazmik Retikulum"),
            _paragraf("📦 Golgi Cisimciği"),
            _paragraf("🧹 Lizozom"),

            _baslik("📦 Bilgi Paketleri (Organeller)"),
            _paragraf("1️⃣ Çekirdek: Hücrenin yönetim ve denetim merkezidir."),
            _paragraf("2️⃣ Sitoplazma: Organellerin bulunduğu sıvıdır, tüm faaliyetler burada gerçekleşir."),
            _paragraf("3️⃣ Hücre Zarı: Hücreyi sarar ve madde geçişini kontrol eder."),
            _paragraf("4️⃣ Mitokondri: Hücrenin enerji santralidir."),
            _paragraf("5️⃣ Ribozom: Protein üretiminden sorumludur."),
            _paragraf("6️⃣ Endoplazmik Retikulum: Madde taşıma ve depolama görevini üstlenir."),
            _paragraf("7️⃣ Golgi Cisimciği: Salgı üretir, paketler ve dağıtır."),
            _paragraf("8️⃣ Kloroplast (🌿): Fotosentez yapar, bitkilere özgüdür."),
            _paragraf("9️⃣ Hücre Duvarı (🧱): Bitki hücresine şekil ve dayanıklılık kazandırır."),
            _paragraf("🔟 Koful: Su ve atıkları depolar."),
            _paragraf("1️⃣1️⃣ Lizozom: Hücre içi sindirimi yapar."),
            _paragraf("1️⃣2️⃣ Sentrozom: Hücre bölünmesinde iğ ipliklerini oluşturur."),
          ],
        ),
      ),
    );
  }
}
