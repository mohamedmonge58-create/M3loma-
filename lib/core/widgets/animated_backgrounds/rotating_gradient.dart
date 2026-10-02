import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import 'animated_background_type.dart';

class RotatingGradient extends StatefulWidget {
  final Widget child;
  final List<Color>? colors;
  final AnimationSpeed speed;
  final double opacity;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const RotatingGradient({
    super.key,
    required this.child,
    this.colors,
    this.speed = AnimationSpeed.medium,
    this.opacity = 0.25,
    this.borderRadius,
    this.padding,
  });

  @override
  State<RotatingGradient> createState() => _RotatingGradientState();
}

class _RotatingGradientState extends State<RotatingGradient>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.speed.duration * 2,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColors = (widget.colors ??
            [
              AppColors.primary,
              AppColors.warning,
              AppColors.primary,
            ])
        .map((c) => c.withValues(alpha: widget.opacity))
        .toList();

    final effectiveRadius = widget.borderRadius ?? AppRadius.small;
    final effectivePadding = widget.padding ??
        EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h);

    return ClipRRect(
      borderRadius: effectiveRadius,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, childWidget) {
          final angle = _controller.value * 2 * math.pi;

          return Container(
            padding: effectivePadding,
            decoration: BoxDecoration(
              borderRadius: effectiveRadius,
              gradient: SweepGradient(
                transform: GradientRotation(angle),
                colors: effectiveColors,
              ),
            ),
            child: childWidget,
          );
        },
        child: widget.child,
      ),
    );
  }
}
