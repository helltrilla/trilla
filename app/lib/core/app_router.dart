import 'package:app/layers/view/screens/onboarding.dart';
import 'package:go_router/go_router.dart';
import 'package:app/layers/view/screens/home.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return navigationShell;
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: 'onboarding',
              builder: (context, state) => const Onboarding(),
              routes: [
                GoRoute(path: '/homepage', name: 'homepage', builder: (context, state) => Home(),)
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
