part of 'transaction_detail_cubit.dart';

sealed class TransactionDetailState extends Equatable {
  const TransactionDetailState({
    required this.isPrinting
  });

  final bool isPrinting;

  @override
  List<Object> get props => [
    isPrinting
  ];
}

final class TransactionDetailInitial extends TransactionDetailState {

  final bool isPrintingState;

  const TransactionDetailInitial({ required this.isPrintingState }) : super(isPrinting: isPrintingState);
}
