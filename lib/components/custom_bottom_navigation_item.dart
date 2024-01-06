import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;

class CustomBottomNavigationItem extends StatelessWidget {

  const CustomBottomNavigationItem({ super.key, required this.onTapAction,
  required this.isSelected,
  required this.menuIcon, required this.menuTitle,
  required this.isShowBadge });

  final Function onTapAction;
  final bool isSelected;
  final IconData menuIcon;
  final String menuTitle;
  final bool isShowBadge;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          onTapAction();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isShowBadge ? badges.Badge(
              position: badges.BadgePosition.topEnd(top: -4, end: -8),
              badgeStyle: const badges.BadgeStyle(
                badgeColor: Colors.red
              ),
              child: Icon(
                menuIcon,
                fill: 1,
                weight: 1, 
                color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
                size: 28,
              ),
            ) : Icon(
              menuIcon,
              fill: 1,
              weight: 1, 
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
              size: 28,
            ),
            const SizedBox(height: 4,),
            if(isSelected == true) Text(menuTitle, style: GoogleFonts.openSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white
            ),)
          ],
        ),
      ),
    );
  }
}