import 'package:adamulti_mobile_clone_new/components/loading_button_component.dart';
import 'package:adamulti_mobile_clone_new/components/regular_textfield_component.dart';
import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {

  const WebviewScreen({ super.key, required this.title, required this.operatorId });

  final String title;
  final String operatorId;

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  var kodeProduk = "";

  final webviewController = WebViewController();

  final kodePembayaranController = TextEditingController();

  final popupMenuController = CustomPopupMenuController();

  @override
  void initState() {
    final splittedKodeProduk = widget.operatorId.split(" - url:");
    kodeProduk = splittedKodeProduk[0];

    final url = splittedKodeProduk[1].replaceAll(" ", "");

    webviewController..setJavaScriptMode(JavaScriptMode.unrestricted)..setBackgroundColor(const Color(0x00000000))
    ..loadRequest(Uri.parse(url));
    super.initState();
  }

  @override
  void dispose() {
    webviewController.clearCache();
    kodePembayaranController.dispose();
    popupMenuController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          CustomPopupMenu( 
            controller: popupMenuController,
            menuBuilder: () => Container(
              width: size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18)
              ),
              padding: const EdgeInsets.all(18),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RegularTextFieldComponent(
                      label: "Kode Pembayaran", 
                      controller: kodePembayaranController, 
                      validationMessage: "Kode pembayaran harus diisi.", 
                      prefixIcon: LineIcons.barcode, 
                      isObsecure: false
                    ),
                    const SizedBox(height: 8,),
                    LoadingButtonComponent(
                      label: "Proses", 
                      buttonColor: kMainLightThemeColor, 
                      onPressed: () {
                        popupMenuController.hideMenu();
                      }, 
                      width: size.width, 
                      height: 50, 
                      isLoading: false
                    )
                  ],
                ),
              ),
            ), 
            pressType: PressType.singleClick,
            verticalMargin: 10,
            horizontalMargin: 10,
            arrowColor: Colors.white,
            barrierColor: Colors.black54,
            showArrow: true,
            child: Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(LineIcons.wallet, color: Colors.white, size: 30,),
                  const SizedBox(width: 8,),
                  Text("Bayar", style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  ),),
                ],
              ),
            )
          )
        ],
        leading: IconButton(
          icon: const Icon(LineIcons.angleLeft, color: Colors.white, size: 30,),
          onPressed: () {
            context.pop();
          },
        ),
        backgroundColor: kMainThemeColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: kMainThemeColor,
          systemNavigationBarColor: Colors.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarDividerColor: Colors.white
        ),
        title: Text(widget.title, style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white
        ),),
      ),
      body: WebViewWidget(
        controller: webviewController,
      ),
    );
  }
}