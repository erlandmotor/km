import 'package:adamulti_mobile_clone_new/model/getme_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'getme_state.dart';

class GetmeCubit extends Cubit<GetmeState> {
  GetmeCubit() : super(GetmeInitial(dataState: GetMeResponse()));

  void updateState(GetMeResponse data) {
    emit(GetmeInitial(dataState: data));
  }
}
