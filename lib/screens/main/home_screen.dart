
import "package:adamulti_mobile_clone_new/components/artikel_component.dart";
import "package:adamulti_mobile_clone_new/components/curve_clipper.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/home_carousel.dart";
import "package:adamulti_mobile_clone_new/components/layanan_component.dart";
import "package:adamulti_mobile_clone_new/components/main_menu_shimmer.dart";
import "package:adamulti_mobile_clone_new/components/saldo_action_component.dart";
import "package:adamulti_mobile_clone_new/components/social_item_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/authenticated_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/favorite_menu_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/getme_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/google_account_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/running_text_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/artikel_data.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:adamulti_mobile_clone_new/services/backoffice_service.dart";
import "package:adamulti_mobile_clone_new/services/secure_storage.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:custom_pop_up_menu/custom_pop_up_menu.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:responsive_sizer/responsive_sizer.dart";
import "package:url_launcher/url_launcher.dart";
import 'package:marquee/marquee.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final favoriteMenuCubit = context.read<FavoriteMenuCubit>();

    return RefreshIndicator(
      onRefresh: () async {
        favoriteMenuCubit.updateStae(true, favoriteMenuCubit.state.menuData);
        await locator.get<BackOfficeService>().getSpecificMenuByKategori(1).then((value) {
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


        locator.get<BackOfficeService>().findFirstSettingApplikasi("ADAMULTI").then((value) {
          locator.get<SettingApplikasiCubit>().updateState(value);
        });

        await locator.get<AuthService>().authenticated().then((authenticated) {
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
      },
      child: SingleChildScrollView(
        child: Stack(
          children: [
            BlocBuilder<SettingApplikasiCubit, SettingApplikasiState>(
              bloc: locator.get<SettingApplikasiCubit>(),
              builder: (_, stateSetting) {
                return ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    width: 100.w,
                    height: 240,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          HexColor.fromHex(stateSetting.settingData.mainColor1!),
                          HexColor.fromHex(stateSetting.settingData.mainColor2!),
                          HexColor.fromHex(stateSetting.settingData.mainColor3!),
                        ],
                        stops: const [0, 0.4, 0.8],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    ),
                  ),
                );
              }
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 60.w,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.white,
                              child: BlocBuilder<GoogleAccountCubit, GoogleAccountState>(
                                bloc: locator.get<GoogleAccountCubit>(),
                                builder: (_, state) {
                                  if(state.userData == null) {
                                    return BlocBuilder<SettingApplikasiCubit, SettingApplikasiState>(
                                      bloc: locator.get<SettingApplikasiCubit>(),
                                      builder: (_, stateSetting) {
                                        return CircleAvatar(
                                          radius: 22,
                                          backgroundColor: HexColor.fromHex(stateSetting.settingData.infoColor!),
                                          child: const Icon(Iconsax.user, color: Colors.white,),
                                        );
                                      }
                                    );
                                  } else {
                                    if(state.userData!.photoUrl == null) {
                                      return BlocBuilder<SettingApplikasiCubit, SettingApplikasiState>(
                                        bloc: locator.get<SettingApplikasiCubit>(),
                                        builder: (_, stateSetting) {
                                          return CircleAvatar(
                                            radius: 22,
                                            backgroundColor: HexColor.fromHex(stateSetting.settingData.infoColor!),
                                            child: const Icon(Iconsax.user, color: Colors.white,),
                                          );
                                        }
                                      );
                                    } else {
                                      return CircleAvatar(
                                        radius: 22,
                                        backgroundImage: CachedNetworkImageProvider(
                                          state.userData!.photoUrl! 
                                        ),
                                      );
                                    }
                                  }
                                },
                              )
                              
                            ),
                            const SizedBox(width: 12,),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BlocBuilder<AuthenticatedCubit, AuthenticatedState>(
                                    bloc: locator.get<AuthenticatedCubit>(),
                                    builder: (_, state) {
                                      return Text(state.authenticatedUser.idreseller != null ?
                                      state.authenticatedUser.idreseller! : "", style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white
                                      ),);
                                    }
                                  ),
                                  const SizedBox(height: 4,),
                                  BlocBuilder<AuthenticatedCubit, AuthenticatedState>(
                                    bloc: locator.get<AuthenticatedCubit>(),
                                    builder: (_, state) {
                                      return Text(state.authenticatedUser.nAMARESELLER != null ? 
                                      state.authenticatedUser.nAMARESELLER!
                                      : "", 
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white
                                      ),);
                                    }
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 14,),
                      Expanded(
                        child: BlocBuilder<SettingApplikasiCubit, SettingApplikasiState>(
                          bloc: locator.get<SettingApplikasiCubit>(),
                          builder: (_, stateSetting) {
                            return CustomPopupMenu(
                              menuBuilder: () {
                                return Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SocialItemComponent(
                                        imageUrl: "https://res.cloudinary.com/ada-multi/image/upload/v1706930937/logo-whatsapp_covom4.png", 
                                        label: "Whatsapp", 
                                        onTapAction: () {
                                          final Uri csWhatsApp = Uri.parse("whatsapp://send/?phone=6287865811150&text=${Uri.parse("Halo ")}");
                                          launchUrl(csWhatsApp);
                                        }, 
                                        menuColor: Colors.green.withOpacity(0.1), 
                                        mainContainerWidth: 56, 
                                        containerWidth: 48, 
                                        containerHeight: 48, 
                                        imageHeight: 36, 
                                        imageWidth: 36, 
                                        containerBorderRadius: 8
                                      ),
                                      // const Divider(),
                                      // SocialItemComponent(
                                      //   imageUrl: "https://res.cloudinary.com/ada-multi/image/upload/v1706930937/logo-instagram_lpbfcu.png", 
                                      //   label: "Instagram", 
                                      //   onTapAction: () {
                                      //     final Uri instagramLink = Uri.parse("https://www.instagram.com/mitrapulsa.nusantara/");
                                      //     launchUrl(instagramLink);
                                      //   }, 
                                      //   menuColor: const Color(0xff5045a2).withOpacity(0.2), 
                                      //   mainContainerWidth: 56, 
                                      //   containerWidth: 48, 
                                      //   containerHeight: 48, 
                                      //   imageHeight: 36, 
                                      //   imageWidth: 36, 
                                      //   containerBorderRadius: 8
                                      // ),
                                      const Divider(),
                                      SocialItemComponent(
                                        imageUrl: "https://res.cloudinary.com/ada-multi/image/upload/v1706930936/logo-facebook_q1nrpf.png", 
                                        label: "Facebook", 
                                        onTapAction: () {
                                          final Uri facebookLink = Uri.parse("fb://facewebmodal/f?href=https://www.facebook.com/adamultipulsa/");
                                          launchUrl(facebookLink);
                                        }, 
                                        menuColor: const Color(0xff3a579b).withOpacity(0.2), 
                                        mainContainerWidth: 56, 
                                        containerWidth: 48, 
                                        containerHeight: 48, 
                                        imageHeight: 36, 
                                        imageWidth: 36, 
                                        containerBorderRadius: 8
                                      ),
                                      // const Divider(),
                                      // SocialItemComponent(
                                      //   imageUrl: "https://res.cloudinary.com/ada-multi/image/upload/v1706930938/logo-youtube_xh7uqe.png", 
                                      //   label: "Youtube", 
                                      //   onTapAction: () {
                                      //     final Uri youtubeLink = Uri.parse("https://www.youtube.com/channel/UC61vAKISPistmY_DpROYXrQ");
                                      //     launchUrl(youtubeLink);
                                      //   }, 
                                      //   menuColor: const Color(0xffc0392b).withOpacity(0.2), 
                                      //   mainContainerWidth: 56, 
                                      //   containerWidth: 48, 
                                      //   containerHeight: 48, 
                                      //   imageHeight: 36, 
                                      //   imageWidth: 36, 
                                      //   containerBorderRadius: 8
                                      // ),
                                      const Divider(),
                                      SocialItemComponent(
                                        imageUrl: "https://res.cloudinary.com/ada-multi/image/upload/v1706930939/logo-chrome_rlwwfg.png", 
                                        label: "Website", 
                                        onTapAction: () {
                                          final Uri websiteUri = Uri.parse("https://www.adamulti.com/");
                                          launchUrl(websiteUri);
                                        }, 
                                        menuColor: const Color(0xfffed14b).withOpacity(0.2), 
                                        mainContainerWidth: 56, 
                                        containerWidth: 48, 
                                        containerHeight: 48, 
                                        imageHeight: 36, 
                                        imageWidth: 36, 
                                        containerBorderRadius: 8
                                      ),
                                    ],
                                  ),
                                );
                              }, 
                              pressType: PressType.singleClick,
                              verticalMargin: 10,
                              horizontalMargin: 10,
                              arrowColor: Colors.white,
                              barrierColor: Colors.black54,
                              showArrow: true,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(4),
                                height: 36,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: HexColor.fromHex(stateSetting.settingData.infoColor!).withOpacity(0.4)
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.support_agent_sharp,
                                      color: HexColor.fromHex(stateSetting.settingData.lightColor!),
                                      size: 24,
                                    ),
                                    const SizedBox(width: 4,),
                                    AutoSizeText("CS 24 JAM",
                                    maxLines: 1,
                                    maxFontSize: 10,
                                    minFontSize: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.openSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor.fromHex(stateSetting.settingData.lightColor!)
                                    ),)
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Sisa Saldo", style: GoogleFonts.openSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white
                        ),),
                        const SizedBox(height: 8,),
                        BlocBuilder<GetmeCubit, GetmeState>(
                          bloc: locator.get<GetmeCubit>(),
                          builder: (_, state) {
                            return Text(FormatCurrency.convertToIdr(state.data.data!.saldo!, 0), style: GoogleFonts.openSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.white
                            ),);
                          }
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<SettingApplikasiCubit, SettingApplikasiState>(
                    bloc: locator.get<SettingApplikasiCubit>(),
                    builder: (_, stateSetting) {
                      return Card(
                        surfaceTintColor: HexColor.fromHex(stateSetting.settingData.surfaceColor!),
                        color: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          width: 100.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SaldoActionComponent(
                                icon: Iconsax.empty_wallet_add5, 
                                label: "Top Up", 
                                onTapAction: () {
                                  context.pushNamed("topup-main");
                                }
                              ),
                              SaldoActionComponent(
                                icon: Iconsax.profile_2user5, 
                                label: "Daftar Agen", 
                                onTapAction: () {
                                  context.pushNamed("daftar-agen");
                                }
                              ),
                              SaldoActionComponent(
                                icon: Iconsax.coin_15, 
                                label: "Poin", 
                                onTapAction: () {
                                  context.pushNamed("reward-main");
                                }
                              ),
                              SaldoActionComponent(
                                icon: Iconsax.moneys5, 
                                label: "Komisi", 
                                onTapAction: () {
                                  context.pushNamed("komisi-main");
                                }
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                ),
                BlocBuilder<SettingApplikasiCubit, SettingApplikasiState>(
                  bloc: locator.get<SettingApplikasiCubit>(),
                  builder: (_, stateSetting) {
                    return Container(
                      width: 100.w,
                      height: 20,
                      alignment: Alignment.center,
                      color: HexColor.fromHex(stateSetting.settingData.indicatorColor!),
                      child: BlocBuilder<RunningTextCubit, RunningTextState>(
                        builder: (_, state) {
                          if(state.dataList.isNotEmpty) {
                            return Marquee(
                              text: state.dataList[state.currentIndex].text!,
                              style: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: HexColor.fromHex(stateSetting.settingData.mainColor1!)
                              ),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              blankSpace: 100.w,
                              velocity: 50,
                              startPadding: 100.w,
                              accelerationDuration: const Duration(seconds: 1),
                              accelerationCurve: Curves.linear,
                              decelerationDuration: const Duration(milliseconds: 500),
                              decelerationCurve: Curves.easeOut,
                              onDone: () {
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        } 
                      ),
                    );
                  }
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: BlocBuilder<SettingApplikasiCubit, SettingApplikasiState>(
                    bloc: locator.get<SettingApplikasiCubit>(),
                    builder: (_, settingState) {
                      return Card(
                        surfaceTintColor: HexColor.fromHex(settingState.settingData.surfaceColor!),
                        color: Colors.white,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          width: 100.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 6,),
                              BlocBuilder<FavoriteMenuCubit, FavoriteMenuState>(
                                builder: (_, state) {
                                  if(state.isLoading) {
                                    return const MainMenuShimmer(dataLength: 10);
                                  } else {
                                    return Wrap(
                                      alignment: WrapAlignment.start,
                                      spacing: 2.w,
                                      runSpacing: 12,
                                      children: [
                                        for(var i = 0; i < state.menuData.menulist!.length; i++) LayananComponent(
                                          mainContainerWidth: 16.w,
                                          containerWidth: 14.w,
                                          containerHeight: 14.w,
                                          imageWidth: 10.w,
                                          imageHeight: 10.w,
                                          imageUrl: "$baseUrlAuth/files/menu-mobile/image/${state.menuData.menulist![i].icon!}", 
                                          label: state.menuData.menulist![i].name!, 
                                          onTapAction: () {
                                            if(state.menuData.menulist![i].type! == "PULSA") {
                                              context.pushNamed("pulsa-and-data");
                                            }
                                            
                                            if(state.menuData.menulist![i].type! == "WEBVIEW") {
                                              context.pushNamed("web-view", extra: {
                                                "title": state.menuData.menulist![i].name,
                                                "operatorId": state.menuData.menulist![i].operatorid,
                                                "url": state.menuData.menulist![i].url
                                              });
                                            }
                                            
                                            if(state.menuData.menulist![i].type == "PLN") {
                                              context.pushNamed("pln-main");
                                            }
                                            
                                            if(state.menuData.menulist![i].type == "SINGLE PPOB") {
                                              context.pushNamed("check-before-transaction", extra: {
                                                "operatorName": state.menuData.menulist![i].name,
                                                "kodeproduk": state.menuData.menulist![i].operatorid
                                              });
                                            }
                                            
                                            if(state.menuData.menulist![i].type == "DOUBLE PPOB") {
                                              context.pushNamed("select-product-ppob", extra: {
                                                "operatorName": state.menuData.menulist![i].name,
                                                "operatorId": state.menuData.menulist![i].operatorid
                                              });
                                            }
                                            
                                            if(state.menuData.menulist![i].type == "TRIPLE PPOB") {
                                              context.pushNamed("select-operator-backoffice", extra: {
                                                "operatorName": state.menuData.menulist![i].name,
                                                "operatorId": state.menuData.menulist![i].operatorid
                                              });
                                            }

                                            if(state.menuData.menulist![i].type == "SINGLE PRODUCT") {
                                              context.pushNamed("select-product-transaction", extra: {
                                                "operatorName": state.menuData.menulist![i].name,
                                                "operatorId": state.menuData.menulist![i].operatorid
                                              });
                                            }
                                            
                                            if(state.menuData.menulist![i].type == "DOUBLE PRODUCT") {
                                              context.pushNamed("select-operator", extra: {
                                                "operatorName": state.menuData.menulist![i].operatorid
                                              });
                                            }
                                            
                                            if(state.menuData.menulist![i].type == "LAINNYA") {
                                              context.pushNamed("more");
                                            }
                                          }, 
                                          menuColor: HexColor.fromHex(state.menuData.menulist![i].containercolor!),
                                          containerBorderRadius: 12,
                                        )
                                      ],
                                    );
                                  }
                                }
                              ),
                              const SizedBox(height: 8,)
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                ),
                const HomeCarousel(),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: BlocBuilder<SettingApplikasiCubit, SettingApplikasiState>(
                    bloc: locator.get<SettingApplikasiCubit>(),
                    builder: (_, stateSetting) {
                      return Card(
                        surfaceTintColor: HexColor.fromHex(stateSetting.settingData.surfaceColor!),
                        color: Colors.white.withOpacity(1),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: 100.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Artikel Terkini", style: GoogleFonts.openSans(
                                    fontSize: 16,
                                    color: HexColor.fromHex(stateSetting.settingData.textColor!),
                                    fontWeight: FontWeight.w600
                                  ),),
                                  GestureDetector(
                                    onTap: () {
                                      context.pushNamed("artikel-main");
                                    },
                                    child: Text("See All", style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      color: HexColor.fromHex(stateSetting.settingData.infoColor!),
                                      fontWeight: FontWeight.w500
                                    ),),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8,),
                              SizedBox(
                                height: 180,
                                child: FutureBuilder<List<ArtikelData>>(
                                  future: locator.get<BackOfficeService>().findManyArtikelByKategoriAndCount("ADAMULTI", 5),
                                  builder: (context, snapshot) {
                                    if(snapshot.connectionState == ConnectionState.done) {
                                      return ArtikelComponent(artikelData: snapshot.data!, surfaceColor: HexColor.fromHex(stateSetting.settingData.surfaceColor!),);
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
