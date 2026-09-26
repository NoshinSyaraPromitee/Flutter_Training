import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../core/network/api_client.dart';
import '../core/storage/secure_storage.dart';
import '../features/ai_doctor/presentation/controllers/chat_controller.dart';
import '../features/ai_doctor/presentation/controllers/scan_controller.dart';
import '../features/auth/presentation/controllers/auth_controller.dart';
import '../features/care_guide/domain/repositories/care_guide_repository.dart';
import '../features/cart/presentation/controllers/cart_controller.dart';
import '../features/fertilizer/presentation/controllers/fertilizer_controller.dart';
import '../features/gamification/domain/repositories/achievement_repository.dart';
import '../features/payments/presentation/controllers/payment_controller.dart';
import '../features/plants/presentation/controllers/plants_controller.dart';
import '../features/profile/presentation/controllers/settings_controller.dart';
import '../features/reviews/presentation/controllers/reviews_controller.dart';
import '../features/shop/data/repositories/price_refresh_repository.dart';
import '../features/shop/presentation/controllers/shop_controller.dart';
import '../features/wishlist/presentation/controllers/wishlist_controller.dart';

final secureStorageProvider = Provider<SecureStorage>(
  (ref) => throw UnimplementedError(),
);
final apiClientProvider = Provider<ApiClient>(
  (ref) => throw UnimplementedError(),
);

final authControllerProvider = ChangeNotifierProvider<AuthController>(
  (ref) => throw UnimplementedError(),
);
final plantsControllerProvider = ChangeNotifierProvider<PlantsController>(
  (ref) => throw UnimplementedError(),
);
final chatControllerProvider = ChangeNotifierProvider<ChatController>(
  (ref) => throw UnimplementedError(),
);
final scanControllerProvider = ChangeNotifierProvider<ScanController>(
  (ref) => throw UnimplementedError(),
);
final shopControllerProvider = ChangeNotifierProvider<ShopController>(
  (ref) => throw UnimplementedError(),
);
final cartControllerProvider = ChangeNotifierProvider<CartController>(
  (ref) => throw UnimplementedError(),
);
final wishlistControllerProvider = ChangeNotifierProvider<WishlistController>(
  (ref) => throw UnimplementedError(),
);
final reviewsControllerProvider = ChangeNotifierProvider<ReviewsController>(
  (ref) => throw UnimplementedError(),
);
final fertilizerControllerProvider =
    ChangeNotifierProvider<FertilizerController>(
      (ref) => throw UnimplementedError(),
    );
final paymentControllerProvider = ChangeNotifierProvider<PaymentController>(
  (ref) => throw UnimplementedError(),
);
final settingsControllerProvider = ChangeNotifierProvider<SettingsController>(
  (ref) => throw UnimplementedError(),
);

final careGuideRepositoryProvider = Provider<CareGuideRepository>(
  (ref) => throw UnimplementedError(),
);
final achievementRepositoryProvider = Provider<AchievementRepository>(
  (ref) => throw UnimplementedError(),
);
final priceRefreshRepositoryProvider = Provider<PriceRefreshRepository>(
  (ref) => throw UnimplementedError(),
);
