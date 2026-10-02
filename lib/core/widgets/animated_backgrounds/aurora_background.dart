import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import 'animated_background_type.dart';

class AuroraBackground extends StatefulWidget {
  final Widget child;
  final List<Color>? colors;
  final AnimationSpeed speed;
  final double opacity;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const AuroraBackground({
    super.key,
    required this.child,
    this.colors,
    this.speed = AnimationSpeed.medium,
    this.opacity = 0.25,
    this.borderRadius,
    this.padding,
  });

  @override
  State<AuroraBackground> createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<AuroraBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.speed.duration * 1.8,
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

    return ClipRRect(
      borderRadius: effectiveRadius,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, childWidget) {
          final t = _controller.value * math.pi;

          return Container(
            padding: effectivePadding,
            decoration: BoxDecoration(
              borderRadius: effectiveRadius,
              color: AppColors.surface.withValues(alpha: 0.2),
              gradient: LinearGradient(
                begin: Alignment(-1.0 + math.sin(t) * 0.5, -1.0),
                end: Alignment(1.0 - math.cos(t) * 0.5, 1.0),
                colors: [
                  effectiveColors[0],
                  effectiveColors[1 % effectiveColors.length],
                  effectiveColors[2 % effectiveColors.length],
                ],
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
