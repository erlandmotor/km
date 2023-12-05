part of 'transaction_detail_cubit.dart';

sealed class TransactionDetailState extends Equatable {
  const TransactionDetailState({
    required this.isPrinting,
    required this.totalReceipt
  });

  final bool isPrinting;
  final String totalReceipt;

  @override
  List<Object> get props => [
    isPrinting,
    totalReceipt
  ];
}

final class TransactionDetailInitial extends TransactionDetailState {

  final bool isPrintingState;
  final String totalReceiptState;

  const TransactionDetailInitial({ required this.isPrintingState, required this.totalReceiptState }) : 
  super(isPrinting: isPrintingState, totalReceipt: totalReceiptState);
}
