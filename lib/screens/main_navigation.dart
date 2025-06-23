import 'package:flutter/material.dart';
import 'ana_menu_screen.dart';
import 'hucre_nedir_screen.dart';
import 'organeller_screen.dart';
import 'quiz_screen.dart';
import 'oyun_screen.dart';
import 'profilim_screen.dart';
import 'iletisim_screen.dart';
import '../main.dart'; // themeNotifier için

// Bu proje içeriği Hacettepe Üniversitesi BTE202 dersi kapsamında Ahmet Çelen tarafından ekip odaklı içeriklerle ortaya çıkarılmıştır.
// Söz konusu proje yalnızca ödev için hazırlanmış olup harici kullanımı yasaktır.

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      AnaMenuScreen(onNavigate: _onItemTapped), // index 0
      const HucreNedirScreen(),                // index 1
      const OrganellerScreen(),                // index 2
      const QuizScreen(),                      // index 3
      const OyunScreen(),                      // index 4
      IletisimScreen(),                        // index 5
      const ProfilimScreen(),                  // index 6
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('BiyoHackers'),
        actions: [
          IconButton(
            icon: Icon(
              themeNotifier.value == ThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              setState(() {
                themeNotifier.value = themeNotifier.value == ThemeMode.dark
                    ? ThemeMode.light
                    : ThemeMode.dark;
              });
            },
          )
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ana Menü"),       // 0
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: "Hücre"),     // 1
          BottomNavigationBarItem(icon: Icon(Icons.science), label: "Organeller"),  // 2
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: "Quiz"),           // 3
          BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: "Oyun"), // 4
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "İletişim"),       // 5
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profilim"),     // 6
        ],
      ),
    );
  }
}
