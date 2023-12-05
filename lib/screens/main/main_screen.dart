import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/bottom_navigation_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/favorite_menu_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/screens/main/account_screen.dart";
import "package:adamulti_mobile_clone_new/screens/main/history_screen.dart";
import "package:adamulti_mobile_clone_new/screens/main/home_screen.dart";
import "package:adamulti_mobile_clone_new/screens/main/inbox_screen.dart";
import "package:adamulti_mobile_clone_new/services/backoffice_service.dart";
import "package:double_back_to_close_app/double_back_to_close_app.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";
import 'package:badges/badges.dart' as badges;

class MainScreen extends StatefulWidget {

  const MainScreen({ super.key });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final List<Widget> screenList = [
    const HomeScreen(),
    const InboxScreen(),
    const HistoryScreen(),
    const AccountScreen()
  ];

  @override
  void initState() {
    final favoriteMenuCubit = context.read<FavoriteMenuCubit>();

    locator.get<BackOfficeService>().getSpecificMenuByKategori(1).then((value) {
      favoriteMenuCubit.updateStae(false, value);
    }).catchError((e) {
      showDynamicSnackBar(
        context, 
        LineIcons.exclamationTriangle, 
        "ERROR", 
        "Terjadi Kesalahan, Silahkan Periksa Koneksi Internet Anda.", 
        Colors.red
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavigationCubit = context.read<BottomNavigationCubit>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          elevation: 5,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          height: 60,
          indicatorColor: kNavigationBarColor,
          labelTextStyle: MaterialStatePropertyAll(
            GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600
            )
          ),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow
        ),
        child: DoubleBackToCloseApp(
          snackBar: const SnackBar(content: Text("Tekan Sekali Lagi untuk Keluar")),
          child: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
            builder: (context, state) {
              return NavigationBar(
                elevation: 1,
                selectedIndex: state.navigationIndex,
                onDestinationSelected: (index) {
                  bottomNavigationCubit.changeNavigationIndex(index);
                },
                destinations: [
                  NavigationDestination(
                    icon: Icon(
                      LineIcons.home,
                      color: state.navigationIndex == 0 ? Colors.white : const Color(0xff4d4d4d),
                    ), 
                    label: "Home",
                  ),
                  NavigationDestination(
                    icon: badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -5, end: -5),
                      child: Icon(
                        LineIcons.envelopeOpenText,
                        color: state.navigationIndex == 1 ? Colors.white : const Color(0xff4d4d4d),
                      ),
                    ), 
                    label: "Inbox",
                  ),
                  NavigationDestination(
                    icon: Icon(
                      LineIcons.fileInvoice,
                      color: state.navigationIndex == 2 ? Colors.white : const Color(0xff4d4d4d),
                    ), 
                    label: "Riwayat",
                  ),
                  NavigationDestination(
                    icon: Icon(
                      LineIcons.userCircleAlt,
                      color: state.navigationIndex == 3 ? Colors.white : const Color(0xff4d4d4d),
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
}