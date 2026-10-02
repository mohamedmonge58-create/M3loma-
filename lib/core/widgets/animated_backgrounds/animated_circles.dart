import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import 'animated_background_type.dart';

class AnimatedCircles extends StatefulWidget {
  final Widget child;
  final List<Color>? colors;
  final AnimationSpeed speed;
  final double opacity;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const AnimatedCircles({
    super.key,
    required this.child,
    this.colors,
    this.speed = AnimationSpeed.medium,
    this.opacity = 0.25,
    this.borderRadius,
    this.padding,
  });

  @override
  State<AnimatedCircles> createState() => _AnimatedCirclesState();
}

class _AnimatedCirclesState extends State<AnimatedCircles>
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
    final circleColor = (widget.colors != null && widget.colors!.isNotEmpty)
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
          final val = _controller.value;
          final scale1 = 0.8 + (val * 0.4);
          final scale2 = 1.2 - (val * 0.4);

          return Container(
            padding: effectivePadding,
            color: AppColors.surface.withValues(alpha: 0.15),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: -10 + math.sin(val * math.pi) * 8,
                  top: -5,
                  child: Transform.scale(
                    scale: scale1,
                    child: Container(
                      width: 40.r,
                      height: 40.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: circleColor.withValues(alpha: widget.opacity),
                          width: 2.w,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -10 - math.cos(val * math.pi) * 8,
                  bottom: -5,
                  child: Transform.scale(
                    scale: scale2,
                    child: Container(
                      width: 32.r,
                      height: 32.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: circleColor.withValues(alpha: widget.opacity * 0.4),
                      ),
                    ),
                  ),
                ),
                childWidget!,
              ],
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
