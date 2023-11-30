import "package:adamulti_mobile_clone_new/components/account_menu_section_component.dart";
import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/authenticated_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/getme_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:adamulti_mobile_clone_new/services/secure_storage.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";

class AccountScreen extends StatelessWidget {

  const AccountScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return ContainerGradientBackground(
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              Expanded(
                child: Container(
                  decoration: kContainerLightDecoration,
                )
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
                        backgroundColor: Colors.white,
                        radius: 36,
                        child: CircleAvatar(
                          radius: 34,
                          backgroundImage: 
                          locator.get<AuthService>().getCurrentSigningAccount()!.photoUrl == null ?
                          const AssetImage("assets/default-user.png") :
                          CachedNetworkImageProvider(
                            locator.get<AuthService>().getCurrentSigningAccount()!.photoUrl! 
                          ) as ImageProvider
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(locator.get<AuthService>().getCurrentSigningAccount()!.displayName!, style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                          ),),
                          const SizedBox(height: 6,),
                          Row(
                            children: [
                              const Icon(LineIcons.store, color: Colors.white, size: 18,),
                              const SizedBox(width: 6,),
                              Text(locator.get<AuthenticatedCubit>().state.authenticatedUser.nAMARESELLER!, style: GoogleFonts.inter(
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
                                  const CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Icon(LineIcons.users, color: Colors.white,),
                                  ),
                                  const SizedBox(height: 4,),
                                  Text("Downline", style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black
                                  ),),
                                  const SizedBox(height: 8,),
                                  Text(state.data.data!.jmldownline!.toString(), style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                  ),)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.yellow,
                                    child: Icon(LineIcons.coins, color: Colors.white,),
                                  ),
                                  const SizedBox(height: 4,),
                                  Text("Poin", style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black
                                  ),),
                                  const SizedBox(height: 8,),
                                  Text(state.data.data!.poin.toString(), style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                  ),)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.green,
                                    child: Icon(LineIcons.wavyMoneyBill, color: Colors.white,),
                                  ),
                                  const SizedBox(height: 4,),
                                  Text("Komisi", style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black
                                  ),),
                                  const SizedBox(height: 8,),
                                  Text(FormatCurrency.convertToIdr(state.data.data!.poin, 0), style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
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
                          AccountMenuSectionComponent(
                            icon: LineIcons.tags, 
                            label: "Daftar Harga",
                            iconColor: Colors.green, 
                            onTapAction: () {
                              context.pushNamed("price-list");
                            }
                          ),
                          const Divider(),
                          AccountMenuSectionComponent(
                            icon: LineIcons.users, 
                            label: "Daftar Agen",
                            iconColor: Colors.blue, 
                            onTapAction: () {
                              context.pushNamed("daftar-agen");
                            }
                          ),
                          const Divider(),
                          AccountMenuSectionComponent(
                            icon: LineIcons.bluetooth, 
                            label: "Connect Printer",
                            iconColor: const Color(0xff0a3b8c), 
                            onTapAction: () {
                              context.pushNamed("connect-printer");
                            }
                          ),
                          const Divider(),
                          AccountMenuSectionComponent(
                            icon: LineIcons.print, 
                            label: "Atur Struk",
                            iconColor: Colors.purple, 
                            onTapAction: () {
                              context.pushNamed("printer-setting");
                            }
                          ),
                          const Divider(),
                          AccountMenuSectionComponent(
                            icon: LineIcons.lockOpen, 
                            label: "Ganti Pin",
                            iconColor: const Color(0xff636e72), 
                            onTapAction: () {
                              context.pushNamed("change-pin");
                            }
                          ),
                          const Divider(),
                          AccountMenuSectionComponent(
                            icon: LineIcons.sitemap, 
                            label: "Kode Referral",
                            iconColor: const Color(0xff273c75), 
                            onTapAction: () {}
                          ),
                          const Divider(),
                          AccountMenuSectionComponent(
                            icon: LineIcons.userShield, 
                            label: "Privacy & Policy",
                            iconColor: const Color(0xff7d5fff), 
                            onTapAction: () {
                              context.pushNamed("privacy-policy");
                            }
                          ),
                          const Divider(),
                          AccountMenuSectionComponent(
                            icon: LineIcons.alternateSignOut, 
                            label: "Keluar",
                            iconColor: Colors.red, 
                            onTapAction: () {
                              locator.get<SecureStorageService>().deleteSecureData("jwt");
                              locator.get<AuthService>().logoutGoogleAccount();
                              context.goNamed("select-google-account");
                            }
                          ),
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