import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game_router.dart';
import 'screens/program_home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const BrightMindsApp());
}

class BrightMindsApp extends StatelessWidget {
  const BrightMindsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bright Minds',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B6B),
          primary: const Color(0xFFFF6B6B),
          secondary: const Color(0xFFFFE66D),
          surface: Colors.white,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF9F0),
        useMaterial3: true,
        fontFamily: 'Nunito',
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            height: 1.15,
            fontWeight: FontWeight.w900,
            color: Color(0xFF2D2D5E),
          ),
          headlineSmall: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF2D2D5E),
          ),
          titleLarge: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: Color(0xFF2D2D5E),
          ),
          bodyLarge: TextStyle(
            fontSize: 15,
            height: 1.5,
            color: Color(0xFF555577),
          ),
          bodyMedium: TextStyle(
            fontSize: 13,
            height: 1.5,
            color: Color(0xFF777799),
          ),
        ),
      ),
      home: const ProgramHomePage(),
      onGenerateRoute: GameRouter.onGenerateRoute,
    );
  }
}
