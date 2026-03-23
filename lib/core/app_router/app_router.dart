import 'package:app/layers/view/screens/onboarding.dart';
import 'package:go_router/go_router.dart';
import 'package:app/layers/view/screens/home.dart';

// TODO тут надо делать класс
//вот так
// class AppRouter {
//   static GoRouter get router => GoRouter(routes: []);
// }
// можно замутить еще AppRouterNames с именами роутов
final router = GoRouter(
  initialLocation: '/',
  routes: [
    // вот начал тут
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // navigationShell это все текущий экран который отображается
        // надо сделать custombuttomnavbar который принимаем в себя navigationShell и использует его типо scaffold в body navigationShell а в bottomNavigationBar делаешь навигацию доку глянешь там
        //статейка по этой хуйне  https://medium.com/@mohitarora7272/stateful-nested-navigation-in-flutter-using-gorouters-statefulshellroute-and-statefulshellbranch-8bb91443edad
        return navigationShell;
      },
      branches: [
        // и делаешь 3 бренча под экраны home cart и notifications
        // и onboarding делаешь вне StatefulShellRoute.indexedStack
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: 'onboarding', // и вот тут AppRouterNames.onboarding
              builder: (context, state) => const Onboarding(),
              routes: [
                GoRoute(
                  path: '/homepage',
                  name: 'homepage',
                  builder: (context, state) => Home(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    // GoRoute(path: '/onboarding') // вот тут онборинг должен быть
  ],
);
