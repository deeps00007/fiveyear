import 'package:flutter/material.dart';

class HeroPanel extends StatelessWidget {
  const HeroPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF8FFAE), Color(0xFF43C6AC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF43C6AC).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Text('🗓️', style: TextStyle(fontSize: 26)),
              SizedBox(width: 10),
              Text(
                'Daily session flow',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          FlowStep(
            number: '1',
            emoji: '🌈',
            title: 'Warm up',
            detail: 'Color, sound, or touch response to settle attention.',
            color: Color(0xFFFF6B6B),
          ),
          FlowStep(
            number: '2',
            emoji: '🎮',
            title: 'Choose a skill game',
            detail: 'Shape matching, sound recognition, or count and tap.',
            color: Color(0xFF6C63FF),
          ),
          FlowStep(
            number: '3',
            emoji: '🎉',
            title: 'Celebrate effort',
            detail: 'Friendly reinforcement with no harsh failure states.',
            color: Color(0xFFFFB347),
          ),
          FlowStep(
            number: '4',
            emoji: '📊',
            title: 'Parent insight',
            detail: 'Simple progress note on what skill was practiced.',
            color: Color(0xFF43C6AC),
          ),
        ],
      ),
    );
  }
}

class FlowStep extends StatelessWidget {
  const FlowStep({
    required this.number,
    required this.emoji,
    required this.title,
    required this.detail,
    required this.color,
    super.key,
  });
  final String number;
  final String emoji;
  final String title;
  final String detail;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  detail,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: Color(0xFF3D5A80),
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
