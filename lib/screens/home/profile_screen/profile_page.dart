import 'package:flutter/material.dart';

class DraggableExample extends StatefulWidget {
  const DraggableExample({super.key});

  @override
  State<DraggableExample> createState() => _DraggableExampleState();
}

class _DraggableExampleState extends State<DraggableExample> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _yOffset = 0.0;
  String later = 'U';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      value: _yOffset,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          setState(() {
            _yOffset += details.delta.dy;
            _controller.value = _yOffset / 100;
          });
        },
        onVerticalDragEnd: (details) {
          if (_yOffset > 0) {
            later = 'R';
            print('Switch to next account');
          } else if (_yOffset < 0) {
            later = 'H';
            print('Switch to previous account');
          }
          setState(() {
            _yOffset = 0.0;
            _controller.value = 0.0;
          });
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _yOffset),
              child: CircleAvatar(
                backgroundColor: const Color(0xFF486064),
                radius: 21,
                child: Text(
                  later,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
