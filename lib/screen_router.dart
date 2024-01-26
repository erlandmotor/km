import "package:adamulti_mobile_clone_new/cubit/bottom_navigation_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/check_identity_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/downline_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/favorite_menu_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/history_calendar_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/history_saldo_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/history_topup_saldo_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/history_transaksi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/history_transfer_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/komisi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/notifications_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/pricelist_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/pulsa_and_data_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/rekap_transaksi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/running_text_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/search_history_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/select_operator_backoffice_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/select_operator_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/select_product_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/select_product_ppob_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/select_product_transaction_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/select_region_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/topup_saldo_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/transaction_detail_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/transfer_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/topup_reply_response.dart";
import "package:adamulti_mobile_clone_new/schema/inbox_schema.dart";
import "package:adamulti_mobile_clone_new/screens/auth/input_phone_number_screen.dart";
import "package:adamulti_mobile_clone_new/screens/auth/input_pin_already_registered_screen.dart";
import "package:adamulti_mobile_clone_new/screens/auth/input_pin_screen.dart";
import "package:adamulti_mobile_clone_new/screens/auth/otp_already_registered_screen.dart";
import "package:adamulti_mobile_clone_new/screens/auth/otp_screen.dart";
import "package:adamulti_mobile_clone_new/screens/auth/register_screen.dart";
import "package:adamulti_mobile_clone_new/screens/auth/select_city_screen.dart";
import "package:adamulti_mobile_clone_new/screens/auth/select_district_screen.dart";
import "package:adamulti_mobile_clone_new/screens/auth/select_google_account_screen.dart";
import "package:adamulti_mobile_clone_new/screens/auth/select_province_screen.dart";
import "package:adamulti_mobile_clone_new/screens/main/main_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/artikel/artikel_detail_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/artikel/artikel_main_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/change_pin/change_pin_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/check_before_transaction_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/daftar_agen/daftar_agen_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/daftar_agen/markup_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/daftar_agen/register_agen_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/inbox/inbox_activity_detail_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/inbox/inbox_detail_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/komisi/komisi_main_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/more_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/pln_main_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/pln_token_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/price_list/price_list_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/printer_setting/connect_printer_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/printer_setting/printer_setting_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/privacy_policy/privacy_policy_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/pulsa_and_data_main_screeen.dart";
import 'package:adamulti_mobile_clone_new/screens/page/pulsa_main_screen.dart';
import "package:adamulti_mobile_clone_new/screens/page/reward/reward_main_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/select_operator_backoffice_screen.dart";
import 'package:adamulti_mobile_clone_new/screens/page/select_operator_screen.dart';
import "package:adamulti_mobile_clone_new/screens/page/select_operator_triple_ppob_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/select_product_ppob_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/select_product_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/select_product_transaction_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/topup/topup_bank_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/topup/topup_main_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/topup/topup_metode_pembayaran_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/transaction/transaction_detail_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/transfer/transfer_dynamic_main_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/transfer/transfer_main_screen.dart";
import "package:adamulti_mobile_clone_new/screens/page/webview_screen.dart";
import "package:adamulti_mobile_clone_new/services/local_notification_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";

