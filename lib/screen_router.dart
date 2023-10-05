import "package:adamulti_mobile_clone_new/cubit/authenticated_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/bottom_navigation_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/screens/main/main_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/pln_main_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/pln_token_screen.dart";
import 'package:adamulti_mobile_clone_new/screens/page/pulsa_main_screen.dart';
import 'package:adamulti_mobile_clone_new/screens/page/select_operator_screen.dart';
import "package:adamulti_mobile_clone_new/screens/page/select_product_transaction_screen.dart";
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
              return const PulsaMainScreen();
            },
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

              return BlocProvider.value(
                value: locator.get<UserAppidCubit>(),
                child: PlnTokenScreen(operatorName: operatorName, operatorId: operatorId),
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
          )
        ]
      )
    ]
  );
}