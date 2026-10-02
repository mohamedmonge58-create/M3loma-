import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import 'animated_background_type.dart';

class LightSweep extends StatefulWidget {
  final Widget child;
  final List<Color>? colors;
  final AnimationSpeed speed;
  final double opacity;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const LightSweep({
    super.key,
    required this.child,
    this.colors,
    this.speed = AnimationSpeed.medium,
    this.opacity = 0.25,
    this.borderRadius,
    this.padding,
  });

  @override
  State<LightSweep> createState() => _LightSweepState();
}

class _LightSweepState extends State<LightSweep>
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
    final baseColor = (widget.colors != null && widget.colors!.isNotEmpty)
        ? widget.colors!.first
        : AppColors.primary;

    final sweepColor = (widget.colors != null && widget.colors!.length > 1)
        ? widget.colors![1]
        : Colors.white.withValues(alpha: widget.opacity);

    final effectiveRadius = widget.borderRadius ?? AppRadius.small;
    final effectivePadding = widget.padding ??
        EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, childWidget) {
        final posX = -1.5 + (_controller.value * 3.0);

        return Container(
          padding: effectivePadding,
          decoration: BoxDecoration(
            borderRadius: effectiveRadius,
            gradient: LinearGradient(
              begin: Alignment(posX - 0.2, -1.0),
              end: Alignment(posX + 0.2, 1.0),
              colors: [
                baseColor.withValues(alpha: 0.1),
                sweepColor,
                baseColor.withValues(alpha: 0.1),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: childWidget,
        );
      },
      child: widget.child,
    );
  }
}
