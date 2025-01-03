import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:moon/features/sign_in/presentation/page/sign_in_page.dart';
import 'package:moon/features/splash/presentation/splasg_page.dart';

import 'app_routes.dart';

final _parentKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splashScreen,
  navigatorKey: _parentKey,
  routes: [
    GoRoute(
      path: AppRoutes.splashScreen,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.signInPath,
      builder: (context, state) => const SignInPage(),
    ),
  ],
  redirect: (context, state) async {
    return null;
  },
);
