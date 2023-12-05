import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'transaction_detail_state.dart';

class TransactionDetailCubit extends Cubit<TransactionDetailState> {
  TransactionDetailCubit() : super(const TransactionDetailInitial(isPrintingState: false, totalReceiptState: ""));

  void updateState(bool isPrinting, String totalReceipt) {
    emit(TransactionDetailInitial(isPrintingState: isPrinting, totalReceiptState: totalReceipt));
  }
}
