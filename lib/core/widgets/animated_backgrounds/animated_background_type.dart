enum AnimatedBackgroundType {
  movingGradient,
  floatingBlobs,
  aurora,
  glowPulse,
  lightSweep,
  shimmerWave,
  floatingParticles,
  animatedCircles,
  rotatingGradient,
  breathingBackground,
  fluidGradient,
  spotlight,
}

enum AnimationSpeed {
  slow,
  medium,
  fast,
}

extension AnimationSpeedDuration on AnimationSpeed {
  Duration get duration {
    switch (this) {
      case AnimationSpeed.slow:
        return const Duration(seconds: 6);
      case AnimationSpeed.medium:
        return const Duration(seconds: 3);
      case AnimationSpeed.fast:
        return const Duration(milliseconds: 1500);
    }
  }
}
