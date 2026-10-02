import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

enum AppButtonVariant { primary, outlined, danger }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.isEnabled = true,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final AppButtonVariant variant;
  final Widget? icon;
  final bool isLoading;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final isDanger = variant == AppButtonVariant.danger;
    final isOutlined = variant == AppButtonVariant.outlined;

    final Color buttonColor = isLoading
        ? (isDanger
            ? AppColors.errorDark
            : isOutlined
                ? AppColors.surface
                : AppColors.primaryDark)
        : (isDanger
            ? AppColors.error
            : isOutlined
                ? Colors.transparent
                : AppColors.primary);

    final Color borderColor = isOutlined
        ? (isLoading ? AppColors.primaryDark : AppColors.primary)
        : Colors.transparent;

    final Color spinnerColor = isOutlined && !isLoading
        ? AppColors.primary
        : AppColors.textPrimary;

    final labelText = Text(
      label,
      style: AppTextStyles.buttonLabel.copyWith(
        color: isOutlined ? AppColors.primary : Colors.white,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    final childContent = icon == null
        ? labelText
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              icon!,
              SizedBox(width: AppSpacing.sm),
              labelText,
            ],
          );

    return LayoutBuilder(
      builder: (context, constraints) {
        final buttonHeight = AppSizes.buttonHeight;
        final fullWidth = constraints.maxWidth;

        final targetWidth = isLoading ? buttonHeight : fullWidth;
        final targetRadius =
            isLoading ? (buttonHeight / 2) : AppRadius.medium.topLeft.x;

        return Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            width: targetWidth,
            height: buttonHeight,
            decoration: BoxDecoration(
              color: isEnabled ? buttonColor : AppColors.surface,
              borderRadius: BorderRadius.circular(targetRadius),
              border: Border.all(
                color: borderColor,
                width: isOutlined ? AppSizes.categoryBorderWidth : 0,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(targetRadius),
                onTap: isEnabled && !isLoading ? onPressed : null,
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    switchInCurve: Curves.easeIn,
                    switchOutCurve: Curves.easeOut,
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      );
                    },
                    child: isLoading
                        ? SizedBox(
                            key: const ValueKey('button_loading_spinner'),
                            width: 22.r,
                            height: 22.r,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                spinnerColor,
                              ),
                            ),
                          )
                        : Padding(
                            key: const ValueKey('button_content_label'),
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: childContent,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
