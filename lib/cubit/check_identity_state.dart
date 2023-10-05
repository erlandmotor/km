part of 'check_identity_cubit.dart';

sealed class CheckIdentityState extends Equatable {
  const CheckIdentityState({ required this.isLoading, required this.result });

  final bool isLoading;
  final TransactionResponse result;

  @override
  List<Object> get props => [
    isLoading,
    result
  ];
}

final class CheckIdentityInitial extends CheckIdentityState {

  final bool isLoadingState;
  final TransactionResponse resultState;

  const CheckIdentityInitial({ required this.isLoadingState, required this.resultState }) : 
  super(isLoading: isLoadingState, result: resultState);
}
