import "package:adamulti_mobile_clone_new/components/layanan_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/model/kategori_with_menu_response.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class MoreScreenSectionComponent extends StatelessWidget {

  const MoreScreenSectionComponent({ super.key, required this.sectionData });

  final KategoriWithMenuResponse sectionData;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(8),
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 8,),
                Text(sectionData.kategoridata!.name!, style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                )),
              ],
            ),
            const SizedBox(height: 2,),
            const Divider(),
            const SizedBox(height: 2,),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 2.w,
              runSpacing: 12,
              children: [
                for(var i = 0; i < sectionData.menulist!.length; i++) LayananComponent(
                  containerWidth: 48,
                  containerHeight: 48,
                  imageWidth: 36,
                  imageHeight: 36,
                  imageUrl: "$baseUrlAuth/files/menu-mobile/image/${sectionData.menulist![i].icon!}", 
                  label: sectionData.menulist![i].name!, 
                  onTapAction: () {
                    if(sectionData.menulist![i].type! == "PULSA") {
                      context.pushNamed("pulsa-and-data");
                    }
                    
                    if(sectionData.menulist![i].type! == "WEBVIEW") {
                      context.pushNamed("web-view", extra: {
                        "title": sectionData.menulist![i].name,
                        "operatorId": sectionData.menulist![i].operatorid,
                        "url": sectionData.menulist![i].url
                      });
                    }
    
                    if(sectionData.menulist![i].type == "PLN") {
                      context.pushNamed("pln-main");
                    }
    
                    if(sectionData.menulist![i].type == "SINGLE PPOB") {
                      context.pushNamed("check-before-transaction", extra: {
                        "operatorName": sectionData.menulist![i].name,
                        "kodeproduk": sectionData.menulist![i].operatorid
                      });
                    }
    
                    if(sectionData.menulist![i].type == "DOUBLE PPOB") {
                      context.pushNamed("select-product-ppob", extra: {
                        "operatorName": sectionData.menulist![i].name,
                        "operatorId": sectionData.menulist![i].operatorid
                      });
                    }
    
                    if(sectionData.menulist![i].type == "TRIPLE PPOB") {
                      context.pushNamed("select-operator-triple-ppob", extra: {
                        "operatorName": sectionData.menulist![i].name,
                        "operatorId": sectionData.menulist![i].operatorid
                      });
                    }
    
                    if(sectionData.menulist![i].type == "DOUBLE PRODUCT") {
                      context.pushNamed("select-operator", extra: {
                        "operatorName": sectionData.menulist![i].operatorid
                      });
                    }
    
                    if(sectionData.menulist![i].type == "PLN TOKEN") {
                      context.pushNamed("pln-token", extra: {
                        "operatorName": sectionData.menulist![i].name!,
                        "operatorId": sectionData.menulist![i].operatorid,
                        "kodeproduk": "PLNPREPAID"
                      });
                    }
                  }, 
                  menuColor: HexColor.fromHex(sectionData.menulist![i].containercolor!)
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}