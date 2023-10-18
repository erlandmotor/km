import "package:adamulti_mobile_clone_new/cubit/authenticated_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/bottom_navigation_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/check_identity_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/history_transaksi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/loading_button_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/screens/main/main_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/check_before_transaction_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/pln_main_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/pln_token_screen.dart";
import 'package:adamulti_mobile_clone_new/screens/page/pulsa_main_screen.dart';
import 'package:adamulti_mobile_clone_new/screens/page/select_operator_double_ppob_screen.dart';
import 'package:adamulti_mobile_clone_new/screens/page/select_operator_screen.dart';
import "package:adamulti_mobile_clone_new/screens/page/select_operator_triple_ppob_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/select_product_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/select_product_transaction_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/topup/topup_main_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/webview_screen.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";

GoRouter screenRouter() {

  return GoRouter(
    routes: [
      GoRoute(
        path: "/",
        name: "main",
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => BottomNavigationCubit(),
              ),
              BlocProvider(
                create: (_) => HistoryTransaksiCubit()
              ),
              BlocProvider(
                create: (_) => LoadingButtonCubit()
              ),
              BlocProvider.value(value: locator.get<AuthenticatedCubit>()),
              BlocProvider.value(value: locator.get<UserAppidCubit>())
            ], 
            child: const MainScreen()
          );
        },
        routes: [
          GoRoute(
            path: "pulsa-main",
            name: "pulsa-main",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final operatorId = extra["operatorId"] as String;
              final title = extra["title"] as String;
              return PulsaMainScreen(title: title, operatorId: operatorId,);
            },
          ),
          GoRoute(
            path: "web-view",
            name: "web-view",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final operatorId = extra["operatorId"] as String;
              final title = extra["title"] as String;
              return BlocProvider(
                create: (_) => CheckIdentityCubit(),
                child: WebviewScreen(title: title, operatorId: operatorId,),
              );
            }
          ),
          GoRoute(
            path: "pln-main",
            name: "pln-main",
            builder: (context, state) {
              return const PlnMainScreen();
            }
          ),
          GoRoute(
            path: "pln-token",
            name: "pln-token",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final operatorName = extra["operatorName"] as String;
              final operatorId = extra["operatorId"] as String;
              final kodeProduk = extra["kodeproduk"] as String;

              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: locator.get<UserAppidCubit>()),
                  BlocProvider(create: (_) => CheckIdentityCubit())
                ], 
                child: PlnTokenScreen(operatorName: operatorName, operatorId: operatorId, kodeProduk: kodeProduk,),
              );
            }
          ),
          GoRoute(
            path: "select-operator",
            name: "select-operator",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final operatorName = extra["operatorName"] as String;

              return BlocProvider.value(
                value: locator.get<UserAppidCubit>(),
                child: SelectOperatorScreen(operatorName: operatorName),
              );
            }
          ),
          GoRoute(
            path: "select-operator-double-ppob",
            name: "select-operator-double-ppob",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final operatorName = extra["operatorName"] as String;
              final operatorId = extra["operatorId"] as String;

              return SelectOperatorDoublePpobScreen(operatorName: operatorName, operatorId: operatorId);
            }
          ),
          GoRoute(
            path: "select-product",
            name: "select-product",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final operatorName = extra["operatorName"] as String;
              final operatorId = extra["operatorId"] as String;

              return BlocProvider.value(
                value: locator.get<UserAppidCubit>(),
                child: SelectProductScreen(operatorName: operatorName, operatorId: operatorId),
              );
            }
          ),
          GoRoute(
            path: "select-operator-triple-ppob",
            name: "select-operator-triple-ppob",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final operatorName = extra["operatorName"] as String;
              final operatorId = extra["operatorId"] as String;

              return SelectOperatorTriplePpobScreen(operatorName: operatorName, operatorId: operatorId);
            }
          ),
          GoRoute(
            path: "select-product-transaction",
            name: "select-product-transaction",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final operatorName = extra["operatorName"] as String;
              final operatorId = extra["operatorId"] as String;

              return BlocProvider.value(
                value: locator.get<UserAppidCubit>(),
                child: SelectProductTransactionScreen(operatorName: operatorName, operatorId: operatorId),
              );
            }
          ),
          GoRoute(
            path: "check-before-transaction",
            name: "check-before-transaction",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final operatorName = extra["operatorName"] as String;
              final kodeProduk = extra["kodeproduk"] as String;

              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: locator.get<UserAppidCubit>()),
                  BlocProvider(create: (_) => CheckIdentityCubit())
                ], 
                child: CheckBeforeTransactionScreen(kodeProduk: kodeProduk, operatorName: operatorName,)
              );
            }
          ),
          GoRoute(
            path: "topup-main",
            name: "topup-main",
            builder: (context, state) {
              return const TopupMainScreen(); 
            }
          )
        ]
      )
    ]
  );
}