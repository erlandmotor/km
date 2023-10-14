import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/operator_item_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/operator_response.dart";
import "package:adamulti_mobile_clone_new/services/product_service.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class SelectOperatorScreen extends StatefulWidget {

  const SelectOperatorScreen({ super.key, required this.operatorName });

  final String operatorName;

  @override
  State<SelectOperatorScreen> createState() => _PulsaSelectOperatorScreenState();
}

class _PulsaSelectOperatorScreenState extends State<SelectOperatorScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: ContainerGradientBackground(
          child: Column(
            children: [
              CustomContainerAppBar(title: widget.operatorName, height: 90,),
              Expanded(
                child: Container(
                  decoration: kContainerLightDecoration,
                  child: FutureBuilder<OperatorResponse>(
                    future: locator.get<ProductService>().getOperatorByBackoffice(widget.operatorName, locator.get<UserAppidCubit>().state.userAppId.appId),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done) {
                        if(snapshot.hasError) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemCount: snapshot.data!.data!.length,
                            itemBuilder: (context, index) {
                              return OperatorItemComponent(
                                operatorName: widget.operatorName, 
                                operatorColor: kMainLightThemeColor, 
                                imageUrl: snapshot.data!.data![index].imgurl!, 
                                title: snapshot.data!.data![index].namaoperator!, 
                                onTap: () {
                                  context.pushNamed("select-product-transaction", extra: {
                                    "operatorName": snapshot.data!.data![index].namaoperator!,
                                    "operatorId": snapshot.data!.data![index].idoperator.toString()
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
          ),
        ),
      ),
    );
  }
}