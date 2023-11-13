import 'dart:ui';

import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/cubit/authenticated_cubit.dart';
import 'package:adamulti_mobile_clone_new/cubit/getme_cubit.dart';
import 'package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart';
import 'package:adamulti_mobile_clone_new/firebase_options.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/screen_router.dart';
import 'package:adamulti_mobile_clone_new/services/auth_service.dart';
import 'package:adamulti_mobile_clone_new/services/local_notification_service.dart';
import 'package:adamulti_mobile_clone_new/services/secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await locator.get<LocalNotificationService>().initLocalNotification();

  final token = await locator.get<SecureStorageService>().readSecureData("jwt");

  
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

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  locator.get<AuthService>().clearGoogleSigning();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(MyApp(jwtToken: token,));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.jwtToken });

  final String? jwtToken;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    if(widget.jwtToken != null) {
      locator.get<AuthService>().signInWithGoogle().then((value) {
        locator.get<AuthService>().authenticated().then((authenticated) {
          locator.get<AuthenticatedCubit>().updateUserState(authenticated.user!);
          locator.get<AuthService>().decryptToken(authenticated.user!.idreseller!, widget.jwtToken!).then((decrypt) {
            locator.get<UserAppidCubit>().updateState(decrypt);
            locator.get<AuthService>().getMe(decrypt.appId).then((me) {
              locator.get<GetmeCubit>().updateState(me);
            });
          });
        });
      });
    }
    super.initState();
  }
  
  @override
  void dispose() {
    locator.get<AuthenticatedCubit>().close();
    locator.get<GetmeCubit>().close();
    locator.get<UserAppidCubit>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'ADAMULTI MOBILE',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: screenRouter(widget.jwtToken),
        );
      }
    );
  }
}
