import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../widgets/hero_content.dart';
import '../widgets/hero_panel.dart';
import '../widgets/milestone_card.dart';
import '../widgets/game_card.dart';
import '../widgets/program_notes.dart';
import '../models.dart';

class ProgramHomePage extends StatelessWidget {
  const ProgramHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    final games = <GameModule>[
      const GameModule(
        title: 'Shape Matching',
        ageBand: '2-3 years',
        icon: Icons.category_rounded,
        color: Color(0xFF80CFA9),
        description: 'Children pair circles, squares, stars, and triangles.',
        skills: 'Shapes, focus, hand-eye coordination',
      ),
      const GameModule(
        title: 'Color Sorting',
        ageBand: '2-3 years',
        icon: Icons.palette_rounded,
        color: Color(0xFFFFB86C),
        description: 'Drag objects into the right color basket.',
        skills: 'Color recognition, sorting',
      ),
      const GameModule(
        title: 'Balloon Pop',
        ageBand: '3-4 years',
        icon: Icons.touch_app_rounded,
        color: Color(0xFF8EBBFF),
        description: 'Instruction-led popping, e.g. "pop the red balloon".',
        skills: 'Listening, reaction control',
      ),
      const GameModule(
        title: 'Animal Sounds',
        ageBand: '2-4 years',
        icon: Icons.pets_rounded,
        color: Color(0xFFF497B6),
        description: 'Play a sound and let the child choose the matching animal.',
        skills: 'Sound association, memory',
      ),
      const GameModule(
        title: 'Puzzle',
        ageBand: '3-5 years',
        icon: Icons.extension_rounded,
        color: Color(0xFFB8A1FF),
        description: 'Large-piece picture puzzles for reasoning.',
        skills: 'Problem solving, spatial awareness',
      ),
      const GameModule(
        title: 'Count & Tap',
        ageBand: '3-5 years',
        icon: Icons.looks_5_rounded,
        color: Color(0xFFFFD166),
        description: 'Count objects on screen and tap the correct number.',
        skills: 'Counting, number sense',
      ),
      const GameModule(
        title: 'Alphabet Match',
        ageBand: '4-5 years',
        icon: Icons.text_fields_rounded,
        color: Color(0xFF6FD0D8),
        description: 'Letter-to-letter and letter-to-picture matching.',
        skills: 'Letter recognition, phonics readiness',
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Colorful, playful background
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFA1C4FD), Color(0xFFC2E9FB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          ..._buildBackgroundDecorations(),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: HeroContent(theme: theme),
                            ),
                            const SizedBox(width: 32),
                            const Expanded(
                              flex: 2,
                              child: HeroPanel(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),
                      
                      // Games Section
                      Row(
                        children: [
                          const Text(
                            "🧸", 
                            style: TextStyle(fontSize: 32),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Play & Learn',
                            style: theme.textTheme.headlineLarge?.copyWith(
                              color: const Color(0xFF1E3A8A),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 220,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: games.length,
                          separatorBuilder: (context, index) => const SizedBox(width: 20),
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 300,
                              child: GameCard(game: games[index]),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 48),

                      // Footer Info section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF9A9E), Color(0xFFFECFEF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF9A9E).withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Expanded(
                              child: ProgramNotes(),
                            ),
                            const SizedBox(width: 32),
                            Expanded(
                              child: Transform.rotate(
                                angle: -0.02,
                                child: const SafetyPanel(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBackgroundDecorations() {
    return [
      Positioned(
        top: 20,
        left: 30,
        child: _AnimatedFloatingWidget(
          duration: const Duration(seconds: 4),
          child: const Text('☁️', style: TextStyle(fontSize: 60)),
        ),
      ),
      Positioned(
        top: 80,
        right: 80,
        child: _AnimatedFloatingWidget(
          duration: const Duration(seconds: 5),
          delay: const Duration(seconds: 1),
          child: const Text('☁️', style: TextStyle(fontSize: 80)),
        ),
      ),
      Positioned(
        bottom: 100,
        left: 50,
        child: Transform.rotate(
          angle: -math.pi / 12,
          child: const Text('🦒', style: TextStyle(fontSize: 100)),
        ),
      ),
      Positioned(
        bottom: 50,
        right: 100,
        child: _AnimatedFloatingWidget(
          duration: const Duration(seconds: 3),
          child: const Text('🎈', style: TextStyle(fontSize: 90)),
        ),
      ),
      Positioned(
        top: 300,
        left: -20,
        child: const Text('🦋', style: TextStyle(fontSize: 50)),
      ),
      Positioned(
        top: 400,
        right: 20,
        child: _AnimatedFloatingWidget(
          duration: const Duration(seconds: 6),
          child: const Text('🐼', style: TextStyle(fontSize: 80)),
        ),
      ),
      Positioned(
        bottom: 20,
        left: 400,
        child: Transform.rotate(
          angle: math.pi / 24,
          child: const Text('🌸', style: TextStyle(fontSize: 60)),
        ),
      ),
    ];
  }
}

class _AnimatedFloatingWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;

  const _AnimatedFloatingWidget({
    required this.child,
    this.duration = const Duration(seconds: 3),
    this.delay = Duration.zero,
  });

  @override
  State<_AnimatedFloatingWidget> createState() => _AnimatedFloatingWidgetState();
}

class _AnimatedFloatingWidgetState extends State<_AnimatedFloatingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0, end: 15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -_animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
