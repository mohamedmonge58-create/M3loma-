import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import 'animated_background_type.dart';

class FloatingBlobs extends StatefulWidget {
  final Widget child;
  final List<Color>? colors;
  final AnimationSpeed speed;
  final double opacity;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const FloatingBlobs({
    super.key,
    required this.child,
    this.colors,
    this.speed = AnimationSpeed.medium,
    this.opacity = 0.3,
    this.borderRadius,
    this.padding,
  });

  @override
  State<FloatingBlobs> createState() => _FloatingBlobsState();
}

class _FloatingBlobsState extends State<FloatingBlobs>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.speed.duration * 1.5,
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
          final t = _controller.value * 2 * math.pi;

          return Container(
            padding: effectivePadding,
            color: AppColors.surface.withValues(alpha: 0.2),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 8 + math.sin(t) * 16,
                  top: 2 + math.cos(t) * 6,
                  child: Container(
                    width: 26.r,
                    height: 26.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: effectiveColors[0],
                      boxShadow: [
                        BoxShadow(
                          color: effectiveColors[0],
                          blurRadius: 14,
                          spreadRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 10 + math.cos(t * 0.8) * 14,
                  bottom: 2 + math.sin(t * 0.8) * 8,
                  child: Container(
                    width: 22.r,
                    height: 22.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: effectiveColors[math.min(1, effectiveColors.length - 1)],
                      boxShadow: [
                        BoxShadow(
                          color: effectiveColors[math.min(1, effectiveColors.length - 1)],
                          blurRadius: 12,
                          spreadRadius: 5,
                        ),
                      ],
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
