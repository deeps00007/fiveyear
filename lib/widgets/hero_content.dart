import 'package:flutter/material.dart';

class HeroContent extends StatelessWidget {
  const HeroContent({this.theme, super.key});

  final ThemeData? theme;

  @override
  Widget build(BuildContext context) {
    final activeTheme = theme ?? Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Fun badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFD93D), Color(0xFFFF6B6B)],
            ),
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF6B6B).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('🌟', style: TextStyle(fontSize: 16)),
              SizedBox(width: 8),
              Text(
                'Ages 2-5 Brain Development',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Play, Learn & Grow! 🚀',
          style: activeTheme.textTheme.headlineLarge?.copyWith(
            fontSize: 38,
            color: const Color(0xFF1E3A8A),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Joyful activities designed to strengthen memory, language, focus, and confidence for young curious minds!',
          style: activeTheme.textTheme.bodyLarge?.copyWith(
            fontSize: 16,
            color: const Color(0xFF555577),
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: const [
            StatChip(
              label: '12 min',
              value: 'Daily routine',
              emoji: '⏰',
              color: Color(0xFFFFB347),
            ),
            StatChip(
              label: '4 domains',
              value: 'Core learning',
              emoji: '📚',
              color: Color(0xFF6FD0D8),
            ),
            StatChip(
              label: 'Gentle',
              value: 'Feedback style',
              emoji: '💛',
              color: Color(0xFF80CFA9),
            ),
          ],
        ),
      ],
    );
  }
}

class StatChip extends StatelessWidget {
  const StatChip({
    required this.label,
    required this.value,
    required this.emoji,
    required this.color,
    super.key,
  });
  final String label;
  final String value;
  final String emoji;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4), width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: color.withOpacity(0.9),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF777799),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
