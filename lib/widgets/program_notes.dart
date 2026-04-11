import 'package:flutter/material.dart';

class ProgramNotes extends StatelessWidget {
  const ProgramNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text('🎓', style: TextStyle(fontSize: 32)),
            SizedBox(width: 12),
            Flexible(
              child: Text(
                'What makes this real',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'Children learn best through repetition, short sessions, warm encouragement, and clearly targeted skill practice. Every game connects to a real developmental goal.',
          style: TextStyle(
            fontSize: 15,
            height: 1.6,
            color: Color(0xFF3D5A80),
          ),
        ),
        const SizedBox(height: 24),
        const _FeatureBadge(
          emoji: '🔁',
          text: 'Spaced repetition built in',
          color: Color(0xFF6C63FF),
        ),
        const SizedBox(height: 10),
        const _FeatureBadge(
          emoji: '⚡',
          text: 'Sessions under 15 minutes',
          color: Color(0xFFFFB347),
        ),
        const SizedBox(height: 10),
        const _FeatureBadge(
          emoji: '🏆',
          text: 'Effort-first encouragement',
          color: Color(0xFF43C6AC),
        ),
      ],
    );
  }
}

class _FeatureBadge extends StatelessWidget {
  const _FeatureBadge({
    required this.emoji,
    required this.text,
    required this.color,
  });
  final String emoji;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class SafetyPanel extends StatelessWidget {
  const SafetyPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.8), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text('🛡️', style: TextStyle(fontSize: 26)),
              SizedBox(width: 10),
              Text(
                'Design principles',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const SafetyPoint(
            emoji: '👆',
            text: 'Very large touch targets for small hands',
          ),
          const SafetyPoint(
            emoji: '🔇',
            text: 'Audio-friendly prompts for pre-readers',
          ),
          const SafetyPoint(
            emoji: '🚫',
            text: 'No aggressive reward loops or overstimulation',
          ),
          const SafetyPoint(
            emoji: '📋',
            text: 'Parent-facing progress summaries',
          ),
        ],
      ),
    );
  }
}

class SafetyPoint extends StatelessWidget {
  const SafetyPoint({required this.emoji, required this.text, super.key});
  final String emoji;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Color(0xFF3D5A80),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
