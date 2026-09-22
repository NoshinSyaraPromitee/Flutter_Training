import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/ai_doctor/domain/diagnosis.dart';
import '../../features/ai_doctor/presentation/screens/ai_chat_screen.dart';
import '../../features/ai_doctor/presentation/screens/scan_plant_screen.dart';
import '../../features/ai_doctor/presentation/screens/scan_result_screen.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/presentation/screens/landing_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/care_guide/presentation/screens/care_guide_screen.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/checkout/presentation/screens/checkout_screen.dart';
import '../../features/checkout/presentation/screens/order_success_screen.dart';
import '../../features/fertilizer/presentation/screens/fertilizer_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/my_plants/presentation/screens/add_plant_screen.dart';
import '../../features/my_plants/presentation/screens/care_calendar_screen.dart';
import '../../features/my_plants/presentation/screens/my_plants_screen.dart';
import '../../features/my_plants/presentation/screens/plant_details_screen.dart';
import '../../features/my_plants/presentation/screens/plant_history_screen.dart';
import '../../features/payments/presentation/screens/payment_screen.dart';
import '../../features/plants/presentation/screens/plant_care_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/settings_screen.dart';
import '../../features/shop/presentation/screens/product_details_screen.dart';
import '../../features/shop/presentation/screens/shop_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/wishlist/presentation/screens/wishlist_screen.dart';
import '../shell/main_shell.dart';

part 'app_router.g.dart';

/// Routes reachable without a session.
const _publicRoutes = {'/', '/landing', '/login', '/register'};
const _loggedOutOnlyRoutes = {'/landing', '/login', '/register'};

/// Bridges Riverpod's [authControllerProvider] to GoRouter's
/// [Listenable]-based `refreshListenable`, so navigation re-evaluates the
/// redirect guard whenever auth state changes.
class _RouterRefreshNotifier extends ChangeNotifier {
  _RouterRefreshNotifier(Ref ref) {
    ref.listen(authControllerProvider, (_, _) => notifyListeners());
  }
}

/// The app's router. Rebuilding this provider (which happens automatically
/// since it reads [authControllerProvider]) is intentionally cheap — it's
/// just route table + guard construction, not per-screen state.
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: _RouterRefreshNotifier(ref),
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);
      final location = state.matchedLocation;
      if (auth.status == AuthStatus.unknown) {
        return location == '/' ? null : '/';
      }
      if (!auth.isAllowedIn && !_publicRoutes.contains(location)) {
        return '/landing';
      }
      if (auth.isAllowedIn && _loggedOutOnlyRoutes.contains(location)) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/landing',
        builder: (context, state) => const LandingScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // Bottom-tab shell: Home / Scan / Shop / AI Doctor (chat) / Profile.
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => MainShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/scan',
                builder: (context, state) => const ScanPlantScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/shop',
                builder: (context, state) => const ShopScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/ai-doctor',
                builder: (context, state) => const AiChatScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      // Full-screen routes pushed over the tabs.
      GoRoute(
        path: '/scan-result',
        builder: (context, state) =>
            ScanResultScreen(diagnosis: state.extra as Diagnosis),
      ),
      GoRoute(
        path: '/plants',
        builder: (context, state) => const MyPlantsScreen(),
        routes: [
          GoRoute(
            path: 'add',
            builder: (context, state) => const AddPlantScreen(),
          ),
          GoRoute(
            path: 'new',
            builder: (context, state) => const PlantCareScreen(),
          ),
          GoRoute(
            path: ':id',
            builder: (context, state) =>
                PlantDetailsScreen(plantId: state.pathParameters['id']!),
          ),
        ],
      ),
      GoRoute(
        path: '/care-calendar',
        builder: (context, state) => const CareCalendarScreen(),
      ),
      GoRoute(
        path: '/plant-history',
        builder: (context, state) => const PlantHistoryScreen(),
      ),
      GoRoute(
        path: '/care-guide',
        builder: (context, state) =>
            CareGuideScreen(plantId: state.uri.queryParameters['plantId']),
      ),
      GoRoute(
        path: '/fertilizer',
        builder: (context, state) => const FertilizerScreen(),
      ),
      GoRoute(
        path: '/shop/product/:id',
        builder: (context, state) =>
            ProductDetailsScreen(productId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/wishlist',
        builder: (context, state) => const WishlistScreen(),
      ),
      GoRoute(path: '/cart', builder: (context, state) => const CartScreen()),
      GoRoute(
        path: '/checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: '/payment',
        builder: (context, state) => PaymentScreen(
          total: double.tryParse(state.uri.queryParameters['total'] ?? '') ?? 0,
          eta: state.uri.queryParameters['eta'] ?? '3-5 Days',
        ),
      ),
      GoRoute(
        path: '/order-success',
        builder: (context, state) => OrderSuccessScreen(
          orderId: state.uri.queryParameters['orderId'] ?? '',
          eta: state.uri.queryParameters['eta'] ?? '3-5 Days',
        ),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
