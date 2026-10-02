import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/animated_backgrounds/animated_background.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      if (_tabController.index != _selectedIndex) {
        setState(() {
          _selectedIndex = _tabController.index;
        });
      }
    } else if (_tabController.animation != null) {
      final int targetIndex = _tabController.animation!.value.round();
      if (targetIndex != _selectedIndex) {
        setState(() {
          _selectedIndex = targetIndex;
        });
      }
    }
  }

  void _selectTab(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      _tabController.animateTo(index);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildPremiumPillTabSelector() {
    // Calculates horizontal alignment for the single sliding gradient pill indicator (-1.0 to 1.0)
    final alignX = -1.0 + (_selectedIndex * 1.0);

    return Container(

      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.all(5.w),
      height: 65.h,
      decoration: BoxDecoration(
gradient:  LinearGradient(
  colors: [
    const Color(0xFFeeba30).withValues(alpha: 0.1),
    const Color(0xFFFFFFFF).withValues(alpha: 0.1),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
),

        borderRadius: BorderRadius.circular(26.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const double gap = 10.0;
          final totalWidth = constraints.maxWidth;
          final chipWidth = (totalWidth - (gap * 2)) / 3;

          return Stack(
            children: [
              // Outlined Unselected Pill Outlines for all 3 chips
              Row(
                children: [
                  _UnselectedPillChip(
                    title: "Enrolled",
                    onTap: () => _selectTab(0),
                  ),
                  SizedBox(width: gap.w),
                  _UnselectedPillChip(
                    title: "Saved",
                    onTap: () => _selectTab(1),
                  ),
                  SizedBox(width: gap.w),
                  _UnselectedPillChip(
                    title: "Completed",
                    onTap: () => _selectTab(2),
                  ),
                ],
              ),

              // Single Premium Gradient Indicator that physically slides between chips
              AnimatedAlign(
                duration: const Duration(milliseconds: 380),
                curve: Curves.easeInOutCubic,
                alignment: Alignment(alignX, 0.0),
                child: Container(
                  width: chipWidth,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.r),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF007A7B),
                        AppColors.primary,
                        Color(0xFF004546),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.25),
                      width: 1.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.55),
                        blurRadius: 18,
                        spreadRadius: 1,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ),

              // Interactive Text Labels Overlay with micro-animations
              Row(
                children: [
                  _PillTextLabel(
                    title: "Enrolled",
                    isSelected: _selectedIndex == 0,
                    onTap: () => _selectTab(0),
                  ),
                  SizedBox(width: gap.w),
                  _PillTextLabel(
                    title: "Saved",
                    isSelected: _selectedIndex == 1,
                    onTap: () => _selectTab(1),
                  ),
                  SizedBox(width: gap.w),
                  _PillTextLabel(
                    title: "Completed",
                    isSelected: _selectedIndex == 2,
                    onTap: () => _selectTab(2),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: AnimatedBackground(
          type: AnimatedBackgroundType.movingGradient,
          child: Text(
            "My Library",
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildPremiumPillTabSelector(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: ListView(
                    children: const [
                      _LibraryCard(
                        title: "Flutter & Dart Masterclass",
                        progress: 0.65,
                        completedLessons: "18/28 Lessons",
                        icon: Icons.phone_android,
                      ),
                      _LibraryCard(
                        title: "UI Design Systems",
                        progress: 0.30,
                        completedLessons: "6/20 Lessons",
                        icon: Icons.palette,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: ListView(
                    children: const [
                      _LibraryCard(
                        title: "Node.js Microservices",
                        progress: 0.0,
                        completedLessons: "Saved Course",
                        icon: Icons.dns,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: ListView(
                    children: const [
                      _LibraryCard(
                        title: "Clean Architecture in Dart",
                        progress: 1.0,
                        completedLessons: "Completed - Certificate Issued",
                        icon: Icons.workspace_premium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UnselectedPillChip extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _UnselectedPillChip({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.02),
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.30),
              width: 3.w,
            ),
          ),
        ),
      ),
    );
  }
}

class _PillTextLabel extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _PillTextLabel({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedScale(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            scale: isSelected ? 1.05 : 0.95,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: isSelected ? 8.r : 0,
                  height: isSelected ? 8.r : 0,
                  margin: EdgeInsets.only(right: isSelected ? 6.w : 0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.cyanAccent,
                  ),
                ),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isSelected
                        ? Colors.white
                        : Colors.black,
                    fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                    fontSize: 18.sp,
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LibraryCard extends StatelessWidget {
  final String title;
  final double progress;
  final String completedLessons;
  final IconData icon;

  const _LibraryCard({
    required this.title,
    required this.progress,
    required this.completedLessons,
    this.icon = Icons.menu_book,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.medium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: AppRadius.small,
                ),
                child: Icon(icon, color: AppColors.primary, size: 24.r),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          if (progress > 0) ...[
            LinearProgressIndicator(
              value: progress,
              color: AppColors.primary,
              backgroundColor: AppColors.background,
              borderRadius: AppRadius.small,
            ),
            SizedBox(height: 8.h),
          ],
          Text(
            completedLessons,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
