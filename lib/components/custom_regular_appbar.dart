import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";

class CustomRegularAppbar extends StatelessWidget implements PreferredSizeWidget {

  const CustomRegularAppbar({ super.key, required this.title });

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: kMainThemeColor,
        systemNavigationBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.white
      ),
      backgroundColor: kMainThemeColor,
      title: Text(title, style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.white
      ),),
      leading: IconButton(
        icon: const Icon(LineIcons.angleLeft, color: Colors.white,),
        onPressed: () {
          context.pop();
        },
      ),
    );
  }
}