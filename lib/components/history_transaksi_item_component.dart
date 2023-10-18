import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class HistoryTransaksiItemComponent extends StatelessWidget {

  const  HistoryTransaksiItemComponent({ super.key,
  required this.kodeTujuan, required this.amount, required this.sn,
  required this.waktu, required this.statusText, required this.statusTransaksi });

  final String kodeTujuan;
  final int amount;
  final String sn;
  final String waktu;
  final String statusTransaksi;
  final String statusText;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: statusTransaksi == "2" ? Colors.red : Colors.blue,
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
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: statusTransaksi == "2" ? Colors.red : Colors.green
                    ),
                    child: Icon(
                      statusTransaksi == "2" ? LineIcons.times : LineIcons.check,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 18,),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 50.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(kodeTujuan, style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                              ),),
                              const SizedBox(height: 2,),
                              Text("SN : $sn", 
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 2,),
                              Text(waktu, style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AutoSizeText(FormatCurrency.convertToIdr(amount, 0), 
                              maxFontSize: 16,
                              maxLines: 1,
                              style: GoogleFonts.inter(
                                color: statusTransaksi == "2" ? Colors.red : Colors.green,
                                fontWeight: FontWeight.w700
                              ),
                            ), const SizedBox(height: 2,),
                            Text(statusText, style: GoogleFonts.inter(
                              fontSize: 12,
                              color: statusTransaksi == "2" ? Colors.red : Colors.green,
                              fontWeight: FontWeight.w500
                            ),)
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