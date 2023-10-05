part of 'show_balance_cubit.dart';

sealed class ShowBalanceState extends Equatable {
  const ShowBalanceState({ required this.isShowBalance });

  final bool isShowBalance;

  @override
  List<Object> get props => [
    isShowBalance
  ];
}

final class ShowBalanceInitial extends ShowBalanceState {

  final bool isShowBalanceState;

  const ShowBalanceInitial({ required this.isShowBalanceState }) : super(isShowBalance: isShowBalanceState);
}
