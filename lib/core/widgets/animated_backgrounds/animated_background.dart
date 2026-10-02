import 'package:flutter/material.dart';
import 'animated_background_type.dart';
import 'animated_circles.dart';
import 'aurora_background.dart';
import 'breathing_background.dart';
import 'floating_blobs.dart';
import 'floating_particles.dart';
import 'fluid_gradient.dart';
import 'glow_pulse.dart';
import 'light_sweep.dart';
import 'moving_gradient.dart';
import 'rotating_gradient.dart';
import 'shimmer_wave.dart';
import 'spotlight_background.dart';

export 'animated_background_type.dart';

class AnimatedBackground extends StatelessWidget {
  final AnimatedBackgroundType type;
  final Widget child;
  final List<Color>? colors;
  final AnimationSpeed speed;
  final double opacity;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const AnimatedBackground({
    super.key,
    required this.type,
    required this.child,
    this.colors,
    this.speed = AnimationSpeed.medium,
    this.opacity = 0.25,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AnimatedBackgroundType.movingGradient:
        return MovingGradient(
          colors: colors,
          speed: speed,
          opacity: opacity,
          borderRadius: borderRadius,
          padding: padding,
          child: child,
        );
      case AnimatedBackgroundType.floatingBlobs:
        return FloatingBlobs(
          colors: colors,
          speed: speed,
          opacity: opacity,
          borderRadius: borderRadius,
          padding: padding,
          child: child,
        );
      case AnimatedBackgroundType.aurora:
        return AuroraBackground(
          colors: colors,
          speed: speed,
          opacity: opacity,
          borderRadius: borderRadius,
          padding: padding,
          child: child,
        );
      case AnimatedBackgroundType.glowPulse:
        return GlowPulse(
          colors: colors,
          speed: speed,
          opacity: opacity,
          borderRadius: borderRadius,
          padding: padding,
          child: child,
        );
      case AnimatedBackgroundType.lightSweep:
        return LightSweep(
          colors: colors,
          speed: speed,
          opacity: opacity,
          borderRadius: borderRadius,
          padding: padding,
          child: child,
        );
      case AnimatedBackgroundType.shimmerWave:
        return ShimmerWave(
          colors: colors,
          speed: speed,
          opacity: opacity,
          borderRadius: borderRadius,
          padding: padding,
          child: child,
        );
      case AnimatedBackgroundType.floatingParticles:
        return FloatingParticles(
          colors: colors,
          speed: speed,
          opacity: opacity,
          borderRadius: borderRadius,
          padding: padding,
          child: child,
        );
      case AnimatedBackgroundType.animatedCircles:
        return AnimatedCircles(
          colors: colors,
          speed: speed,
          opacity: opacity,
          borderRadius: borderRadius,
          padding: padding,
          child: child,
        );
      case AnimatedBackgroundType.rotatingGradient:
        return RotatingGradient(
          colors: colors,
          speed: speed,
          opacity: opacity,
          borderRadius: borderRadius,
          padding: padding,
          child: child,
        );
      case AnimatedBackgroundType.breathingBackground:
        return BreathingBackground(
          colors: colors,
          speed: speed,
          opacity: opacity,
          borderRadius: borderRadius,
          padding: padding,
          child: child,
        );
      case AnimatedBackgroundType.fluidGradient:
        return FluidGradient(
          colors: colors,
          speed: speed,
          opacity: opacity,
          borderRadius: borderRadius,
          padding: padding,
          child: child,
        );
      case AnimatedBackgroundType.spotlight:
        return SpotlightBackground(
          colors: colors,
          speed: speed,
          opacity: opacity,
          borderRadius: borderRadius,
          padding: padding,
          child: child,
        );
    }
  }
}
