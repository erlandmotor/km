import 'package:adamulti_mobile_clone_new/model/topup_reply_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'topup_saldo_state.dart';

class TopupSaldoCubit extends Cubit<TopupSaldoState> {
  TopupSaldoCubit() : super(TopupSaldoInitial(isLoadingState: false, dataState: TopupReplyResponse()));

  void updateState(bool isLoadingState, TopupReplyResponse dataState) {
    emit(TopupSaldoInitial(isLoadingState: isLoadingState, dataState: dataState));
  }
}
