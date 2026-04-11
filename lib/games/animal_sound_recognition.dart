import 'package:flutter/material.dart';

class AnimalSoundRecognitionGame extends StatefulWidget {
  const AnimalSoundRecognitionGame({super.key});

  @override
  State<AnimalSoundRecognitionGame> createState() =>
      _AnimalSoundRecognitionGameState();
}

class _AnimalSoundRecognitionGameState extends State<AnimalSoundRecognitionGame>
    with TickerProviderStateMixin {
  late String targetAnimal;
  late List<String> options;
  bool gameComplete = false;
  late AnimationController _celebrationController;

  final Map<String, String> animalEmojis = {
    'Dog': '🐶',
    'Cat': '🐱',
    'Cow': '🐮',
    'Pig': '🐷',
  };

  final Map<String, String> animalSoundsText = {
    'Dog': 'WOOF WOOF!',
    'Cat': 'MEOW!',
    'Cow': 'MOOOOO!',
    'Pig': 'OINK OINK!',
  };

  @override
  void initState() {
    super.initState();
    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _startNewRound();
  }

  void _startNewRound() {
    setState(() {
      options = animalEmojis.keys.toList()..shuffle();
      targetAnimal = options[0];
      options.shuffle();
      gameComplete = false;
      _celebrationController.reset();
    });
  }

  void _checkMatch(String selectedAnimal) {
    if (gameComplete) return;

    if (selectedAnimal == targetAnimal) {
      setState(() {
        gameComplete = true;
      });
      _celebrationController.forward();
    }
  }

  @override
  void dispose() {
    _celebrationController.dispose();
    super.dispose();
  }

  Widget _buildAnimalButton(String animal) {
    return GestureDetector(
      onTap: () => _checkMatch(animal),
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF81C784), Color(0xFF388E3C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white, width: 4),
          boxShadow: [
            const BoxShadow(color: Color(0xFF1B5E20), offset: Offset(0, 6)),
            BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 10, offset: const Offset(0, 10)),
          ]
        ),
        child: Center(
          child: Text(
            animalEmojis[animal]!,
            style: const TextStyle(fontSize: 60),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF59D), Color(0xFFFFB300)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 16,
                left: 16,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFCA28),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [BoxShadow(color: Color(0xFFF57F17), offset: Offset(0, 4))],
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 32),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Text(
                          'WHO SAYS IT?',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 8
                              ..color = const Color(0xFFE65100),
                          ),
                        ),
                        const Text(
                          'WHO SAYS IT?',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: const Color(0xFFFF7043), width: 6),
                        boxShadow: const [BoxShadow(color: Color(0xFFD84315), offset: Offset(0, 6))],
                      ),
                      child: Text(
                        animalSoundsText[targetAnimal]!,
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFD84315),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    Wrap(
                      spacing: 32,
                      runSpacing: 32,
                      alignment: WrapAlignment.center,
                      children: options.map((animal) => _buildAnimalButton(animal)).toList(),
                    ),
                  ],
                ),
              ),

              if (gameComplete)
                Container(
                  color: Colors.black.withAlpha(100),
                  child: Center(
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _celebrationController,
                          curve: Curves.elasticOut,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF64DD17), Color(0xFF2E7D32)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.white, width: 8),
                          boxShadow: [
                            const BoxShadow(
                              color: Color(0xFF1B5E20),
                              offset: Offset(0, 8),
                            ),
                            BoxShadow(
                              color: Colors.black.withAlpha(100),
                              blurRadius: 20,
                              offset: const Offset(0, 15),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                Text(
                                  \'YOU WIN!\',
                                  style: TextStyle(
                                    fontSize: 56,
                                    fontWeight: FontWeight.w900,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 10
                                      ..color = const Color(0xFFF57F17),
                                  ),
                                ),
                                const Text(
                                  \'YOU WIN!\',
                                  style: TextStyle(
                                    fontSize: 56,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFFFFCA28),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.star_rounded, color: Color(0xFFFFCA28), size: 64),
                                Icon(Icons.star_rounded, color: Color(0xFFFFCA28), size: 80),
                                Icon(Icons.star_rounded, color: Color(0xFFFFCA28), size: 64),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (mounted) {
                                      setState(() {
                                        _startNewRound();
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFCA28),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 4),
                                      boxShadow: const [
                                        BoxShadow(color: Color(0xFFF57F17), offset: Offset(0, 4))
                                      ],
                                    ),
                                    child: const Icon(Icons.replay_rounded, color: Colors.white, size: 36),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4DD0E1),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 4),
                                      boxShadow: const [
                                        BoxShadow(color: Color(0xFF00838F), offset: Offset(0, 4))
                                      ],
                                    ),
                                    child: const Icon(Icons.home_rounded, color: Colors.white, size: 36),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () {
                                    if (mounted) {
                                      setState(() {
                                        _startNewRound();
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFF7043),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 4),
                                      boxShadow: const [
                                        BoxShadow(color: Color(0xFFD84315), offset: Offset(0, 4))
                                      ],
                                    ),
                                    child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 36),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
