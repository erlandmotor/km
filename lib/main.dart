import 'dart:ui';

import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/cubit/authenticated_cubit.dart';
import 'package:adamulti_mobile_clone_new/cubit/bottom_navigation_cubit.dart';
import 'package:adamulti_mobile_clone_new/cubit/connected_devices_cubit.dart';
import 'package:adamulti_mobile_clone_new/cubit/getme_cubit.dart';
import 'package:adamulti_mobile_clone_new/cubit/google_account_cubit.dart';
import 'package:adamulti_mobile_clone_new/cubit/inbox_schema_cubit.dart';
import 'package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart';
import 'package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart';
import 'package:adamulti_mobile_clone_new/firebase_options.dart';
import 'package:adamulti_mobile_clone_new/function/custom_function.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/schema/inbox_schema.dart';
import 'package:adamulti_mobile_clone_new/screen_router.dart';
import 'package:adamulti_mobile_clone_new/services/auth_service.dart';
import 'package:adamulti_mobile_clone_new/services/backoffice_service.dart';
import 'package:adamulti_mobile_clone_new/services/firebase_messaging_service.dart';
import 'package:adamulti_mobile_clone_new/services/local_notification_service.dart';
import 'package:adamulti_mobile_clone_new/services/secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  await Hive.initFlutter();

  Hive.registerAdapter(InboxSchemaAdapter());

  final inboxSchemaBox = await Hive.openBox<InboxSchema>("inboxSchema");

  locator.get<InboxSchemaCubit>().updateState(inboxSchemaBox);

  final convertedBoxValuesToList = inboxSchemaBox.values.toList();

  final expiredInboxDateList = convertedBoxValuesToList.where((element) {
    return daysBetween(element.date, DateTime.now()) >= 30;
  }).toList();

  if(expiredInboxDateList.isNotEmpty) {
    for(var i = 0; i < expiredInboxDateList.length; i++) {
      final findIndex = convertedBoxValuesToList.indexWhere((element) => element.date == expiredInboxDateList[i].date);
      inboxSchemaBox.deleteAt(findIndex);
    }
  }

  // await Future.delayed(const Duration(seconds: 1));

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  final settingApplikasiData = await locator.get<BackOfficeService>().findFirstSettingApplikasi("ADAMULTI");

  locator.get<SettingApplikasiCubit>().updateState(settingApplikasiData);

  await locator.get<LocalNotificationService>().initLocalNotification();

  final token = await locator.get<SecureStorageService>().readSecureData("jwt");

  
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: HexColor.fromHex(settingApplikasiData.mainColor1!),
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

  
  locator.get<FirebaseMessagingService>().initNotification();

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

  var presscount = 0;

  @override
  void initState() {
    if(widget.jwtToken != null) {
      locator.get<AuthService>().signinSilently().then((value) {
        locator.get<GoogleAccountCubit>().updateState(value);
      });
    } else {
      
    }
    super.initState();
  }
  
  @override
  void dispose() {
    locator.get<AuthenticatedCubit>().close();
    locator.get<GetmeCubit>().close();
    locator.get<UserAppidCubit>().close();
    locator.get<GoogleAccountCubit>().close();
    locator.get<InboxSchemaCubit>().close();
    locator.get<BottomNavigationCubit>().close();
    locator.get<ConnectedDevicesCubit>().close();
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
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple, 
              primary: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!)
            ),
            useMaterial3: true,
          ),
          routerConfig: screenRouter(widget.jwtToken),
        );
      }
    );
  }
}
