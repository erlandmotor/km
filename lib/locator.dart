import "package:adamulti_mobile_clone_new/cubit/authenticated_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:adamulti_mobile_clone_new/services/backoffice_service.dart";
import "package:adamulti_mobile_clone_new/services/jwt_service.dart";
import "package:adamulti_mobile_clone_new/services/local_notification_service.dart";
import "package:adamulti_mobile_clone_new/services/product_service.dart";
import "package:adamulti_mobile_clone_new/services/secure_storage.dart";
import "package:adamulti_mobile_clone_new/services/transaction_service.dart";
import "package:get_it/get_it.dart";

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => BackOfficeService());
  locator.registerLazySingleton(() => SecureStorageService());
  locator.registerSingleton(AuthenticatedCubit());
  locator.registerSingleton(UserAppidCubit());
  locator.registerLazySingleton(() => JwtService());
  locator.registerLazySingleton(() => ProductService());
  locator.registerLazySingleton(() => TransactionService());
  locator.registerLazySingleton(() => LocalNotificationService());
}