import 'package:flutter/material.dart';
import 'uygulama_screen.dart';

class AnaMenuScreen extends StatelessWidget {
  final Function(int) onNavigate;

  const AnaMenuScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : const Color(0xFFF8F6F8);
    final cardColor = isDark ? Colors.grey.shade900 : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Logo
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  height: 80,
                ),
              ),
              const SizedBox(height: 20),

              Text(
                "👋 Hoş geldin!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
              ),
              const SizedBox(height: 8),
              Text(
                "Bugün ne yapmak istiyorsun?",
                style: TextStyle(fontSize: 16, color: isDark ? Colors.grey[300] : Colors.grey[800]),
              ),
              const SizedBox(height: 20),

              _menuTile("📚 Hücre", Colors.teal.shade100, Colors.teal, 1, isDark, context),
              _menuTile("🧪 Organeller", Colors.purple.shade100, Colors.purple, 2, isDark, context),
              _menuTile("📝 Uygulama", Colors.orange.shade100, Colors.orange, 3, isDark, context),
              _menuTile("🎮 Oyun", Colors.blue.shade100, Colors.blue, 4, isDark, context),

              const SizedBox(height: 30),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    if (!isDark) BoxShadow(color: Colors.black12, blurRadius: 4),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("📢 Biliyor musun?",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
                    const SizedBox(height: 8),
                    Text(
                      "Mitokondri, hücrede enerji üretiminden sorumludur!",
                      style: TextStyle(fontSize: 14, color: textColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🧠 Uygulama butonu ayrı yönlendirme yapar
  Widget _menuTile(String label, Color bgColor, Color textColor, int index, bool isDark, BuildContext context) {
    final adjustedBgColor = isDark ? bgColor.withOpacity(0.3) : bgColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          if (label.contains("Uygulama")) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UygulamaScreen()),
            );
          } else {
            onNavigate(index);
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: adjustedBgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white : textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
