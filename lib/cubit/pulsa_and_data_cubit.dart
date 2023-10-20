import 'package:adamulti_mobile_clone_new/model/get_product_by_tujuan_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pulsa_and_data_state.dart';

class PulsaAndDataCubit extends Cubit<PulsaAndDataState> {
  PulsaAndDataCubit() : super(PulsaAndDataInitial(isLoadingState: false, productDataState: GetProductByTujuanResponse()));

  void updateState(bool isLoadingState, GetProductByTujuanResponse dataState) {
    emit(PulsaAndDataInitial(isLoadingState: isLoadingState, productDataState: dataState));
  }
}
