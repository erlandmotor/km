import "package:adamulti_mobile_clone_new/components/account_menu_section_component.dart";
import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/authenticated_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/getme_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/google_account_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:adamulti_mobile_clone_new/services/secure_storage.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";


class AccountScreen extends StatelessWidget {

  const AccountScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return ContainerGradientBackground(
      child: Stack(
        children: [
          const Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Expanded(
                child: LightDecorationContainerComponent()
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: BlocBuilder<GoogleAccountCubit, GoogleAccountState>(
                          bloc: locator.get<GoogleAccountCubit>(),
                          builder: (_, state) {
                            if(state.userData == null) {
                              return BlocBuilder<SettingApplikasiCubit, SettingApplikasiState>(
                                bloc: locator.get<SettingApplikasiCubit>(),
                                builder: (_, stateSetting) {
                                  return CircleAvatar(
                                    radius: 26,
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
                                      radius: 26,
                                      backgroundColor: HexColor.fromHex(stateSetting.settingData.infoColor!),
                                      child: const Icon(Iconsax.user, color: Colors.white,),
                                    );
                                  }
                                );
                              } else {
                                return CircleAvatar(
                                  radius: 26,
                                  backgroundImage: CachedNetworkImageProvider(
                                    state.userData!.photoUrl! 
                                  ),
                                );
                              }
                            }
                          },
                        )
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(locator.get<AuthService>().getCurrentSigningAccount()!.displayName!, style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                            ),),
                            const SizedBox(height: 6,),
                            Row(
                              children: [
                                const Icon(Iconsax.mobile, color: Colors.white, size: 18,),
                                const SizedBox(width: 6,),
                                Text(locator.get<AuthenticatedCubit>().state.authenticatedUser.telp!, style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white
                                ),)
                              ],
                            ),
                            const SizedBox(height: 6,)
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Card(
                    surfaceTintColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.surfaceColor!),
                    color: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      child: BlocBuilder<GetmeCubit, GetmeState>(
                        bloc: locator.get<GetmeCubit>(),
                        builder: (_, state) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(Iconsax.shop5, color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!),),
                                        const SizedBox(width: 4,),
                                        AutoSizeText(locator.get<GetmeCubit>().state.data.data!.nama!, 
                                        minFontSize: 2,
                                        maxFontSize: 14,
                                        maxLines: 1,
                                        style: GoogleFonts.openSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                        ),),
                                      ],
                                    ),
                                  ),
                                  Text(locator.get<GetmeCubit>().state.data.data!.idreseller!, style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                  ),),
                                ],
                              ),
                              const SizedBox(height: 6,),
                              const Divider(),
                              const SizedBox(height: 6,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.pushNamed("daftar-agen");
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.profile_2user5, color: Colors.blue, size: 32,),
                                        const SizedBox(width: 6,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Downline", style: GoogleFonts.openSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                            ),),
                                            const SizedBox(height: 2,),
                                            Text(state.data.data!.jmldownline!.toString(), style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                            ),)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.pushNamed("reward-main");
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.coin_15, color: Colors.orange, size: 32,),
                                        const SizedBox(width: 6,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Poin", style: GoogleFonts.openSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                            ),),
                                            const SizedBox(height: 2,),
                                            Text(state.data.data!.poin.toString(), style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                            ),)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.pushNamed("komisi-main");
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.moneys5, color: Colors.green, size: 32,),
                                        const SizedBox(width: 6,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Komisi", style: GoogleFonts.openSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                            ),),
                                            const SizedBox(height: 2,),
                                            AutoSizeText(FormatCurrency.convertToIdr(state.data.data!.komisi, 0), 
                                            maxLines: 1,
                                            minFontSize: 2,
                                            maxFontSize: 14,
                                            style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                            ),)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      )
                    ),
                  ),
                  const SizedBox(height: 18,),
                  Card(
                    surfaceTintColor: Colors.white,
                    color: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.pushNamed("price-list");
                            },
                            child: const AccountMenuSectionComponent(
                              icon: Iconsax.tag, 
                              label: "Daftar Harga",
                              iconColor: Colors.green, 
                            ),
                          ),
                          const Divider(),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed("daftar-agen");
                            },
                            child: const AccountMenuSectionComponent(
                              icon: Iconsax.profile_2user, 
                              label: "Daftar Agen",
                              iconColor: Colors.blue, 
                            )
                          ),
                          const Divider(),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed("connect-printer");
                            },
                            child: const AccountMenuSectionComponent(
                              icon: Iconsax.bluetooth, 
                              label: "Connect Printer",
                              iconColor: Color(0xff0a3b8c), 
                            ),
                          ),
                          const Divider(),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed("printer-setting");
                            },
                            child: const AccountMenuSectionComponent(
                              icon: Iconsax.printer, 
                              label: "Atur Struk",
                              iconColor: Colors.purple,
                            ),
                          ),
                          const Divider(),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed("change-pin");
                            },
                            child: const AccountMenuSectionComponent(
                              icon: Iconsax.unlock, 
                              label: "Ganti Pin",
                              iconColor: Color(0xff636e72),
                            ),
                          ),
                          const Divider(),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed("privacy-policy");
                            },
                            child: const AccountMenuSectionComponent(
                              icon: Iconsax.security_user, 
                              label: "Privacy & Policy",
                              iconColor: Color(0xff7d5fff), 
                            ),
                          ),
                          const Divider(),
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.android_outlined, color: Colors.lightGreen, size: 28,),
                                const SizedBox(width: 18,),
                                Text("Build Version 1.0", style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),
                          ),
                          const Divider(),
                          GestureDetector(
                            onTap: () {
                              showCupertinoDialog(
                                context: context,
                                barrierDismissible: false, 
                                builder: (_) {
                                  return AlertDialog(
                                    surfaceTintColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.surfaceColor!),
                                    backgroundColor: Colors.white,
                                    title: Text("Apakah Anda Yakin Ingin Keluar dari Applikasi?", style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                    ),),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          locator.get<SecureStorageService>().deleteSecureData("jwt");
                                          locator.get<AuthService>().logoutGoogleAccount();
                                          context.goNamed("select-google-account");
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                        ), 
                                        child: Text("Keluar", style: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white
                                        ),)
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          context.pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!)
                                        ), 
                                        child: Text("Batal", style: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white
                                        ),)
                                      ),
                                    ],
                                  );
                                }
                              );
                            },
                            child: const AccountMenuSectionComponent(
                              icon: Iconsax.logout, 
                              label: "Keluar",
                              iconColor: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}