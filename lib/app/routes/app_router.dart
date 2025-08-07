import 'package:go_router/go_router.dart';
import '../../presentation/views/home/home_view.dart';
import '../../presentation/views/splash/splash_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      // Splash screen - ruta principal
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (_, __) => const SplashPage(),
      ),
      GoRoute(
        path: '/home-view',
        name: 'home',
        builder: (context, state) => const HomeView(),
      ),
    ],
  );
}
