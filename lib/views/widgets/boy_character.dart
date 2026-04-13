import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';
import 'package:video_player/video_player.dart';

class BoyCharacter extends StatefulWidget {
  const BoyCharacter({super.key});

  @override
  State<BoyCharacter> createState() => _BoyCharacterState();
}

class _BoyCharacterState extends State<BoyCharacter> {
  late VideoPlayerController _controller;
  ui.FragmentShader? _shader;
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
    _loadShader();
  }

  String? _errorMessage;

  Future<void> _initVideo() async {
    try {
      _controller = VideoPlayerController.asset('assets/boy.mp4');
      await _controller.initialize();
      _controller.setLooping(true);
      _controller.play();
      if (mounted) {
        setState(() {
          _isInit = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = "Video Error: $e";
        });
      }
    }
  }

  Future<void> _loadShader() async {
    try {
      // Load the chroma key fragment shader
      ui.FragmentProgram program = await ui.FragmentProgram.fromAsset(
        'shaders/chroma.frag',
      );
      setState(() {
        _shader = program.fragmentShader();
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = "Shader Error: $e";
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _shader?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return SizedBox(
        height: 140,
        width: 140,
        child: Center(
          child: Text(
            _errorMessage!,
            style: const TextStyle(color: Colors.red, fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (!_isInit || _shader == null) {
      return const SizedBox(
        height: 140,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      height: 200,
      width: 140,
      child: AnimatedSampler(
        (ui.Image image, Size size, Canvas canvas) {
          // Set the inputs for our Chroma Key Shader

          // float: resolution.x, resolution.y
          _shader!.setFloat(0, size.width);
          _shader!.setFloat(1, size.height);

          // float: keyColor.r, keyColor.g, keyColor.b (0.0 to 1.0)
          // Adjust this depending on the exact green color of your video
          // Standard green screen is usually 0.0, 1.0, 0.0
          _shader!.setFloat(2, 0.0);
          _shader!.setFloat(3, 1.0);
          _shader!.setFloat(4, 0.0);

          // float: threshold
          _shader!.setFloat(5, 0.1);

          // float: smoothing
          _shader!.setFloat(6, 0.2);
          // sampler: image
          _shader!.setImageSampler(0, image);

          // Draw the masked image
          canvas.drawRect(Offset.zero & size, Paint()..shader = _shader);
        },
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}
