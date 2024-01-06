import "package:adamulti_mobile_clone_new/components/artikel_item_component.dart";
import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/artikel_data.dart";
import "package:adamulti_mobile_clone_new/services/backoffice_service.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class ArtikelMainScreen extends StatelessWidget {

  const ArtikelMainScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ContainerGradientBackground(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 80,
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
                  const CustomContainerAppBar(title: "Artikel", height: 80,),
                  Expanded(
                    child: FutureBuilder<List<ArtikelData>>(
                      future: locator.get<BackOfficeService>().findManyArtikel(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.done) {
                          return ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              return ArtikelItemComponent(
                                data: snapshot.data![index], 
                                onTapAction: () {
                                  context.pushNamed("artikel-detail", extra: {
                                    "artikelId": snapshot.data![index].id!
                                  });
                                }, 
                                containerColor: index % 2 == 0 ? Colors.blue : Colors.white
                              );
                            }, 
                            separatorBuilder: (context, snapshot) {
                              return const SizedBox(height: 6,);
                            }, 
                            itemCount: snapshot.data!.length
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}