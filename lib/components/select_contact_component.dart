import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:flutter/material.dart";
import "package:flutter_contacts/flutter_contacts.dart";
import "package:iconsax/iconsax.dart";

class SelectContactComponent extends StatelessWidget {

  const SelectContactComponent({ super.key, required this.onTapAction });

  final Function onTapAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FlutterContacts.requestPermission().then((value) async {
          if(value) {
            final contacts = await FlutterContacts.openExternalPick();
            if(contacts != null) {
              onTapAction(contacts.phones[0].normalizedNumber);
            }
          } else {
            showDynamicSnackBar(
              context, 
              Iconsax.warning_2, 
              "ERROR", 
              "Anda harus mengizinkan applikasi untuk mengakses kontak anda.", 
              Colors.red
            );
          }
        });
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: const Color(0xff079992)
        ),
        child: const Center(
          child: Icon(Iconsax.user_search, color: Colors.white,),
        ),
      ),
    );
  }
}