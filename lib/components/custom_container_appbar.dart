import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";

class CustomContainerAppBar extends StatelessWidget {
  const CustomContainerAppBar({ super.key, required this.title });

  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Container(
      width: size.width,
      height: size.height * 0.14,
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xffE3E9ED)),
                  ),
                  child: const Icon(LineIcons.angleLeft, color: Colors.white),
                ),
              ),
              SizedBox(
                width: size.width * 0.18,
              ),
              Flexible(
                child: Text(title, style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),),
              )
            ],
          ),
        ],
      ),
    );
  }
}