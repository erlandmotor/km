import "package:adamulti_mobile_clone_new/cubit/show_balance_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:iconsax/iconsax.dart";

class SaldoComponent extends StatelessWidget {
  const SaldoComponent({super.key, required this.amount});

  final String amount;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowBalanceCubit(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                "Sisa Saldo",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w500, color: Colors.white),
              ),
              BlocBuilder<ShowBalanceCubit, ShowBalanceState>(
                builder: (context2, state) {
                  final showBalanceCubit = context2.read<ShowBalanceCubit>();
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        state.isShowBalance
                            ? FormatCurrency.convertToIdr(int.parse(amount), 0)
                            : convertNumberStringToAsterisk(amount),
                        style: GoogleFonts.openSans(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      GestureDetector(
                        onTap: () {
                          showBalanceCubit.showHideBalance();
                        },
                        child: Icon(
                          state.isShowBalance
                              ? Iconsax.eye
                              : Iconsax.eye_slash,
                          size: 22,
                          color: Colors.white,
                        ),
                      )
                    ],
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
