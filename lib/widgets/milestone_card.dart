import 'package:flutter/material.dart';
import '../models.dart';

const List<Color> _pillarColors = [
  Color(0xFFFF6B6B),
  Color(0xFF6C63FF),
  Color(0xFF43C6AC),
  Color(0xFFFFB347),
];

const List<String> _pillarEmojis = ['🧠', '💬', '🖐️', '❤️'];

class MilestoneCard extends StatelessWidget {
  const MilestoneCard({required this.item, required this.index, super.key});
  final MilestoneItem item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = _pillarColors[index % _pillarColors.length];
    final emoji = _pillarEmojis[index % _pillarEmojis.length];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.4), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            item.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: color,
            ),
          ),
          const SizedBox(height: 6),
          Text(item.detail, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
