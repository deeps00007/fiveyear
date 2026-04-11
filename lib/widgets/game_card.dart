import 'package:flutter/material.dart';
import '../models.dart';

class GameCard extends StatefulWidget {
  const GameCard({required this.game, super.key});
  final GameModule game;

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    final game = widget.game;
    final navigator = Navigator.of(context);
    switch (game.title) {
      case 'Shape Matching':
        navigator.pushNamed('/shape-matching');
        break;
      case 'Color Sorting':
        navigator.pushNamed('/color-sorting');
        break;
      case 'Balloon Pop':
        navigator.pushNamed('/balloon-pop');
        break;
      case 'Animal Sounds':
        navigator.pushNamed('/animal-sound-recognition');
        break;
      case 'Puzzle':
        navigator.pushNamed('/puzzle');
        break;
      case 'Count & Tap':
        navigator.pushNamed('/count-and-tap');
        break;
      case 'Alphabet Match':
        navigator.pushNamed('/alphabet-match');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final game = widget.game;
    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovering = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _hovering = false);
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTap: _onTap,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: game.color.withOpacity(0.5),
                width: 2.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: game.color.withOpacity(_hovering ? 0.35 : 0.18),
                  blurRadius: _hovering ? 24 : 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: game.color.withOpacity(0.22),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Icon(
                        game.icon,
                        color: game.color,
                        size: 28,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: game.color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: game.color.withOpacity(0.4),
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        game.ageBand,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: game.color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  game.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF2D2D5E),
                  ),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: Text(
                    game.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: game.color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '✨ ${game.skills}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: game.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
