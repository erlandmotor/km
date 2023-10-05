import 'package:adamulti_mobile_clone_new/model/transaction_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'check_identity_state.dart';

class CheckIdentityCubit extends Cubit<CheckIdentityState> {
  CheckIdentityCubit() : super(CheckIdentityInitial(isLoadingState: false, resultState: TransactionResponse()));

  void updateState(bool isLoading, TransactionResponse result) {
    emit(CheckIdentityInitial(isLoadingState: isLoading, resultState: result));
  }
}
