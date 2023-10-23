part of 'topup_saldo_cubit.dart';

sealed class TopupSaldoState extends Equatable {
  const TopupSaldoState({ required this.isLoading, required this.data });

  final bool isLoading;
  final TopupReplyResponse data;

  @override
  List<Object> get props => [
    isLoading,
    data
  ];
}

final class TopupSaldoInitial extends TopupSaldoState {

  final bool isLoadingState;
  final TopupReplyResponse dataState;

  const TopupSaldoInitial({ required this.isLoadingState, required this.dataState }) :
  super(isLoading: isLoadingState, data: dataState);
}
