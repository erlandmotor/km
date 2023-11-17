import "package:adamulti_mobile_clone_new/components/curve_clipper.dart";
import "package:adamulti_mobile_clone_new/components/dashed_separator.dart";
import "package:adamulti_mobile_clone_new/components/detail_transaksi_item_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import 'package:adamulti_mobile_clone_new/components/dynamic_size_button_outlined_icon_component.dart';
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/parsed_cetak_response.dart";
import "package:adamulti_mobile_clone_new/services/transaction_service.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class TransactionDetailScreen extends StatelessWidget {

  const TransactionDetailScreen({ super.key, required this.idtrx, required this.type,
  required this.date, required this.total });

  final String idtrx;
  final String type;
  final String date;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ClipPath(
              clipper: CurveClipper(),
              child: Container(
                width: 100.w,
                height: 40.h,
                color: kMainThemeColor,
              ),
            ), 
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: kWhiteBlueColor.withOpacity(0.2),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: kWhiteBlueColor.withOpacity(0.6),
                      child: const CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.check_sharp, color: kMainThemeColor, size: 32,),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18,),
                  Text(type == "HISTORY" ? "Riwayat Transaksi" : "Transaksi Berhasil", style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  ),),
                  const SizedBox(height: 4,),
                  Text(date, style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white
                  ),),
                  const SizedBox(height: 18,),
                  Expanded(
                    child: Card(
                      surfaceTintColor: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: 100.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Total Transaksi", style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: kSecondaryTextColor
                            ),),
                            const SizedBox(height: 4,),
                            Text(FormatCurrency.convertToIdr(total, 0), style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: kMainLightThemeColor
                            ),),
                            const SizedBox(height: 18,),
                            const DashedSeparator(),
                            const SizedBox(height: 18),
                            Text("Detail Transaksi", style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kSecondaryTextColor
                            ),),
                            const SizedBox(height: 18,),
                            Expanded(
                              child: FutureBuilder<ParsedCetakResponse>(
                                future: locator.get<TransactionService>().parseCetak(idtrx),
                                builder: (context, snapshot) {
                                  if(snapshot.connectionState == ConnectionState.done) {
                                    return Column(
                                      children: [
                                        if(snapshot.data!.idtrx != null)
                                        DetailTransaksiItemComponent(title: "ID Transaksi", value: snapshot.data!.idtrx!),
                                        if(snapshot.data!.rekening != null)
                                        DetailTransaksiItemComponent(title: "Rekening", value: snapshot.data!.rekening!),
                                        if(snapshot.data!.noTujuan != null)
                                        DetailTransaksiItemComponent(title: "No. Tujuan", value: snapshot.data!.noTujuan!),
                                        if(snapshot.data!.idpel != null)
                                        DetailTransaksiItemComponent(
                                          title: snapshot.data!.type! == "149" ? "KODE.VA" : "ID Pelanggan", 
                                          value: snapshot.data!.idtrx!
                                        ),
                                        if(snapshot.data!.nama != null)
                                        DetailTransaksiItemComponent(title: "Nama", value: snapshot.data!.nama!),
                                        if(snapshot.data!.produk != null)
                                        DetailTransaksiItemComponent(title: "Produk", value: snapshot.data!.produk!),
                                        if(snapshot.data!.noMeter != null)
                                        DetailTransaksiItemComponent(title: "No. Meter", value: snapshot.data!.noMeter!),
                                        if(snapshot.data!.akun != null)
                                        DetailTransaksiItemComponent(title: "Akun", value: snapshot.data!.akun!),
                                        if(snapshot.data!.namaBank != null)
                                        DetailTransaksiItemComponent(title: "Nama Bank", value: snapshot.data!.namaBank!),
                                        if(snapshot.data!.sn != null)
                                        DetailTransaksiItemComponent(title: "SN", value: snapshot.data!.sn!),
                                        if(snapshot.data!.td != null)
                                        DetailTransaksiItemComponent(title: "TD", value: snapshot.data!.td!),
                                        if(snapshot.data!.ecommerce != null)
                                        DetailTransaksiItemComponent(title: "Ecommerce", value: snapshot.data!.ecommerce!),
                                        if(snapshot.data!.tarifDaya != null)
                                        DetailTransaksiItemComponent(title: "Tarif Daya", value: snapshot.data!.tarifDaya!),
                                        if(snapshot.data!.kodeBank != null)
                                        DetailTransaksiItemComponent(title: "Kode Bank", value: snapshot.data!.kodeBank!),
                                        if(snapshot.data!.kwh != null)
                                        DetailTransaksiItemComponent(title: "KWH", value: snapshot.data!.kwh!),
                                        if(snapshot.data!.standMeter != null)
                                        DetailTransaksiItemComponent(title: "Stand Meter", value: snapshot.data!.standMeter!),
                                        if(snapshot.data!.nominal != null)
                                        DetailTransaksiItemComponent(title: "Nominal", value: FormatCurrency.convertToIdr(int.parse(snapshot.data!.nominal!), 0)),
                                        if(snapshot.data!.blnTag != null)
                                        DetailTransaksiItemComponent(title: "JML Bulan", value: snapshot.data!.blnTag!),
                                        if(snapshot.data!.blnThn != null)
                                        DetailTransaksiItemComponent(title: "BLN/THN", value: snapshot.data!.blnThn!),
                                        if(snapshot.data!.jmlPeserta != null)
                                        DetailTransaksiItemComponent(title: "JML. Peserta", value: snapshot.data!.jmlPeserta!),
                                        if(snapshot.data!.adminBank != null)
                                        DetailTransaksiItemComponent(title: "ADMIN", value: FormatCurrency.convertToIdr(int.parse(snapshot.data!.adminBank!), 0)),
                                        if(snapshot.data!.jumlahTag != null)
                                        DetailTransaksiItemComponent(title: "JML. TAG", value: snapshot.data!.jumlahTag!),
                                        if(snapshot.data!.tarif != null)
                                        DetailTransaksiItemComponent(title: "Tarif", value: FormatCurrency.convertToIdr(int.parse(snapshot.data!.tarif!), 0)),
                                        if(snapshot.data!.angsuranKe != null)
                                        DetailTransaksiItemComponent(title: "Angsuran Ke", value: snapshot.data!.angsuranKe!),
                                        if(snapshot.data!.jatuhTempo != null)
                                        DetailTransaksiItemComponent(title: "Jatuh Temp", value: snapshot.data!.jatuhTempo!),
                                        if(snapshot.data!.angsuranKe != null)
                                        DetailTransaksiItemComponent(title: "Angsuran Ke", value: snapshot.data!.angsuranKe!),
                                        if(snapshot.data!.denda != null)
                                        DetailTransaksiItemComponent(title: "Denda", value: FormatCurrency.convertToIdr(int.parse(snapshot.data!.denda!), 0)),
                                        if(snapshot.data!.noReff != null)
                                        DetailTransaksiItemComponent(title: "No. Reff", value: snapshot.data!.noReff!),
                                        if(snapshot.data!.token != null)
                                        Column(
                                          children: [
                                            const SizedBox(height: 8,),
                                            Container(
                                              width: 100.w,
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                color: kWhiteBlueColor
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("No. Token : ", style: GoogleFonts.inter(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: kSecondaryTextColor
                                                  ),),
                                                  const SizedBox(height: 6,),
                                                  Text(
                                                    snapshot.data!.token!,
                                                    style: GoogleFonts.inter(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      color: kMainThemeColor
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 8,)
                                          ],
                                        ),
                                        const SizedBox(height: 18,),
                                        const DashedSeparator(),
                                        const SizedBox(height: 18,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            DynamicSizeButtonOutlinedIconComponent(
                                              label: "Print", 
                                              buttonColor: Colors.black, 
                                              onPressed: () {}, 
                                              width: 40.w, 
                                              height: 40,
                                              icon: LineIcons.print,
                                            ),
                                            DynamicSizeButtonOutlinedIconComponent(
                                              label: "Share", 
                                              buttonColor: kMainLightThemeColor, 
                                              onPressed: () {}, 
                                              width: 40.w, 
                                              height: 40,
                                              icon: Icons.share_outlined,
                                            ),
                                          ],
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
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 100.w,
                padding: const EdgeInsets.all(18),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18))
                ),
                child: Column(
                  children: [
                    DynamicSizeButtonComponent(
                      buttonColor: kMainLightThemeColor,
                      onPressed: () {
                        context.pop();
                      },
                      label: "Kembali",
                      width: 100.w,
                      height: 50,
                    )
                  ],
                ),
              )
            )
          ],
        )
      ),
    );
  }
}