import 'package:flutter/material.dart';

class GameModule {
  const GameModule({
    required this.title,
    required this.ageBand,
    required this.icon,
    required this.color,
    required this.description,
    required this.skills,
  });

  final String title;
  final String ageBand;
  final IconData icon;
  final Color color;
  final String description;
  final String skills;
}

class MilestoneItem {
  const MilestoneItem({required this.title, required this.detail});

  final String title;
  final String detail;
}
