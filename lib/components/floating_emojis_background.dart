import 'package:flutter/material.dart';

class FloatingEmojisBackground extends StatefulWidget {
  final Widget child;
  const FloatingEmojisBackground({super.key, required this.child});

  @override
  State<FloatingEmojisBackground> createState() =>
      _FloatingEmojisBackgroundState();
}

class _FloatingEmojisBackgroundState extends State<FloatingEmojisBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;

  final List<Map<String, dynamic>> _emojis = [
    {'emoji': '🧬', 'top': 60.0, 'left': 30.0},
    {'emoji': '🧪', 'top': 120.0, 'right': 40.0},
    {'emoji': '🔋', 'top': 200.0, 'left': 100.0},
    {'emoji': '🧠', 'bottom': 80.0, 'left': 60.0},
    {'emoji': '🧫', 'bottom': 140.0, 'right': 30.0},
    {'emoji': '🧲', 'top': 300.0, 'right': 100.0},
    {'emoji': '🔬', 'bottom': 200.0, 'left': 140.0},
    {'emoji': '🧴', 'top': 50.0, 'right': 150.0},
    {'emoji': '🧯', 'bottom': 260.0, 'right': 80.0},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);

    _animation1 = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Positioned _buildEmoji(Map<String, dynamic> emojiData, double offset) {
    return Positioned(
      top: emojiData['top'] != null ? emojiData['top'] + offset : null,
      bottom: emojiData['bottom'] != null ? emojiData['bottom'] + offset : null,
      left: emojiData['left'],
      right: emojiData['right'],
      child: Opacity(
        opacity: 0.3,
        child: Text(
          emojiData['emoji'],
          style: const TextStyle(fontSize: 38),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1A1A1A)
        : const Color(0xFFCFD8DC);

    return Container(
      color: backgroundColor,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Stack(
          children: [
            ..._emojis.map((emojiData) => _buildEmoji(emojiData, _animation1.value)),
            widget.child,
          ],
        ),
      ),
    );
  }
}