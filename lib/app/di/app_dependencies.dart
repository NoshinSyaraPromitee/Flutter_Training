import 'package:plantpal/core/network/api_client.dart';
import 'package:plantpal/core/storage/secure_storage.dart';
import 'package:plantpal/features/ai_doctor/data/datasources/ai_doctor_remote_data_source.dart';
import 'package:plantpal/features/ai_doctor/data/repositories/ai_doctor_repository_impl.dart';
import 'package:plantpal/features/ai_doctor/presentation/controllers/chat_controller.dart';
import 'package:plantpal/features/ai_doctor/presentation/controllers/scan_controller.dart';
import 'package:plantpal/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:plantpal/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:plantpal/features/auth/presentation/controllers/auth_controller.dart';
import 'package:plantpal/features/care_guide/data/repositories/care_guide_local_repository.dart';
import 'package:plantpal/features/care_guide/domain/repositories/care_guide_repository.dart';
import 'package:plantpal/features/cart/presentation/controllers/cart_controller.dart';
import 'package:plantpal/features/fertilizer/data/repositories/fertilizer_local_repository.dart';
import 'package:plantpal/features/fertilizer/presentation/controllers/fertilizer_controller.dart';
import 'package:plantpal/features/gamification/data/repositories/achievement_local_repository.dart';
import 'package:plantpal/features/gamification/domain/repositories/achievement_repository.dart';
import 'package:plantpal/features/payments/data/repositories/simulated_payment_repository.dart';
import 'package:plantpal/features/payments/presentation/controllers/payment_controller.dart';
import 'package:plantpal/features/plants/data/datasources/plant_remote_data_source.dart';
import 'package:plantpal/features/plants/data/repositories/plant_repository_impl.dart';
import 'package:plantpal/features/plants/domain/usecases/add_plant.dart';
import 'package:plantpal/features/plants/presentation/controllers/plants_controller.dart';
import 'package:plantpal/features/profile/presentation/controllers/settings_controller.dart';
import 'package:plantpal/features/reviews/data/repositories/review_local_repository.dart';
import 'package:plantpal/features/reviews/presentation/controllers/reviews_controller.dart';
import 'package:plantpal/features/shop/data/repositories/product_local_repository.dart';
import 'package:plantpal/features/shop/presentation/controllers/shop_controller.dart';
import 'package:plantpal/features/wishlist/presentation/controllers/wishlist_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// Composition root: the only place that knows which implementation backs which interface.
class AppDependencies {
  AppDependencies() {
    final storage = const SecureStorage();
    final api = ApiClient(storage);

    auth = AuthController(AuthRepositoryImpl(AuthRemoteDataSource(api), storage));
    api.onUnauthorized = auth.logout; // expired/invalid token -> back to login

    final plantRepo = PlantRepositoryImpl(PlantRemoteDataSource(api));
    plants = PlantsController(repository: plantRepo, addPlant: AddPlant(plantRepo));

    final aiRepo = AiDoctorRepositoryImpl(AiDoctorRemoteDataSource(api));
    chat = ChatController(aiRepo);
    scan = ScanController(aiRepo);

    shop = ShopController(ProductLocalRepository())..load();
    reviews = ReviewsController(ReviewLocalRepository());
    fertilizer = FertilizerController(FertilizerLocalRepository())..load();
    payment = PaymentController(SimulatedPaymentRepository());
  }

  late final AuthController auth;
  late final PlantsController plants;
  late final ChatController chat;
  late final ScanController scan;
  late final ShopController shop;
  late final ReviewsController reviews;
  late final FertilizerController fertilizer;
  late final PaymentController payment;
  final CartController cart = CartController();
  final WishlistController wishlist = WishlistController();
  final SettingsController settings = SettingsController();
  final CareGuideRepository careGuide = CareGuideLocalRepository();
  final AchievementRepository achievements = AchievementLocalRepository();

  List<SingleChildWidget> get providers => [
        ChangeNotifierProvider<AuthController>.value(value: auth),
        ChangeNotifierProvider<PlantsController>.value(value: plants),
        ChangeNotifierProvider<ChatController>.value(value: chat),
        ChangeNotifierProvider<ScanController>.value(value: scan),
        ChangeNotifierProvider<ShopController>.value(value: shop),
        ChangeNotifierProvider<CartController>.value(value: cart),
        ChangeNotifierProvider<WishlistController>.value(value: wishlist),
        ChangeNotifierProvider<ReviewsController>.value(value: reviews),
        ChangeNotifierProvider<FertilizerController>.value(value: fertilizer),
        ChangeNotifierProvider<PaymentController>.value(value: payment),
        ChangeNotifierProvider<SettingsController>.value(value: settings),
        Provider<CareGuideRepository>.value(value: careGuide),
        Provider<AchievementRepository>.value(value: achievements),
      ];
}