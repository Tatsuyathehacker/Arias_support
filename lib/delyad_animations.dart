import 'package:flutter/material.dart';
import 'dart:async';

class DelayedAnimations extends StatefulWidget {
  final Widget child;
  final int delay;

  const DelayedAnimations({
    super.key,
    required this.delay,
    required this.child,
  });

  @override
  State<DelayedAnimations> createState() => _DelayedAnimationsState();
}

class _DelayedAnimationsState extends State<DelayedAnimations>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    );

    _animOffset = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(curve);

    Timer(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}
