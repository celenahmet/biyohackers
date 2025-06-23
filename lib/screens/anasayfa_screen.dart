import 'hucre_nedir_screen.dart';
import 'organeller_screen.dart';
import 'quiz_screen.dart';
import 'oyun_screen.dart';
import 'iletisim_screen.dart';
import 'uygulama_screen.dart';


class AnaSayfaScreen extends StatelessWidget {
  const AnaSayfaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BiyoHackers"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bugün ne yapmak istiyorsun?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _anaButon(context, "🧬 Hücre Bilgi Paketi", Colors.teal, const HucreNedirScreen()),
            _anaButon(context, "🔬 Organeller", Colors.purple, const OrganellerScreen()),
            _anaButon(context, "📝 Uygulama", Colors.orange, const UygulamaScreen()),
            _anaButon(context, "🎮 Oyun", Colors.blue, const OyunScreen()),
            _anaButon(context, "📬 İletişim", Colors.red, const IletisimScreen()),
          ],
        ),
      ),
    );
  }

  Widget _anaButon(BuildContext context, String label, Color renk, Widget sayfa) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: renk,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => sayfa),
          );
        },
        child: Row(
          children: [
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 16, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
