part of 'downline_cubit.dart';

sealed class DownlineState extends Equatable {
  const DownlineState({
    required this.isLoading,
    required this.dataList
  });

  final bool isLoading;
  final List<DownlineData> dataList;

  @override
  List<Object> get props => [
    isLoading,
    dataList
  ];
}

final class DownlineInitial extends DownlineState {
  final bool isLoadingState;
  final List<DownlineData> dataListSate;

  const DownlineInitial({ required this.isLoadingState, required this.dataListSate }) :
  super(dataList: dataListSate, isLoading: isLoadingState);
}
