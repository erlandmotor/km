import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'transaction_detail_state.dart';

class TransactionDetailCubit extends Cubit<TransactionDetailState> {
  TransactionDetailCubit() : super(const TransactionDetailInitial(isPrintingState: false));

  void updateState(bool isPrinting) {
    emit(TransactionDetailInitial(isPrintingState: isPrinting));
  }
}
