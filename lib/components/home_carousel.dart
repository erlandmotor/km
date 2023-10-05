import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/cubit/carousel_indicator_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";

class HomeCarousel extends StatelessWidget {
  HomeCarousel({super.key});

  final List<String> carouselImageList = [
    "assets/slide-1.png",
    "assets/slide-2.png",
    "assets/slide-3.png",
    "assets/slide-4.png",
    "assets/slide-5.png",
    "assets/slide-6.png",
    "assets/slide-7.png",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CarouselIndicatorCubit(),
      child: Builder(
        builder: (context2) {
          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: carouselImageList.length,
                itemBuilder: (context2, index, pageIndex) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(carouselImageList[index]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(18)),
                  );
                },
                options: CarouselOptions(
                  viewportFraction: 0.9,
                  height: 150,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    final carouselIndicatorCubit = context2.read<CarouselIndicatorCubit>();
                    carouselIndicatorCubit.changeIndex(index);
                  }
                )
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < carouselImageList.length; i++)
                    InkWell(
                      child: BlocBuilder<CarouselIndicatorCubit, CarouselIndicatorState>(
                        builder: (_, state) {
                          return Container(
                            margin: const EdgeInsetsDirectional.symmetric(
                                horizontal: 3),
                            height: 5,
                            width: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: state.indicatorIndex != i ? const Color(0xffd8d8d8) : kMainLightThemeColor,
                            ),
                          );
                        },
                      ),
                    ),
                ],
              )
            ],
          );
        }
      ),
    );
  }
}
