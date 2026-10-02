import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import 'animated_background_type.dart';

class FluidGradient extends StatefulWidget {
  final Widget child;
  final List<Color>? colors;
  final AnimationSpeed speed;
  final double opacity;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const FluidGradient({
    super.key,
    required this.child,
    this.colors,
    this.speed = AnimationSpeed.medium,
    this.opacity = 0.25,
    this.borderRadius,
    this.padding,
  });

  @override
  State<FluidGradient> createState() => _FluidGradientState();
}

class _FluidGradientState extends State<FluidGradient>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.speed.duration * 2,
    )..repeat(reverse: true);
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
              AppColors.success,
            ])
        .map((c) => c.withValues(alpha: widget.opacity))
        .toList();

    final effectiveRadius = widget.borderRadius ?? AppRadius.small;
    final effectivePadding = widget.padding ??
        EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, childWidget) {
        final t = _controller.value * math.pi * 2;
        final x1 = math.sin(t) * 0.7;
        final y1 = math.cos(t * 0.7) * 0.7;
        final x2 = math.cos(t * 0.5) * 0.7;
        final y2 = math.sin(t * 0.8) * 0.7;

        return Container(
          padding: effectivePadding,
          decoration: BoxDecoration(
            borderRadius: effectiveRadius,
            gradient: RadialGradient(
              center: Alignment(x1, y1),
              radius: 1.2 + math.sin(t) * 0.3,
              colors: [
                effectiveColors[0],
                effectiveColors[1 % effectiveColors.length],
                effectiveColors[2 % effectiveColors.length],
              ],
              stops: [
                0.0,
                0.5 + (x2 * 0.1) + (y2 * 0.1),
                1.0,
              ],
            ),
          ),
          child: childWidget,
        );
      },
      child: widget.child,
    );
  }
}