GoRouter screenRouter(String? token) {

  return GoRouter(
    navigatorKey: locator.get<LocalNotificationService>().globalNavigatorKey,
    initialLocation: token != null ? "/main" : "/select-google-account",
    routes: [
      GoRoute(
        path: "/select-google-account",
        name: "select-google-account",
        builder: (context, state) {
          return const SelectGoogleAccountScreen();
        }
      ),
      GoRoute(
        path: "/input-phone-number",
        name: "input-phone-number",
        builder: (context, state) {
          return const InputPhoneNumberScreen();
        }
      ),
      GoRoute(
        path: "/otp",
        name: "otp",
        builder: (context, state) {
          final extra = state.extra as Map<dynamic, dynamic>;
          final phoneNumber = extra["phoneNumber"] as String;
          final otpCode = extra["otpCode"] as String;

          return OtpScreen(phoneNumber: phoneNumber, otpCode: otpCode);
        }
      ),
      GoRoute(
        path: "/otp-already-registered",
        name: "otp-already-registered",
        builder: (context, state) {
          final extra = state.extra as Map<dynamic, dynamic>;
          final phoneNumber = extra["phoneNumber"] as String;
          final idreseller = extra["idreseller"] as String;

          return OtpAlreadyRegisteredScreen(idReseller: idreseller, phoneNumber: phoneNumber);
        }
      ),
      GoRoute(
        path: "/register",
        name: "register",
        builder: (context, state) {
          final extra = state.extra as Map<dynamic, dynamic>;
          final phoneNumber = extra["phoneNumber"] as String;
          return BlocProvider(
            create: (_) => SelectRegionCubit(),
            child: RegisterScreen(phoneNumber: phoneNumber,),
          );
        }
      ),
      GoRoute(
        path: "/select-province",
        name: "select-province",
        builder: (context, state) {
          final extra = state.extra as Map<dynamic, dynamic>;
          final selectRegionCubit = extra["selectRegionCubit"] as SelectRegionCubit;
          final provinceController = extra["provinceController"] as TextEditingController;
          final cityController = extra["cityController"] as TextEditingController;
          final districtController = extra["districtController"] as TextEditingController;
          
          return SelectProvinceScreen(selectRegionCubit: selectRegionCubit, provinceController: provinceController,
            cityController: cityController, districtController: districtController,);
        }
      ),
      GoRoute(
        path: "/select-city",
        name: "select-city",
        builder: (context, state) {
          final extra = state.extra as Map<dynamic, dynamic>;
          final selectRegionCubit = extra["selectRegionCubit"] as SelectRegionCubit;
          final cityController = extra["cityController"] as TextEditingController;
          final districtController = extra["districtController"] as TextEditingController;

          return SelectCityScreen(selectRegionCubit: selectRegionCubit, cityController: cityController,
            districtController: districtController,);
        }
      ),
      GoRoute(
        path: "/select-district",
        name: "select-district",
        builder: (context, state) {
          final extra = state.extra as Map<dynamic, dynamic>;
          final selectRegionCubit = extra["selectRegionCubit"] as SelectRegionCubit;
          final districtController = extra["districtController"] as TextEditingController;

          return SelectDistrictScreen(selectRegionCubit: selectRegionCubit, districtController: districtController,);
        }
      ),
      GoRoute(
        path: "/input-pin",
        name: "input-pin",
        builder: (context, state) {
          final extra = state.extra as Map<dynamic, dynamic>;
          final phoneNumber = extra["phoneNumber"] as String;
          return InputPinScreen(phoneNumber: phoneNumber,);
        }
      ),
      GoRoute(
        path: "/input-pin-already-registered",
        name: "input-pin-already-registered",
        builder: (context, state) {
          final extra = state.extra as Map<dynamic, dynamic>;
          final idreseller = extra["idreseller"] as String;
          return InputPinAlreadyRegisteredScreen(idreseller: idreseller);
        }
      ),
      GoRoute(
        path: "/main",
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
                create: (_) => SearchHistoryCubit()
              ),
              BlocProvider(create: (_) => HistorySaldoCubit()),
              BlocProvider(create: (_) => RekapTransaksiCubit()),
              BlocProvider(create: (_) => HistoryTopupSaldoCubit()),
              BlocProvider(create: (_) => HistoryTransferCubit()),
              BlocProvider(create: (_) => FavoriteMenuCubit()),
              BlocProvider(create: (_) => NotificationsCubit()),
              BlocProvider(create: (_) => RunningTextCubit()),
              BlocProvider(create: (_) => HistoryCalendarCubit())
            ], 
            child: const MainScreen()
          );
        },
        routes: [
          GoRoute(
            path: "pulsa-and-data",
            name: "pulsa-and-data",
            builder: (context, state) {
              return BlocProvider(
                create: (_) => PulsaAndDataCubit(),
                child: const PulsaAndDataMainScreen(),
              );
            }
          ),
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
              final url = extra['url'] as String;
              return BlocProvider(
                create: (_) => CheckIdentityCubit(),
                child: WebviewScreen(title: title, operatorId: operatorId, url: url,),
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

              return BlocProvider(
                create: (_) => CheckIdentityCubit(),
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

              return BlocProvider(
                create: (_) => SelectOperatorCubit(),
                child: SelectOperatorScreen(operatorName: operatorName),
              );
            }
          ),
          GoRoute(
            path: "select-product-ppob",
            name: "select-product-ppob",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final operatorName = extra["operatorName"] as String;
              final operatorId = extra["operatorId"] as String;

              return BlocProvider(
                create: (_) => SelectProductPpobCubit(),
                child: SelectProductPpobScreen(operatorName: operatorName, operatorId: operatorId),
              );
            }
          ),
          GoRoute(
            path: "select-product",
            name: "select-product",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final operatorName = extra["operatorName"] as String;
              final operatorId = extra["operatorId"] as String;

              return BlocProvider(
                create: (_) => SelectProductCubit(),
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
            path: "select-operator-backoffice",
            name: "select-operator-backoffice",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final operatorName = extra["operatorName"] as String;
              final operatorId = extra["operatorId"] as String;

              return BlocProvider(
                create: (_) => SelectOperatorBackofficeCubit(),
                child: SelectOperatorBackofficeScreen(operatorName: operatorName, operatorId: operatorId),
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

              return BlocProvider(
                create: (_) => SelectProductTransactionCubit(),
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

              return BlocProvider(
                create: (_) => CheckIdentityCubit(),
                child: CheckBeforeTransactionScreen(kodeProduk: kodeProduk, operatorName: operatorName,),
              );
            }
          ),
          GoRoute(
            path: "topup-main",
            name: "topup-main",
            builder: (context, state) {
              return BlocProvider(
                create: (_) => TopupSaldoCubit(),
                child: const TopupMainScreen(),
              ); 
            }
          ),
          GoRoute(
            path: "topup-metode-pembayaran",
            name: "topup-metode-pembayaran",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final amount = extra["amount"] as int;
              return TopupMetodePembayaranScreen(amount: amount);
            }
          ),
          GoRoute(
            path: "topup-bank",
            name: "topup-bank",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final data = extra["data"] as TopupReplyResponse;

              return TopupBankScreen(data: data);
            }
          ),
          GoRoute(
            path: "transfer-main",
            name: "transfer-main",
            builder: (context, state) {
              return BlocProvider(
                create: (_) => TransferCubit(),
                child: const TransferMainScreen(),
              );
            }
          ),
          GoRoute(
            path: "transfer-dynamic-main",
            name: "transfer-dynamic-main",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final idReseller = extra["idreseller"] as String;
              final namaReseller = extra["namareseller"] as String;
              return BlocProvider(
                create: (_) => TransferCubit(),
                child: TransferDynamicMainScreen(idReseller: idReseller, namaReseller: namaReseller,),
              );
            }
          ),
          GoRoute(
            path: "reward-main",
            name: "reward-main",
            builder: (context, sate) {
              return const RewardMainScreen();
            }
          ),
          GoRoute(
            path: "komisi-main",
            name: "komisi-main",
            builder: (context, state) {
              return BlocProvider(
                create: (_) => KomisiCubit(),
                child: const KomisiMainScreen(),
              );
            }
          ),
          GoRoute(
            path: "more",
            name: "more",
            builder: (context, state) {
              return const MoreScreen();
            }
          ),
          GoRoute(
            path: "price-list",
            name: "price-list",
            builder: (context, state) {
              return BlocProvider(
                create: (_) => PricelistCubit(),
                child: const PriceListScreen(),
              );
            }
          ),
          GoRoute(
            path: "change-pin",
            name: "change-pin",
            builder: (context, state) {
              return const ChangePinScreen();
            }
          ),
          GoRoute(
            path: "daftar-agen",
            name: "daftar-agen",
            builder: (context, state) {
              return BlocProvider(
                create: (_) => DownlineCubit(),
                child: const DaftarAgenScreen(),
              );
            }
          ),
          GoRoute(
            path: "markup",
            name: "markup",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final idReseller = extra["idreseller"] as String;
              final namaReseller = extra["namareseller"] as String;
              final markup = extra["markup"] as String;
              return MarkupScreen(idReseller: idReseller, namaReseller: namaReseller, markup: markup,);
            }
          ),
          GoRoute(
            path: "register-agen",
            name: "register-agen",
            builder: (context, state) {
              return BlocProvider(
                create: (_) => SelectRegionCubit(),
                child: const RegisterAgenScreen(),
              );
            }
          ),
          GoRoute(
            path: "transaction-detail",
            name: "transaction-detail",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final idtrx = extra['idtrx'] as String;
              final total = extra['total'] as int;
              final type = extra['type'] as String;
              return BlocProvider(
                create: (_) => TransactionDetailCubit(),
                child: TransactionDetailScreen(idtrx: idtrx, total: total, type: type,)
              );
            }
          ),
          GoRoute(
            path: "printer-setting",
            name: "printer-setting",
            builder: (context, state) {
              return const PrinterSettingScreen();
            }
          ),
          GoRoute(
            path: "connect-printer",
            name: "connect-printer",
            builder: (context, state) {
              return const ConnectPrinterScreen();
            }
          ),
          GoRoute(
            path: "privacy-policy",
            name: "privacy-policy",
            builder: (context, state) {
              return const PrivacyPolicyScreen();
            }
          ),
          GoRoute(
            path: "inbox-detail",
            name: "inbox-detail",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final notificationId = extra["notificationId"] as int;

              return InboxDetailScreen(notificationId: notificationId);
            }
          ),
          GoRoute(
            path: "inbox-activity-detail",
            name: "inbox-activity-detail",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final data = extra["data"] as InboxSchema;

              return InboxActivityDetailScreen(data: data,);
            }
          ),
          GoRoute(
            path: "artikel-main",
            name: "artikel-main",
            builder: (context, index) {
              return const ArtikelMainScreen();
            }
          ),
          GoRoute(
            path: "artikel-detail",
            name: "artikel-detail",
            builder: (context, state) {
              final extra = state.extra as Map<dynamic, dynamic>;
              final artikelId = extra["artikelId"] as int;
              return ArtikelDetailScreen(artikelId: artikelId);
            }
          )
        ]
      )
    ]
  );
}