import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'show_balance_state.dart';

class ShowBalanceCubit extends Cubit<ShowBalanceState> {
  ShowBalanceCubit() : super(const ShowBalanceInitial(isShowBalanceState: false));
  
  void showHideBalance() {
    emit(ShowBalanceInitial(isShowBalanceState: !state.isShowBalance));
  }
}
