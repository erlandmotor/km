import "package:adamulti_mobile_clone_new/components/check_identity_container.dart";
import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/product_item_component.dart";
import "package:adamulti_mobile_clone_new/components/show_loading_submit.dart";
import 'package:adamulti_mobile_clone_new/components/transaction_without_identity_form_component.dart';
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/check_identity_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/product_response.dart";
import "package:adamulti_mobile_clone_new/services/local_notification_service.dart";
import "package:adamulti_mobile_clone_new/services/product_service.dart";
import "package:adamulti_mobile_clone_new/services/transaction_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:line_icons/line_icons.dart";

class PlnTokenScreen extends StatefulWidget {
  const PlnTokenScreen({ super.key, required this.operatorId, required this.operatorName,
  required this.kodeProduk });

  final String operatorId;
  final String operatorName;
  final String kodeProduk;

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
    final checkIdentityCubit = context.read<CheckIdentityCubit>();
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
          child: ContainerGradientBackground(
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
                Column(
                  children: [
                    CustomContainerAppBar(
                      title: widget.operatorName,
                      height: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CheckIdentityContainer(
                        identityController: identityController,
                        onCheck: () {
                          checkIdentityCubit.updateState(true, checkIdentityCubit.state.result);
                          final generatedIdTrxCheck = generateRandomString(8);
                          locator.get<TransactionService>().checkIdentity(
                            generatedIdTrxCheck,
                            widget.kodeProduk, 
                            identityController.text, 
                            "5", 
                            locator.get<UserAppidCubit>().state.userAppId.appId
                          ).then((value) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            checkIdentityCubit.updateState(false, value);
                          }).catchError((e) {
                            checkIdentityCubit.updateState(false, checkIdentityCubit.state.result);
                            showDynamicSnackBar(
                              context, 
                              LineIcons.exclamationTriangle, 
                              "ERROR", 
                              e.toString(), 
                              Colors.red
                            );
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
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
                                  itemBuilder: (context, index) {
                                    return ProductItemComponent(
                                      operatorName: widget.operatorName, 
                                      operatorColor: kMainLightThemeColor, 
                                      imageUrl: snapshot.data!.data![index].imgurloperator!, 
                                      title: widget.operatorName,
                                      productName: snapshot.data!.data![index].namaproduk!, 
                                      onTap: () {
                                        if(identityController.text.isEmpty) {
                                          showDynamicSnackBar(
                                            context, 
                                            LineIcons.exclamationTriangle, 
                                            "ERROR", 
                                            "ID Pelanggan harus diisi terlebih dahulu.", 
                                            Colors.red
                                          );
                                        } else {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(18),
                                                topRight: Radius.circular(18)
                                              )
                                            ),  
                                            builder: (context) {
                                              return TransactionWithoutIdentityFormComponent( 
                                                identityNumber: identityController.text,
                                                operatorName: snapshot.data!.data![index].namaoperator!,
                                                productName: snapshot.data!.data![index].namaproduk!,
                                                productPrice: snapshot.data!.data![index].hargajual!,
                                                onSubmit: (pin) {
                                                  showLoadingSubmit(context, "Proses Transaksi...");

                                                  final generatedIdTrx = generateRandomString(8);
          
                                                  locator.get<TransactionService>().payNow(
                                                    generatedIdTrx,
                                                    snapshot.data!.data![index].kodeproduk!, 
                                                    identityController.text, 
                                                    pin,
                                                    "0", 
                                                    locator.get<UserAppidCubit>().state.userAppId.appId
                                                  ).then((value) {
                                                    if(value.success!) {
                                                      identityController.clear();
                                                      context.pop();
                                                      locator.get<LocalNotificationService>().showLocalNotification(
                                                        title: "Transaksi ${snapshot.data!.data![index].namaproduk}", 
                                                        body: "Transaksi ${snapshot.data!.data![index].namaproduk} berhasil dilakukan."
                                                      );

                                                      locator.get<TransactionService>().findLastTransaction(generatedIdTrx).then((trx) {
                                                        context.pushNamed("transaction-detail", extra: {
                                                          'idtrx': trx.idtransaksi!,
                                                          'type': 'TRANSAKSI',
                                                          'total': trx.hARGAJUAL
                                                        });
                                                      }).catchError((e) {
                                                        showDynamicSnackBar(
                                                          context, 
                                                          LineIcons.exclamationTriangle, 
                                                          "ERROR", 
                                                          e.toString(), 
                                                          Colors.red
                                                        );
                                                      });
                                                    } else {
                                                      locator.get<LocalNotificationService>().showLocalNotification(title: "Transaksi ${snapshot.data!.data![index].namaproduk}", 
                                                      body: value.msg!);
                                                      context.pop();
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
                                        }
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
              ],
            )
          ),
        ),
      ),
    );
  }
}