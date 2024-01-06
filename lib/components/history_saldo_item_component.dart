import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class HistorySaldoItemComponent extends StatelessWidget {

  const  HistorySaldoItemComponent({ super.key,
  required this.keterangan, required this.sisaSaldo, required this.jumlah,
  required this.waktu });

  final String keterangan;
  final int sisaSaldo;
  final int jumlah;
  final String waktu;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: jumlah < 0 ? Colors.red : Colors.blue,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18)
        ),
        width: 100.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Image.asset(
                      jumlah < 0 ? "assets/pengeluaran.png" : "assets/pemasukan.png",
                      width: 42,
                      height: 42,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 12,),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(keterangan, style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                              ),),
                              const SizedBox(height: 2,),
                              Text(waktu, style: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AutoSizeText(FormatCurrency.convertToIdr(sisaSaldo, 0), 
                              maxFontSize: 16,
                              maxLines: 1,
                              style: GoogleFonts.openSans(
                                color: kMainLightThemeColor,
                                fontWeight: FontWeight.w700
                              ),
                            ), const SizedBox(height: 2,),
                            AutoSizeText(FormatCurrency.convertToIdr(jumlah, 0), 
                              maxFontSize: 12,
                              maxLines: 1,
                              style: GoogleFonts.openSans(
                                color: jumlah < 0 ? Colors.red : Colors.green,
                                fontWeight: FontWeight.w700
                              ),
                            ), 
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}