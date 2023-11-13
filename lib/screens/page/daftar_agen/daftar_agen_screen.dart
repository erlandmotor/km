import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/no_data_component.dart";
import "package:adamulti_mobile_clone_new/components/search_textfield_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/downline_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class DaftarAgenScreen extends StatefulWidget {

  const DaftarAgenScreen({ super.key });

  @override
  State<DaftarAgenScreen> createState() => _DaftarAgenScreenState();
}

class _DaftarAgenScreenState extends State<DaftarAgenScreen> {
  final searchControl = TextEditingController();

  var currentPage = 1;

  @override
  void dispose() {
    searchControl.dispose();
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
                  const CustomContainerAppBar(title: "Daftar Agen", height: 80,),
                  Card(
                    surfaceTintColor: Colors.blue,
                    child: Container(
                      width: 96.w,
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SearchTextfieldComponent(
                            label: "Cari Agen", 
                            hint: "Masukkan Nama Agen", 
                            controller: searchControl, 
                            onChanged: (String term) {

                            }
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  BlocBuilder<DownlineCubit, DownlineState>(
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
                            padding: const EdgeInsets.all(18),
                            itemBuilder: (context, index) {
                              return Card(
                                surfaceTintColor: Colors.blue,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
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
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Saldo : ${FormatCurrency.convertToIdr(state.dataList[index].saldo!, 0)} | Mark Up : ${FormatCurrency.convertToIdr(state.dataList[index].tambahanhargapribadi!, 0)}"
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(LineIcons.verticalEllipsis, color: Colors.black,),
                                      onPressed: () {},
                                    ),
                                  )
                                ),
                              );
                            }, 
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 6,);
                            }, 
                            itemCount: state.dataList.length
                          );
                        }
                      }
                    }
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