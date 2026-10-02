import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import 'animated_background_type.dart';

class ShimmerWave extends StatefulWidget {
  final Widget child;
  final List<Color>? colors;
  final AnimationSpeed speed;
  final double opacity;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const ShimmerWave({
    super.key,
    required this.child,
    this.colors,
    this.speed = AnimationSpeed.medium,
    this.opacity = 0.25,
    this.borderRadius,
    this.padding,
  });

  @override
  State<ShimmerWave> createState() => _ShimmerWaveState();
}

class _ShimmerWaveState extends State<ShimmerWave>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.speed.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final waveColor = (widget.colors != null && widget.colors!.isNotEmpty)
        ? widget.colors!.first
        : AppColors.primary;

    final effectiveRadius = widget.borderRadius ?? AppRadius.small;
    final effectivePadding = widget.padding ??
        EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, childWidget) {
        final t = _controller.value * 2 * math.pi;
        final waveOffset = math.sin(t) * 0.4;

        return Container(
          padding: effectivePadding,
          decoration: BoxDecoration(
            borderRadius: effectiveRadius,
            gradient: LinearGradient(
              begin: Alignment(-1.0 + waveOffset, -0.5),
              end: Alignment(1.0 + waveOffset, 0.5),
              colors: [
                waveColor.withValues(alpha: widget.opacity * 0.4),
                Colors.white.withValues(alpha: widget.opacity),
                waveColor.withValues(alpha: widget.opacity * 0.4),
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
