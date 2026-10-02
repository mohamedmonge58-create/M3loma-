import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import 'animated_background_type.dart';

class SpotlightBackground extends StatefulWidget {
  final Widget child;
  final List<Color>? colors;
  final AnimationSpeed speed;
  final double opacity;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const SpotlightBackground({
    super.key,
    required this.child,
    this.colors,
    this.speed = AnimationSpeed.medium,
    this.opacity = 0.3,
    this.borderRadius,
    this.padding,
  });

  @override
  State<SpotlightBackground> createState() => _SpotlightBackgroundState();
}

class _SpotlightBackgroundState extends State<SpotlightBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.speed.duration * 1.5,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spotlightColor = (widget.colors != null && widget.colors!.isNotEmpty)
        ? widget.colors!.first
        : AppColors.primary;

    final effectiveRadius = widget.borderRadius ?? AppRadius.small;
    final effectivePadding = widget.padding ??
        EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h);

    return ClipRRect(
      borderRadius: effectiveRadius,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, childWidget) {
          final t = _controller.value * math.pi;
          final spotlightX = -0.8 + (math.sin(t) * 1.6);
          final spotlightY = -0.6 + (math.cos(t) * 1.2);

          return Container(
            padding: effectivePadding,
            decoration: BoxDecoration(
              borderRadius: effectiveRadius,
              color: AppColors.surface.withValues(alpha: 0.2),
              gradient: RadialGradient(
                center: Alignment(spotlightX, spotlightY),
                radius: 0.8,
                colors: [
                  spotlightColor.withValues(alpha: widget.opacity),
                  spotlightColor.withValues(alpha: 0.0),
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
