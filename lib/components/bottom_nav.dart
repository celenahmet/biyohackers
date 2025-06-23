import 'package:flutter/material.dart';
import '../screens/ana_menu_screen.dart';
import '../screens/hucre_nedir_screen.dart';
import '../screens/organeller_screen.dart';
import '../screens/quiz_screen.dart';
import '../screens/oyun_screen.dart';
import '../screens/profilim_screen.dart';
import '../screens/uygulama_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      AnaMenuScreen(onNavigate: _onItemTapped), // Ana menüde yönlendirme sağlanıyor
      const HucreNedirScreen(),
      const OrganellerScreen(),
      const QuizScreen(),
      const OyunScreen(),
      const ProfilimScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ana Menü"),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: "Hücre"),
          BottomNavigationBarItem(icon: Icon(Icons.science), label: "Organeller"),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: "Quiz"),
          BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: "Oyun"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profilim"),
        ],
      ),
    );
  }
}
