part of 'loading_button_cubit.dart';

sealed class LoadingButtonState extends Equatable {
  const LoadingButtonState({ required this.isLoading });

  final bool isLoading;

  @override
  List<Object> get props => [
    isLoading
  ];
}

final class LoadingButtonInitial extends LoadingButtonState {
  final bool isLoadingState;

  const LoadingButtonInitial({ required this.isLoadingState }) : super(isLoading: isLoadingState);
}
