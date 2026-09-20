import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/fertilizer/presentation/screens/fertilizer_screen.dart';
import '../../features/plants/presentation/screens/plant_care_screen.dart';
import '../../features/ai_doctor/presentation/screens/ai_doctor_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/fertilizer',
        builder: (context, state) => const FertilizerScreen(),
      ),
      GoRoute(
        path: '/plants/new',
        builder: (context, state) => const PlantCareScreen(),
      ),
      GoRoute(
        path: '/ai-doctor',
        builder: (context, state) => const AiDoctorScreen(),
      ),
    ],
  );
}
