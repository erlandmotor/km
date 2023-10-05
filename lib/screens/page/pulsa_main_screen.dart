import "package:adamulti_mobile_clone_new/components/category_item_component.dart";
import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/setting_kategori_response.dart";
import "package:adamulti_mobile_clone_new/services/backoffice_service.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class PulsaMainScreen extends StatefulWidget {

  const PulsaMainScreen({ super.key });

  @override
  State<PulsaMainScreen> createState() => _PulsaMainScreenState();
}

class _PulsaMainScreenState extends State<PulsaMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ContainerGradientBackground(
          child: Column(
            children: [
              const CustomContainerAppBar(title: "Pulsa dan Paket Data"),
              Expanded(
                child: Container(
                  decoration: kContainerLightDecoration,
                  child: FutureBuilder<List<SettingKategoriResponse>>(
                  future: locator.get<BackOfficeService>().getSettingKategoriByKategori("PULSA"),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done) {
                      if(snapshot.hasError) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.separated(
                          padding: const EdgeInsets.all(8),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return CategoryItemComponent(
                              categoryName: snapshot.data![index].title!, 
                              categoryColor: kMainLightThemeColor, 
                              imageUrl: "$baseUrlAuth/files/setting-kategori/image/${snapshot.data![index].image!}", 
                              title: snapshot.data![index].title!, 
                              onTap: () {
                                context.pushNamed("select-operator", extra: {
                                  "operatorName": snapshot.data![index].name!
                                });
                              }
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 8,);
                          },
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                  ),
                )
              )
            ],
          )
        ),
      )
    );
  }
}