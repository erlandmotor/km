import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/product_item_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/product_response.dart";
import "package:adamulti_mobile_clone_new/services/product_service.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class SelectProductScreen extends StatelessWidget {

  const SelectProductScreen({ super.key, required this.operatorName, required this.operatorId });

  final String operatorName;
  final String operatorId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ContainerGradientBackground(
          child: Column(
            children: [
              CustomContainerAppBar(
                title: operatorName,
                height: 90,
              ),
              Expanded(
                child: Container(
                  decoration: kContainerLightDecoration,
                  child: FutureBuilder<ProductResponse>(
                    future: locator.get<ProductService>().getProductByOperator(
                      locator.get<UserAppidCubit>().state.userAppId.appId, 
                      operatorId
                    ),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done) {
                        if(snapshot.hasError) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              return ProductItemComponent(
                                operatorName: operatorName, 
                                operatorColor: kMainLightThemeColor, 
                                imageUrl: operatorName.contains("PDAM") ? snapshot.data!.data![index].imgurloperator! : snapshot.data!.data![index].imgurl!, 
                                title: operatorName,
                                productName: snapshot.data!.data![index].namaproduk!, 
                                onTap: () {
                                  context.pushNamed("check-before-transaction", extra: {
                                    "operatorName": snapshot.data!.data![index].namaoperator,
                                    "kodeproduk": snapshot.data!.data![index].kodeproduk
                                  });
                                },
                                price: snapshot.data!.data![index].hargajual!.toString(),
                                productCode: snapshot.data!.data![index].kodeproduk!,
                                description: snapshot.data!.data![index].keterangan!,
                              );
                            }, 
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 8,);
                            }, 
                            itemCount: snapshot.data!.data!.length
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}