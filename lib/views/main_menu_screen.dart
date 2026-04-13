import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/game_info.dart';
import '../viewmodels/main_menu_viewmodel.dart';
import 'widgets/boy_character.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final MainMenuViewModel _viewModel = MainMenuViewModel();
  final ScrollController _scrollController = ScrollController();

  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate a parallax effect: move the background slightly slower than the list
    // You can adjust the multiplier (e.g., 0.5) to change the parallax speed
    final double backgroundOffset = -(_scrollOffset * 0.5);

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7),
      body: Stack(
        children: [
          // 1. Background SVG Layer
          Positioned(
            left: backgroundOffset,
            top: 0,
            bottom: 0,
            child: SvgPicture.asset(
              'assets/background.svg',
              // 10:3 aspect ratio will naturally be very wide compared to height
              fit: BoxFit.cover,
            ),
          ),

          // 2. Main Content Layer
          SafeArea(
            child: Row(
              children: [
                // Left Fixed Column (Character)
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9).withValues(alpha: 0.85),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Text(
                            _viewModel.greetingMessage,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const BoyCharacter(),
                      ],
                    ),
                  ),
                ),

                // Right Scrolling Column (Games)
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Choose a Game',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFFFF7043),
                            letterSpacing: 2,
                            shadows: [
                              Shadow(
                                color: Colors.white.withValues(alpha: 0.8),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: GridView.builder(
                            controller: _scrollController,
                            // Scroll horizontally
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                  childAspectRatio:
                                      0.85, // Adjust size slightly for horizontal
                                ),
                            itemCount: _viewModel.defaultGames.length,
                            itemBuilder: (context, index) {
                              final game = _viewModel.defaultGames[index];
                              return GameSlab(
                                gameInfo: game,
                                onTap: () =>
                                    _viewModel.onGameSelected(context, game),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GameSlab extends StatelessWidget {
  final GameInfo gameInfo;
  final VoidCallback onTap;

  const GameSlab({super.key, required this.gameInfo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: gameInfo.color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: gameInfo.color.withValues(alpha: 0.4),
              blurRadius: 8,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(gameInfo.icon, size: 70, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              gameInfo.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
