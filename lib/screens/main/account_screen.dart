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
import "package:cached_network_image/cached_network_image.dart";
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
                height: 120,
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
                        radius: 32,
                        backgroundColor: Colors.white,
                        child: BlocBuilder<GoogleAccountCubit, GoogleAccountState>(
                          bloc: locator.get<GoogleAccountCubit>(),
                          builder: (_, state) {
                            if(state.userData == null) {
                              return BlocBuilder<SettingApplikasiCubit, SettingApplikasiState>(
                                bloc: locator.get<SettingApplikasiCubit>(),
                                builder: (_, stateSetting) {
                                  return CircleAvatar(
                                    radius: 30,
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
                                      radius: 30,
                                      backgroundColor: HexColor.fromHex(stateSetting.settingData.infoColor!),
                                      child: const Icon(Iconsax.user, color: Colors.white,),
                                    );
                                  }
                                );
                              } else {
                                return CircleAvatar(
                                  radius: 30,
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
                      Column(
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
                              const Icon(Iconsax.shop, color: Colors.white, size: 18,),
                              const SizedBox(width: 6,),
                              Text(locator.get<AuthenticatedCubit>().state.authenticatedUser.nAMARESELLER!, style: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white
                              ),)
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Card(
                    surfaceTintColor: Colors.blue,
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      child: BlocBuilder<GetmeCubit, GetmeState>(
                        bloc: locator.get<GetmeCubit>(),
                        builder: (_, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.blue.withOpacity(0.2),
                                    child: const Icon(Iconsax.profile_2user, color: Colors.blue,),
                                  ),
                                  const SizedBox(height: 4,),
                                  Text("Downline", style: GoogleFonts.openSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                  ),),
                                  const SizedBox(height: 8,),
                                  Text(state.data.data!.jmldownline!.toString(), style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                  ),)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.yellow.withOpacity(0.2),
                                    child: const Icon(Iconsax.coin_1, color: Colors.orange,),
                                  ),
                                  const SizedBox(height: 4,),
                                  Text("Poin", style: GoogleFonts.openSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                  ),),
                                  const SizedBox(height: 8,),
                                  Text(state.data.data!.poin.toString(), style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                  ),)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.green.withOpacity(0.2),
                                    child: const Icon(Iconsax.money_tick, color: Colors.green,),
                                  ),
                                  const SizedBox(height: 4,),
                                  Text("Komisi", style: GoogleFonts.openSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                  ),),
                                  const SizedBox(height: 8,),
                                  Text(FormatCurrency.convertToIdr(state.data.data!.poin, 0), style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                  ),)
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
                          GestureDetector(
                            onTap: () {
                              locator.get<SecureStorageService>().deleteSecureData("jwt");
                              locator.get<AuthService>().logoutGoogleAccount();
                              context.goNamed("select-google-account");
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