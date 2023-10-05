import "package:adamulti_mobile_clone_new/components/check_identity_container.dart";
import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/custom_regular_appbar.dart";
import "package:adamulti_mobile_clone_new/components/product_item_component.dart";
import "package:adamulti_mobile_clone_new/components/regular_textfield_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/product_response.dart";
import "package:adamulti_mobile_clone_new/services/product_service.dart";
import "package:flutter/material.dart";
import "package:line_icons/line_icons.dart";

class PlnTokenScreen extends StatefulWidget {
  const PlnTokenScreen({ super.key, required this.operatorId, required this.operatorName });

  final String operatorId;
  final String operatorName;

  @override
  State<PlnTokenScreen> createState() => _PlnTokenScreenState();
}

class _PlnTokenScreenState extends State<PlnTokenScreen> {
  final identityController = TextEditingController();

  @override
  void dispose() {
    identityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ContainerGradientBackground(
          child: Column(
            children: [
              CustomContainerAppBar(
                title: widget.operatorName,
              ),
              const CheckIdentityContainer(),
              const SizedBox(height: 8,),
              Expanded(
                child: Container(
                  decoration: kContainerLightDecoration,
                  child: FutureBuilder<ProductResponse>(
                    future: locator.get<ProductService>().getProductByOperator(
                      locator.get<UserAppidCubit>().state.userAppId.appId, 
                      widget.operatorId
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
                                operatorName: widget.operatorName, 
                                operatorColor: kMainLightThemeColor, 
                                imageUrl: snapshot.data!.data![index].imgurloperator!, 
                                title: widget.operatorName,
                                productName: snapshot.data!.data![index].namaproduk!, 
                                onTap: () {
                                  
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