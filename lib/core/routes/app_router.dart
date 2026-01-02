import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/features/categories/presentation/view/pages/categories_page.dart';
import 'package:elevate_flower_app/features/register/presentation/view/pages/register_page.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/forget_password/presentation/view/pages/forgetPassword_page.dart';
import '../../features/login/presentation/view/pages/login_page.dart';
import '../../features/main_layout/presentation/view/pages/main_layout_page.dart';
import '../../features/splash/presentation/view/pages/splash_page.dart';
import 'routes.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
  initialLocation: Routes.splash,
  navigatorKey: navigatorKey,
  routes: [
    _customAnimatedGoRoute(
      route: Routes.splash,
      page: (state, context) =>
          SplashPage(key: ValueKey(context.locale.languageCode.toString())),
    ),
    _customAnimatedGoRoute(
      route: Routes.login,
      page: (state, context) =>
          LoginPage(key: ValueKey(context.locale.languageCode.toString())),
    ),
    _customAnimatedGoRoute(
      route: Routes.register,
      page: (state, context) =>
          RegisterPage(key: ValueKey(context.locale.languageCode.toString())),
    ),
    _customAnimatedGoRoute(
      route: Routes.forgetPassword,
      page: (state, context) => ForgetPasswordPage(
        key: ValueKey(context.locale.languageCode.toString()),
      ),
    ),
    _customAnimatedGoRoute(
      route: Routes.appLayout,
      page: (state, context) =>
          MainLayoutPage(key: ValueKey(context.locale.languageCode.toString())),
    ),
    _customAnimatedGoRoute(
      route: Routes.categories,
      page: (state, context) =>
          CategoriesPage(key: ValueKey(context.locale.languageCode.toString())),
    ),
  ],
);

GoRoute _customAnimatedGoRoute({
  required String route,
  required Widget Function(GoRouterState state, BuildContext context) page,
  Duration duration = const Duration(milliseconds: 450),
  Offset beginOffset = const Offset(1, 0),
  Offset endOffset = Offset.zero,
  Curve curve = Curves.easeInOut,
  List<GoRoute> routes = const [],
}) => GoRoute(
  path: route,
  routes: routes,
  pageBuilder: (context, state) => CustomTransitionPage(
    key: state.pageKey,
    child: page(state, context),
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: beginOffset,
          end: endOffset,
        ).animate(CurvedAnimation(parent: animation, curve: curve)),
        child: child,
      );
    },
  ),
);

String getCurrentRoute(BuildContext context) {
  final location = GoRouterState.of(context).uri.toString();
  return location;
}
