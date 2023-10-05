import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/cubit/authenticated_cubit.dart';
import 'package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/screen_router.dart';
import 'package:adamulti_mobile_clone_new/services/auth_service.dart';
import 'package:adamulti_mobile_clone_new/services/local_notification_service.dart';
import 'package:adamulti_mobile_clone_new/services/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  // locator.get<AuthService>().login("IO0016").then((loginResponse) {
  //   locator.get<SecureStorageService>().writeSecureData("jwt", loginResponse.token!);
  // });

  await locator.get<LocalNotificationService>().initLocalNotification();

  final token = await locator.get<SecureStorageService>().readSecureData("jwt");


  final authenticatedUser = await locator.get<AuthService>().authenticated();

  locator.get<AuthenticatedCubit>().updateUserState(authenticatedUser.user!);

  final userAppId = await locator.get<AuthService>().decryptToken(authenticatedUser.user!.idreseller!, token!);


  locator.get<UserAppidCubit>().updateState(userAppId);
  
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: kMainThemeColor,
      systemNavigationBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.white
    )
  );
  
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ADAMULTI MOBILE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: screenRouter(),
    );
  }
}
