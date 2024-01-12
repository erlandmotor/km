import "package:adamulti_mobile_clone_new/components/detail_transaksi_item_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/transaction_detail_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/parsed_cetak_response.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class ReceiptContainerComponent extends StatelessWidget {

  const ReceiptContainerComponent({ super.key, required this.data, required this.idtrx, required this.printWidget });

  final ParsedCetakResponse data;
  final String idtrx;
  final Widget printWidget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        height: 80.h,
        width: 100.w,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100.w,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 96,
                      height: 96,
                      child: CachedNetworkImage(
                      imageUrl: "$baseUrlFile/setting-applikasi/image/${locator.get<SettingApplikasiCubit>().state.settingData.logoMain!}",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12,),
                    Text("Transaksi Berhasil", style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.black
                    ),),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                      width: 10,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                          color: Colors.grey.shade200
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LayoutBuilder(builder: (context,constraints){
                          return Flex(
                            direction: Axis.horizontal,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate((constraints.constrainWidth()/10).floor(), (index) =>
                                SizedBox(height: 1.5,width: 5,child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey.shade400),),)
                            ),
                          );
                        },),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: 10,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                            color: Colors.grey.shade200
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 18,),
                    DetailTransaksiItemComponent(
                      title: "Tanggal", 
                      value: data.waktu!
                    ),
                    if(data.idtrx != null)
                    DetailTransaksiItemComponent(title: "ID Transaksi", value: data.idtrx!),
                    if(data.rekening != null)
                    DetailTransaksiItemComponent(title: "Rekening", value: data.rekening!),
                    if(data.noTujuan != null)
                    DetailTransaksiItemComponent(title: "No. Tujuan", value: data.noTujuan!),
                    if(data.idpel != null)
                    DetailTransaksiItemComponent(
                      title: data.type! == "149" ? "KODE.VA" : "ID Pelanggan", 
                      value: data.idpel!
                    ),
                    if(data.nama != null)
                    DetailTransaksiItemComponent(title: "Nama", value: data.nama!),
                    if(data.produk != null)
                    DetailTransaksiItemComponent(title: "Produk", value: data.produk!),
                    if(data.noMeter != null)
                    DetailTransaksiItemComponent(title: "No. Meter", value: data.noMeter!),
                    if(data.akun != null)
                    DetailTransaksiItemComponent(title: "Akun", value: data.akun!),
                    if(data.namaBank != null)
                    DetailTransaksiItemComponent(title: "Nama Bank", value: data.namaBank!),
                    if(data.sn != null)
                    DetailTransaksiItemComponent(title: "SN", value: data.sn!),
                    if(data.td != null)
                    DetailTransaksiItemComponent(title: "TD", value: data.td!),
                    if(data.ecommerce != null)
                    DetailTransaksiItemComponent(title: "Ecommerce", value: data.ecommerce!),
                    if(data.tarifDaya != null)
                    DetailTransaksiItemComponent(title: "Tarif Daya", value: data.tarifDaya!),
                    if(data.kodeBank != null)
                    DetailTransaksiItemComponent(title: "Kode Bank", value: data.kodeBank!),
                    if(data.kwh != null)
                    DetailTransaksiItemComponent(title: "KWH", value: data.kwh!),
                    if(data.standMeter != null)
                    DetailTransaksiItemComponent(title: "Stand Meter", value: data.standMeter!),
                    if(data.nominal != null)
                    DetailTransaksiItemComponent(title: "Nominal", value: FormatCurrency.convertToIdr(int.parse(data.nominal!), 0)),
                    if(data.blnTag != null)
                    DetailTransaksiItemComponent(title: "JML Bulan", value: data.blnTag!),
                    if(data.blnThn != null)
                    DetailTransaksiItemComponent(title: "BLN/THN", value: data.blnThn!),
                    if(data.jmlPeserta != null)
                    DetailTransaksiItemComponent(title: "JML. Peserta", value: data.jmlPeserta!),
                    if(data.adminBank != null)
                    DetailTransaksiItemComponent(title: "ADMIN", value: FormatCurrency.convertToIdr(int.parse(data.adminBank!), 0)),
                    if(data.jumlahTag != null)
                    DetailTransaksiItemComponent(title: "JML. TAG", value: data.jumlahTag!),
                    if(data.tarif != null)
                    DetailTransaksiItemComponent(title: "Tarif", value: FormatCurrency.convertToIdr(int.parse(data.tarif!), 0)),
                    if(data.angsuranKe != null)
                    DetailTransaksiItemComponent(title: "Angsuran Ke", value: data.angsuranKe!),
                    if(data.jatuhTempo != null)
                    DetailTransaksiItemComponent(title: "Jatuh Tempo", value: data.jatuhTempo!),
                    if(data.denda != null)
                    DetailTransaksiItemComponent(title: "Denda", value: FormatCurrency.convertToIdr(int.parse(data.denda!), 0)),
                    if(data.noReff != null)
                    DetailTransaksiItemComponent(title: "No. Reff", value: data.noReff!),
                    if(data.token != null)
                    Column(
                      children: [
                        const SizedBox(height: 8,),
                        Container(
                          width: 100.w,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightColor!)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("No. Token : ", style: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!)
                              ),),
                              const SizedBox(height: 6,),
                              Text(
                                data.token!,
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor1!)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                      width: 10,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                          color: Colors.grey.shade200
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LayoutBuilder(builder: (context,constraints){
                          return Flex(
                            direction: Axis.horizontal,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate((constraints.constrainWidth()/10).floor(), (index) =>
                                SizedBox(height: 1.5,width: 5,child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey.shade400),),)
                            ),
                          );
                        },),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: 10,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                            color: Colors.grey.shade200
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left:16,right:16,bottom: 12),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total", style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                        ),),
                        BlocBuilder<TransactionDetailCubit, TransactionDetailState>(
                          builder: (_, state) {
                            return Text(state.totalReceipt, style: GoogleFonts.openSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!)
                            ),);
                          }
                        )
                      ],
                    ),
                    const SizedBox(height: 18,),
                    printWidget,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}