import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/select_region_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/cities_response.dart";
import "package:adamulti_mobile_clone_new/services/region_service.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";

class SelectCityScreen extends StatelessWidget {

  const SelectCityScreen({ super.key, required this.selectRegionCubit,
  required this.cityController, required this.districtController });

  final SelectRegionCubit selectRegionCubit;
  final TextEditingController cityController;
  final TextEditingController districtController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            LineIcons.angleLeft,
            color: Colors.white,
            size: 30,
          ),
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
            systemNavigationBarDividerColor: Colors.white),
        title: Text(
          "Pilih Kabupaten / Kota",
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: FutureBuilder<CitiesResponse>(
        future: locator.get<RegionService>().getCities(selectRegionCubit.provinceId),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasError) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.separated(
                itemCount: snapshot.data!.data!.total!,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      cityController.text = snapshot.data!.data!.cities![index].cityName!;
                      districtController.clear();

                      selectRegionCubit.updateCitiesState(snapshot.data!.data!.cities![index].cityId!);

                      context.pop();
                    },
                    title: Text(
                      snapshot.data!.data!.cities![index].cityName!,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    trailing: const Icon(LineIcons.angleRight, size: 20,),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}