import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar_with_nav.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/no_data_component.dart";
import "package:adamulti_mobile_clone_new/components/search_textfield_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/downline_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:custom_pop_up_menu/custom_pop_up_menu.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class DaftarAgenScreen extends StatefulWidget {

  const DaftarAgenScreen({ super.key });

  @override
  State<DaftarAgenScreen> createState() => _DaftarAgenScreenState();
}

class _DaftarAgenScreenState extends State<DaftarAgenScreen> {
  final searchController = TextEditingController();
  var currentPage = 1;
  final scrollController = ScrollController();

  final popupMenuController = CustomPopupMenuController();

  @override
  void initState() {
    final downlineCubit = context.read<DownlineCubit>();

    locator.get<AuthService>().getDownline(
      locator.get<UserAppidCubit>().state.userAppId.appId, 
      "", 
      currentPage
    ).then((value) {
      downlineCubit.updateState(false, value.data!);
    }).catchError((e) {
      showDynamicSnackBar(
        context, 
        LineIcons.exclamationTriangle, 
        "ERROR", 
        e.toString(), 
        Colors.red
      );
    });

    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.offset) {
        currentPage += 1;
        locator.get<AuthService>().getDownline(
          locator.get<UserAppidCubit>().state.userAppId.appId, 
          searchController.text,
          currentPage
        ).then((value) {
          downlineCubit.updateState(false, [...downlineCubit.state.dataList, ...value.data!]);
        }).catchError((e) {
          showDynamicSnackBar(
            context, 
            LineIcons.exclamationTriangle, 
            "ERROR", 
            e.toString(), 
            Colors.red
          );
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final downlineCubit = context.read<DownlineCubit>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ContainerGradientBackground(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Expanded(
                    child: Container(
                      decoration: kContainerLightDecoration,
                    )
                  )
                ],
              ),
              Column(
                children: [
                  CustomContainerAppBarWithNav(
                    title: "Daftar Agen", 
                    height: 80, 
                    onTapNav: () {
                      context.pop();
                    }
                  ),
                  Card(
                    surfaceTintColor: Colors.blue,
                    child: Container(
                      width: 96.w,
                      padding: const EdgeInsets.all(18),
                      child: SearchTextfieldComponent(
                        label: "Cari Data Produk", 
                        hint: "Contoh : Yoga", 
                        controller: searchController,
                        onChanged: (String term) {
                          currentPage = 1;

                          locator.get<AuthService>().getDownline(
                            locator.get<UserAppidCubit>().state.userAppId.appId, 
                            searchController.text,
                            currentPage
                          ).then((value) {
                            downlineCubit.updateState(false, value.data!);
                          }).catchError((e) {
                            showDynamicSnackBar(
                              context, 
                              LineIcons.exclamationTriangle, 
                              "ERROR", 
                              e.toString(), 
                              Colors.red
                            );
                          });
                        }
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Expanded(
                    child: BlocBuilder<DownlineCubit, DownlineState>(
                      builder: (_, state) {
                        if(state.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if(state.dataList.isEmpty) {
                            return const NoDataComponent(label: "Tidak Ada Data Agen");
                          } else {
                            return ListView.separated(
                              padding: const EdgeInsets.all(2),
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                if(index < state.dataList.length) {
                                  return Card(
                                    surfaceTintColor: Colors.white,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      width: 100.w,
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: kMainThemeColor.withOpacity(0.2),
                                          radius: 28,
                                          child: CircleAvatar(
                                            backgroundColor: kMainLightThemeColor.withOpacity(0.6),
                                            radius: 24,
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: kMainThemeColor,
                                              child: Text("${state.dataList[index].idreseller![0]}${state.dataList[index].idreseller![1]}", style: GoogleFonts.inter(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white
                                              ),),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          "${state.dataList[index].idreseller!} | ${state.dataList[index].namareseller!}",
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 4,),
                                            Text(
                                              "Saldo : ${FormatCurrency.convertToIdr(state.dataList[index].saldo!, 0)}",
                                              style: GoogleFonts.inter(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500
                                              ),
                                            ),
                                            const SizedBox(height: 2,),
                                            Text(
                                              "Mark Up : ${FormatCurrency.convertToIdr(state.dataList[index].tambahanhargapribadi!, 0)}",
                                              style: GoogleFonts.inter(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: IconButton(
                                          icon: CustomPopupMenu(
                                            menuBuilder: () => Container(
                                              padding: const EdgeInsets.all(18),
                                              width: 60.w,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(18)
                                              ),
                                              child: IntrinsicWidth(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        context.goNamed("transfer-dynamic-main", extra: {
                                                          "idreseller": state.dataList[index].idreseller!,
                                                          "namareseller": state.dataList[index].namareseller!
                                                        });
                                                      },
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          const Icon(LineIcons.wallet, color: Colors.black,),
                                                          const SizedBox(width: 8,),
                                                          Text("Kirim Saldo", style: GoogleFonts.inter(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500
                                                          ),)
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 6,),
                                                    const Divider(),
                                                    const SizedBox(height: 6,),
                                                    GestureDetector(
                                                      onTap: () {},
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          const Icon(LineIcons.alternateMoneyCheck, color: Colors.black,),
                                                          const SizedBox(width: 8,),
                                                          Text("Ubah Markup", style: GoogleFonts.inter(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500
                                                          ),)
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ), 
                                            pressType: PressType.singleClick,
                                            verticalMargin: 10,
                                            horizontalMargin: 10,
                                            arrowColor: Colors.white,
                                            barrierColor: Colors.black54,
                                            showArrow: true,
                                            child: const Icon(LineIcons.verticalEllipsis, color: Colors.black,),
                                          ),
                                          onPressed: () {},
                                        ),
                                      )
                                    ),
                                  );
                                } else {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 32),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              }, 
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 6,);
                              }, 
                              itemCount: state.dataList.length
                            );
                          }
                        }
                      }
                    ),
                  )
                ],
              )
            ]
          )
        )
      ),
    );
  }
}