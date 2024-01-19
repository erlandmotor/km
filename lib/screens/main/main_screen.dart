import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/popup_image_dialog.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/authenticated_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/bottom_navigation_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/favorite_menu_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/getme_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/notification_count_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/screens/main/account_screen.dart";
import "package:adamulti_mobile_clone_new/screens/main/history_screen.dart";
import "package:adamulti_mobile_clone_new/screens/main/home_screen.dart";
import "package:adamulti_mobile_clone_new/screens/main/inbox_screen.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:adamulti_mobile_clone_new/services/backoffice_service.dart";
import "package:adamulti_mobile_clone_new/services/local_notification_service.dart";
import "package:adamulti_mobile_clone_new/services/notification_service.dart";
import "package:adamulti_mobile_clone_new/services/secure_storage.dart";
import "package:double_back_to_close_app/double_back_to_close_app.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import 'package:badges/badges.dart' as badges;
import 'package:socket_io_client/socket_io_client.dart';

class MainScreen extends StatefulWidget {

  const MainScreen({ super.key });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Socket socket = io(baseUrlSocket, OptionBuilder().setTransports(["websocket"]).build());

  final List<Widget> screenList = [
    const HomeScreen(),
    const InboxScreen(),
    const HistoryScreen(),
    const AccountScreen()
  ];

  @override
  void initState() {
    final favoriteMenuCubit = context.read<FavoriteMenuCubit>();

    final now = DateTime.now();
    final yesterday = DateTime.now().add(const Duration(days: -3));

    locator.get<NotificationService>().countTotalNotification("${yesterday.year}-${yesterday.month}-${yesterday.day + 1}", 
      "${now.year}-${now.month}-${now.day + 1}"
    ).then((value) {
      locator.get<NotificationCountCubit>().updateState(value);
    });

    locator.get<BackOfficeService>().getSpecificMenuByKategori(1).then((value) {
      favoriteMenuCubit.updateStae(false, value);
    }).catchError((e) {
      showDynamicSnackBar(
        context, 
        Iconsax.warning_2, 
        "ERROR", 
        "Terjadi Kesalahan, Silahkan Periksa Koneksi Internet Anda.", 
        HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
      );
    });

    locator.get<BackOfficeService>().getPopupImage().then((value) {
      if(value.status! == 1) {
        showDialog(
          context: context, 
          builder: (context) {
            return PopupImageDialog(
              imageUrl: "$baseUrlAuth/files/popup/image/${value.image!}"
            );
          }
        );
      }
    });

    locator.get<AuthService>().authenticated().then((authenticated) {
      locator.get<AuthenticatedCubit>().updateUserState(authenticated.user!);
      locator.get<SecureStorageService>().readSecureData("jwt").then((jwt) {
        locator.get<AuthService>().decryptToken(authenticated.user!.idreseller!, jwt!).then((decrypt) {
          locator.get<UserAppidCubit>().updateState(decrypt);
          locator.get<AuthService>().getMe(decrypt.appId).then((me) {
            locator.get<GetmeCubit>().updateState(me);
          });
        });
      });
    });

    socket.connect();

    socket.on('inbox', (data) {

      locator.get<NotificationCountCubit>().updateState(
        locator.get<NotificationCountCubit>().state.notificationCount + 1
      );
      
      locator.get<LocalNotificationService>().showLocalNotification(
        title: "📢 PENGUMUMAN", 
        body: data
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavigationCubit = context.read<BottomNavigationCubit>();

    return BlocBuilder<SettingApplikasiCubit, SettingApplikasiState>(
      bloc: locator.get<SettingApplikasiCubit>(),
      builder: (_, stateSetting) {
        return Scaffold(
          backgroundColor: HexColor.fromHex(stateSetting.settingData.lightColor!),
          appBar: AppBar(
            toolbarHeight: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: HexColor.fromHex(stateSetting.settingData.mainColor1!),
              systemNavigationBarColor: Colors.white,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarIconBrightness: Brightness.light,
              systemNavigationBarDividerColor: Colors.white
            ),
          ),
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              elevation: 5,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              height: 60,
              labelTextStyle: MaterialStatePropertyAll(
                GoogleFonts.openSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                )
              ),
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow
            ),
            child: DoubleBackToCloseApp(
              snackBar: const SnackBar(content: Text("Tekan Sekali Lagi untuk Keluar")),
              child: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
                builder: (_, state) {
                  return NavigationBar(
                    indicatorColor: HexColor.fromHex(stateSetting.settingData.indicatorColor!),
                    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                    surfaceTintColor: HexColor.fromHex(stateSetting.settingData.surfaceColor!),
                    elevation: 1,
                    selectedIndex: state.navigationIndex,
                    onDestinationSelected: (index) {
                      bottomNavigationCubit.changeNavigationIndex(index);
                    },
                    destinations: [
                      NavigationDestination(
                        icon: Icon(
                          state.navigationIndex == 0 ? Iconsax.home_15 : Iconsax.home,
                          color: state.navigationIndex == 0 ? HexColor.fromHex(stateSetting.settingData.mainColor1!) : 
                          HexColor.fromHex(stateSetting.settingData.lightTextColor!),
                        ), 
                        label: "Home",
                      ),
                      NavigationDestination(
                        icon: BlocBuilder<NotificationCountCubit, NotificationCountState>(
                          bloc: locator.get<NotificationCountCubit>(),
                          builder: (_, stateNotification) {
                            if(stateNotification.notificationCount > 0) {
                              return badges.Badge(
                                position: badges.BadgePosition.topEnd(top: -12, end: -8),
                                badgeContent: Text(stateNotification.notificationCount.toString(), style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                                ),),
                                child: Icon(
                                  state.navigationIndex == 1 ? Iconsax.directbox_notif5 : Iconsax.directbox_notif,
                                  color: state.navigationIndex == 1 ? HexColor.fromHex(stateSetting.settingData.mainColor1!) : HexColor.fromHex(stateSetting.settingData.lightTextColor!),
                                ),
                              );
                            } else {
                              return badges.Badge(
                                position: badges.BadgePosition.topEnd(top: -2, end: -2),
                                child: Icon(
                                  state.navigationIndex == 1 ? Iconsax.directbox_notif5 : Iconsax.directbox_notif,
                                  color: state.navigationIndex == 1 ? HexColor.fromHex(stateSetting.settingData.mainColor1!) : HexColor.fromHex(stateSetting.settingData.lightTextColor!),
                                ),
                              );
                            }
                          }
                        ), 
                        label: "Inbox",
                      ),
                      NavigationDestination(
                        icon: Icon(
                          state.navigationIndex == 2 ? Iconsax.document_text5 : Iconsax.document_text,
                          color: state.navigationIndex == 2 ? HexColor.fromHex(stateSetting.settingData.mainColor1!) : HexColor.fromHex(stateSetting.settingData.lightTextColor!),
                        ), 
                        label: "Riwayat",
                      ),
                      NavigationDestination(
                        icon: Icon(
                          state.navigationIndex == 3 ? Iconsax.tag_user5 : Iconsax.tag_user,
                          color: state.navigationIndex == 3 ? HexColor.fromHex(stateSetting.settingData.mainColor1!) : HexColor.fromHex(stateSetting.settingData.lightTextColor!),
                        ), 
                        label: "Akun",
                      ),
                    ]
                  );
                },
              ),
            ),
          ),
          body: SafeArea(
            child: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
              builder: (_, state) {
                return screenList[state.navigationIndex];
              },
            ),
          ),
        );
      }
    );
  }
}