import 'package:flutter/material.dart';
import '../games/shape_matching.dart';
import '../games/color_sorting.dart';
import '../games/balloon_pop.dart';
import '../games/animal_sound_recognition.dart';
import '../games/puzzle.dart';
import '../games/count_and_tap.dart';
import '../games/alphabet_match.dart';

/// Route manager for all micro-games
class GameRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/shape-matching':
        return MaterialPageRoute(builder: (_) => const ShapeMatchingGame());
      case '/color-sorting':
        return MaterialPageRoute(builder: (_) => const ColorSortingGame());
      case '/balloon-pop':
        return MaterialPageRoute(builder: (_) => const BalloonPopGame());
      case '/animal-sound-recognition':
        return MaterialPageRoute(
          builder: (_) => const AnimalSoundRecognitionGame(),
        );
      case '/puzzle':
        return MaterialPageRoute(builder: (_) => const PuzzleGame());
      case '/count-and-tap':
        return MaterialPageRoute(builder: (_) => const CountAndTapGame());
      case '/alphabet-match':
        return MaterialPageRoute(builder: (_) => const AlphabetMatchGame());
      default:
        return null;
    }
  }
}
