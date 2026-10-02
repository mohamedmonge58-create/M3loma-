import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import 'animated_background_type.dart';

class MovingGradient extends StatefulWidget {
  final Widget child;
  final List<Color>? colors;
  final AnimationSpeed speed;
  final double opacity;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const MovingGradient({
    super.key,
    required this.child,
    this.colors,
    this.speed = AnimationSpeed.medium,
    this.opacity = 0.25,
    this.borderRadius,
    this.padding,
  });

  @override
  State<MovingGradient> createState() => _MovingGradientState();
}

class _MovingGradientState extends State<MovingGradient>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.speed.duration,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
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
        EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, childWidget) {
        final alignX = -0.8 + (_animation.value * 1.6);
        final alignY = -0.2 + (_animation.value * 0.4);

        return Container(
          padding: effectivePadding,
          decoration: BoxDecoration(
            borderRadius: effectiveRadius,
            gradient: LinearGradient(
              begin: Alignment(alignX, alignY),
              end: Alignment(-alignX, -alignY),
              colors: effectiveColors,
            ),
          ),
          child: childWidget,
        );
      },
      child: widget.child,
    );
  }
}
