import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';
import 'screens/main_navigation.dart';
import 'screens/register_screen.dart';
import 'screens/forgot_password_screen.dart';

// 🌗 Tema geçişi için global notifier
ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCmtppyHQ_wAM_ehh1xhYdo3318lrNmRTw",
      authDomain: "biyohackers.firebaseapp.com",
      projectId: "biyohackers",
      storageBucket: "biyohackers.appspot.com",
      messagingSenderId: "831819062245",
      appId: "1:831819062245:web:b52846a720b75df82f2d0c",
      measurementId: "G-YDSQMCPKEM",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, _) {
        return MaterialApp(
          title: 'BiyoHackers',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: currentTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginScreen(),
            '/home': (context) => const MainNavigation(),
            '/register': (context) => const RegisterScreen(),
            '/forgot-password': (context) => const ForgotPasswordScreen(),
          },
        );
      },
    );
  }
}
