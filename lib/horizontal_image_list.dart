import 'package:flutter/material.dart';
import 'dart:math' show pi;

class HorizontalImageList extends StatefulWidget {
  final List<String> imageUrls;
  final double imageHeight;
  final double imageWidth;

  const HorizontalImageList({
    super.key,
    required this.imageUrls,
    this.imageHeight = 50,
    this.imageWidth = 50,
  });

  @override
  State<HorizontalImageList> createState() => _HorizontalImageListState();
}

class _HorizontalImageListState extends State<HorizontalImageList> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.imageHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.imageUrls.length,
        itemBuilder: (context, index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * pi,
                    child: Image.asset(
                      widget.imageUrls[index],
                      height: widget.imageHeight,
                      width: widget.imageWidth,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: widget.imageHeight,
                          width: widget.imageWidth,
                          color: Colors.grey[300],
                          child: const Icon(Icons.error),
                        );
                      },
                    ),
                  );
                },
            
            ),
          );
        },
      ),
    );
  }
} 