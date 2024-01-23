import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/artikel_data.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";

class ArtikelComponent extends StatelessWidget {

  const ArtikelComponent({ super.key, required this.artikelData });

  final List<ArtikelData> artikelData;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.pushNamed("artikel-detail", extra: {
              "artikelId": artikelData[index].id!
            });
          },
          child: Card(
            surfaceTintColor: Colors.white,
            elevation: 0,
            color: Colors.white,
            child: SizedBox(
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                    child: CachedNetworkImage(
                      imageUrl: "$baseUrlAuth/files/berita/image/${artikelData[index].coverImage!}",
                      width: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 6,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(artikelData[index].title!, 
                          maxLines: 2,
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                          ),),
                          BlocBuilder<SettingApplikasiCubit, SettingApplikasiState>(
                            bloc: locator.get<SettingApplikasiCubit>(),
                            builder: (_, state) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(140, 15),
                                  backgroundColor: HexColor.fromHex(state.settingData.secondaryColor!)
                                ),
                                onPressed: () {
                                  context.pushNamed("artikel-detail", extra: {
                                    "artikelId": artikelData[index].id!
                                  });
                                }, 
                                child: Text("Selengkapnya", style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                                ),)
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }, 
      separatorBuilder: (context, index) {
        return const SizedBox(width: 8,);
      }, 
      itemCount: artikelData.length
    );
  }
}