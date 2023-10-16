import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/screens/main/history_tab/rekap_transaksi_tab.dart";
import "package:adamulti_mobile_clone_new/screens/main/history_tab/saldo_history_tab.dart";
import "package:adamulti_mobile_clone_new/screens/main/history_tab/topup_saldo_history_tab.dart";
import "package:adamulti_mobile_clone_new/screens/main/history_tab/transaksi_history_tab.dart";
import "package:adamulti_mobile_clone_new/screens/main/history_tab/transfer_saldo_history_tab.dart";
import "package:buttons_tabbar/buttons_tabbar.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";

class HistoryScreen extends StatelessWidget {

  const HistoryScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return ContainerGradientBackground(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Riwayat", style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),),
                    GestureDetector(
                      onTap: () {
                      },
                      child: const Icon(Icons.calendar_month_outlined, size: 32, color: Colors.white,)
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8,),
              Expanded(
                child: DefaultTabController(
                  length: 5, 
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        ButtonsTabBar(
                          radius: 8,
                          contentPadding: const EdgeInsets.all(12),
                          buttonMargin: const EdgeInsets.symmetric(horizontal: 8),
                          height: 46,
                          labelSpacing: 4,
                          backgroundColor: kMainLightThemeColor,
                          unselectedBackgroundColor: const Color(0xffdfe4ea),
                          borderColor: kMainLightThemeColor,
                          borderWidth: 0,
                          unselectedBorderColor: const Color(0xff6a89cc),
                          labelStyle: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                          ),
                          unselectedLabelStyle: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                          ),
                          tabs: const [
                            Tab(
                              icon: Icon(LineIcons.wavyMoneyBill),
                              text: 'Transaksi',
                            ),
                            Tab(
                              icon: Icon(LineIcons.wallet),
                              text: 'Saldo',
                            ),
                            Tab(
                              icon: Icon(LineIcons.fileInvoiceWithUsDollar),
                              text: 'Rekap Transaksi',
                            ),
                            Tab(
                              icon: Icon(LineIcons.handHoldingUsDollar),
                              text: 'Topup Saldo',
                            ),
                            Tab(
                              icon: Icon(LineIcons.alternateMoneyCheck),
                              text: 'Transfer Saldo',
                            ),
                          ],
                        ),
                        const SizedBox(height: 30,),
                        const Expanded(
                          child: TabBarView(
                            children: [
                              TransaksiHistoryTab(),
                              SaldoHistoryTab(),
                              RekapTransaksiTab(),
                              TopupSaldoHistoryTab(),
                              TransferSaldoHistoryTab()
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ),
              )
            ],
          )
        ],
      )
    );
  }
}