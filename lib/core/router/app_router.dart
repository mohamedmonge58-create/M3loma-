// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'app_routes.dart';
//
// abstract final class AppRouter {
//   static const List<String> _publicPaths = [
//     AppRoutes.login,
//     AppRoutes.register,
//     AppRoutes.forgotPassword,
//   ];
//
//   // TODO(phase-2): persist a "seen onboarding" flag (shared_preferences) so
//   // a logged-out user who has already seen it lands on login instead.
//   static String? _redirect(BuildContext context, GoRouterState state) {
//     final isLoggedIn = FirebaseAuth.instance.currentUser != null;
//     final isPublicRoute = _publicPaths.contains(state.matchedLocation);
//
//     if (!isLoggedIn && !isPublicRoute) {
//       return AppRoutes.onboardingPath;
//     }
//     if (isLoggedIn && isPublicRoute) {
//       return AppRoutes.homePath;
//     }
//     return null;
//   }
//
//   static final GoRouter router = GoRouter(
//     initialLocation: AppRoutes.homePath,
//     redirect: _redirect,
//     routes: [
//       GoRoute(
//         name: AppRoutes.onboardingName,
//         path: AppRoutes.onboardingPath,
//         builder: (context, _) =>
//             OnboardingScreen(onFinished: () => context.go(AppRoutes.loginPath)),
//       ),
//
//       GoRoute(
//         name: AppRoutes.loginName,
//         path: AppRoutes.loginPath,
//         builder: (_, _) => const LoginScreen(),
//       ),
//
//       GoRoute(
//         name: AppRoutes.forgotPasswordName,
//         path: AppRoutes.forgotPasswordPath,
//         builder: (_, _) => const ResetPasswordScreen(),
//       ),
//
//       GoRoute(
//         name: AppRoutes.registerName,
//         path: AppRoutes.registerPath,
//         builder: (_, _) => const RegisterScreen(),
//       ),
//
//       GoRoute(
//         name: AppRoutes.updateProfileName,
//         path: AppRoutes.updateProfilePath,
//         builder: (_, _) => BlocProvider(
//           create: (_) => getIt<ProfileCubit>()..getCurrentUser(),
//           child: const UpdateProfileScreen(),
//         ),
//       ),
//
//       GoRoute(
//         name: AppRoutes.homeName,
//         path: AppRoutes.homePath,
//         builder: (_, _) => const AppShellScreen(),
//       ),
//       GoRoute(
//         name: AppRoutes.showcaseName,
//         path: AppRoutes.showcasePath,
//         builder: (_, _) => const DesignSystemShowcaseScreen(),
//       ),
//       GoRoute(
//         name: AppRoutes.movieDetailsName,
//         path: AppRoutes.movieDetailsPath,
//         builder: (_, state) =>
//             MovieDetailsScreen(movieId: state.extra as int? ?? 0),
//       ),
//     ],
//     errorBuilder: (_, state) => _RouteErrorScreen(
//       message: state.error?.toString() ?? state.uri.toString(),
//     ),
//   );
// }
// class _RouteErrorScreen extends StatelessWidget {
//   const _RouteErrorScreen({required this.message});
//
//   final String message;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(AppSpacing.screenPadding),
//           child: Text(
//             message,
//             maxLines: 3,
//             overflow: TextOverflow.ellipsis,
//             textAlign: TextAlign.center,
//             style: Theme.of(context).textTheme.bodyMedium,
//           ),
//         ),
//       ),
//     );
//   }
// }
