import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/product_item_component.dart";
import "package:adamulti_mobile_clone_new/components/show_loading_submit.dart";
import "package:adamulti_mobile_clone_new/components/transaction_form_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/product_response.dart";
import "package:adamulti_mobile_clone_new/services/product_service.dart";
import "package:adamulti_mobile_clone_new/services/transaction_service.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:line_icons/line_icons.dart";
import "package:adamulti_mobile_clone_new/services/local_notification_service.dart";

class SelectProductTransactionScreen extends StatefulWidget {

  const SelectProductTransactionScreen({ super.key, required this.operatorName, required this.operatorId });

  final String operatorName;
  final String operatorId;

  @override
  State<SelectProductTransactionScreen> createState() => _SelectProductTransactionScreenState();
}

class _SelectProductTransactionScreenState extends State<SelectProductTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ContainerGradientBackground(
          child: Column(
            children: [
              CustomContainerAppBar(
                title: widget.operatorName,
                height: 90,
              ),
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
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(18),
                                        topRight: Radius.circular(18)
                                      )
                                    ), 
                                    builder:(context) {
                                      return TransactionFormComponent(
                                        operatorName: snapshot.data!.data![index].namaoperator!, 
                                        productName: snapshot.data!.data![index].namaproduk!, 
                                        productPrice: snapshot.data!.data![index].hargajual!, 
                                        onSubmit: (tujuan, pin) {
                                          showLoadingSubmit(context, "Proses Transaksi...");

                                          locator.get<TransactionService>().payNow(
                                            snapshot.data!.data![index].kodeproduk!, 
                                            tujuan, 
                                            pin, 
                                            "0",
                                            locator.get<UserAppidCubit>().state.userAppId.appId
                                          ).then((value) {
                                            if(value.success!) {
                                              context.pop();
                                              context.pop();
                                              // showDynamicSnackBar(
                                              //   context, 
                                              //   LineIcons.infoCircle, 
                                              //   "SUKSES", 
                                              //   "Transaksi ${snapshot.data!.data![index].namaproduk} berhasil dilakukan.", 
                                              //   Colors.lightBlue
                                              // );
                                              locator.get<LocalNotificationService>().showLocalNotification(
                                                title: "Transaksi ${snapshot.data!.data![index].namaproduk}", 
                                                body: "Transaksi ${snapshot.data!.data![index].namaproduk} berhasil dilakukan."
                                              );
                                            } else {
                                              locator.get<LocalNotificationService>().showLocalNotification(
                                                title: "Transaksi ${snapshot.data!.data![index].namaproduk}", 
                                                body: value.msg!
                                              );
                                              context.pop();
                                              // showDynamicSnackBar(
                                              //   context, 
                                              //   LineIcons.exclamationTriangle, 
                                              //   "ERROR", 
                                              //   value.msg!, 
                                              //   Colors.red
                                              // );
                                            }
                                          }).catchError((e) {
                                            context.pop();
                                            context.pop();

                                            showDynamicSnackBar(
                                              context, 
                                              LineIcons.exclamationTriangle, 
                                              "ERROR", 
                                              e.toString(), 
                                              Colors.red
                                            );
                                          });
                                        }
                                      );
                                    }
                                  );
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