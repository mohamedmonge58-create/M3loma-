import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import 'animated_background_type.dart';

class GlowPulse extends StatefulWidget {
  final Widget child;
  final List<Color>? colors;
  final AnimationSpeed speed;
  final double opacity;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const GlowPulse({
    super.key,
    required this.child,
    this.colors,
    this.speed = AnimationSpeed.medium,
    this.opacity = 0.25,
    this.borderRadius,
    this.padding,
  });

  @override
  State<GlowPulse> createState() => _GlowPulseState();
}

class _GlowPulseState extends State<GlowPulse>
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
    final glowColor = (widget.colors != null && widget.colors!.isNotEmpty)
        ? widget.colors!.first
        : AppColors.primary;

    final effectiveRadius = widget.borderRadius ?? AppRadius.small;
    final effectivePadding = widget.padding ??
        EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, childWidget) {
        final currentOpacity = (widget.opacity * 0.4) + (_animation.value * widget.opacity * 0.6);
        final blurValue = 8.0 + (_animation.value * 12.0);

        return Container(
          padding: effectivePadding,
          decoration: BoxDecoration(
            borderRadius: effectiveRadius,
            color: AppColors.surface.withValues(alpha: 0.2),
            boxShadow: [
              BoxShadow(
                color: glowColor.withValues(alpha: currentOpacity),
                blurRadius: blurValue,
                spreadRadius: 2,
              ),
            ],
          ),
          child: childWidget,
        );
      },
      child: widget.child,
    );
  }
}
