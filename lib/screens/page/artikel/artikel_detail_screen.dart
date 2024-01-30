import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/artikel_data.dart";
import "package:adamulti_mobile_clone_new/services/backoffice_service.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:flutter_html/flutter_html.dart";
import "package:iconsax/iconsax.dart";
import "package:url_launcher/url_launcher.dart";

class ArtikelDetailScreen extends StatelessWidget {

  const ArtikelDetailScreen({ super.key, required this.artikelId });

  final int artikelId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ArtikelData>(
        future: locator.get<BackOfficeService>().findUniqueArtikel(artikelId),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: IconButton(
                    icon: const Icon(
                      Iconsax.arrow_circle_left,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor1!),
                  systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor1!),
                  systemNavigationBarColor: Colors.white,
                  statusBarBrightness: Brightness.dark,
                  statusBarIconBrightness: Brightness.light,
                  systemNavigationBarIconBrightness: Brightness.light,
                  systemNavigationBarDividerColor: Colors.white),
                  pinned: true,
                  expandedHeight: 160,
                  collapsedHeight: 60,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    titlePadding: const EdgeInsets.only(bottom: 22, left: 18),
                    // title: Row(
                    //   children: [
                    //     const SizedBox(width: 38,),
                    //     Expanded(
                    //       child: ,
                    //     ),
                    //   ],
                    // ),
                    background: CachedNetworkImage(
                      imageUrl: "$baseUrlAuth/files/berita/image/${snapshot.data!.coverImage!}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 1,
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Html(
                                data: """
                                ${snapshot.data!.content!}
                                """,
                                onLinkTap: (url, attributes, element) {
                                  if(url != null) {
                                    final parsedUrl = Uri.parse(url);
                                    launchUrl(parsedUrl);
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  )
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } 
        },
      )
    );
  }
}