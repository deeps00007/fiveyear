import 'package:flutter/material.dart';
import '../models/game_info.dart';

class MainMenuViewModel extends ChangeNotifier {
  final List<GameInfo> defaultGames = [
    GameInfo(title: 'Colors', icon: Icons.color_lens, color: Colors.redAccent),
    GameInfo(
      title: 'Numbers',
      icon: Icons.onetwothree,
      color: Colors.blueAccent,
    ),
    GameInfo(title: 'Shapes', icon: Icons.category, color: Colors.purpleAccent),
    GameInfo(title: 'Animals', icon: Icons.pets, color: Colors.green),
  ];

  String get greetingMessage => "Hi friend! \nWhat should we play today?";

  void onGameSelected(BuildContext context, GameInfo game) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Starting \${game.title}!',
          style: const TextStyle(fontSize: 20),
        ),
        backgroundColor: game.color,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
