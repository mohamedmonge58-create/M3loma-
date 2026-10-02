import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import 'animated_background_type.dart';

class FloatingParticles extends StatefulWidget {
  final Widget child;
  final List<Color>? colors;
  final AnimationSpeed speed;
  final double opacity;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const FloatingParticles({
    super.key,
    required this.child,
    this.colors,
    this.speed = AnimationSpeed.medium,
    this.opacity = 0.3,
    this.borderRadius,
    this.padding,
  });

  @override
  State<FloatingParticles> createState() => _FloatingParticlesState();
}

class _FloatingParticlesState extends State<FloatingParticles>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.speed.duration * 2,
    )..repeat();

    final random = math.Random(42);
    _particles = List.generate(12, (index) {
      return _Particle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        radius: 1.5 + random.nextDouble() * 2.5,
        speed: 0.2 + random.nextDouble() * 0.8,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final particleColor = (widget.colors != null && widget.colors!.isNotEmpty)
        ? widget.colors!.first
        : AppColors.primary;

    final effectiveRadius = widget.borderRadius ?? AppRadius.small;
    final effectivePadding = widget.padding ??
        EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h);

    return ClipRRect(
      borderRadius: effectiveRadius,
      child: Container(
        padding: effectivePadding,
        color: AppColors.surface.withValues(alpha: 0.15),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, childWidget) {
            return CustomPaint(
              foregroundPainter: _ParticlesPainter(
                particles: _particles,
                progress: _controller.value,
                color: particleColor.withValues(alpha: widget.opacity),
              ),
              child: childWidget,
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}

class _Particle {
  final double x;
  final double y;
  final double radius;
  final double speed;

  _Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.speed,
  });
}

class _ParticlesPainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  final Color color;

  _ParticlesPainter({
    required this.particles,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    for (final p in particles) {
      final currentY = (p.y - (progress * p.speed)) % 1.0;
      final currentX = (p.x + math.sin(progress * 2 * math.pi + p.y * 10) * 0.05) % 1.0;

      final dx = currentX * size.width;
      final dy = currentY * size.height;

      canvas.drawCircle(Offset(dx, dy), p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlesPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
