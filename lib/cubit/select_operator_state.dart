part of 'select_operator_cubit.dart';

sealed class SelectOperatorState extends Equatable {
  const SelectOperatorState({
    required this.isLoading,
    required this.dataList,
    required this.fetchedDataList
  });

  final bool isLoading;
  final List<OperatorData> dataList;
  final List<OperatorData> fetchedDataList;

  @override
  List<Object> get props => [
    isLoading,
    dataList,
    fetchedDataList
  ];
}

final class SelectOperatorInitial extends SelectOperatorState {
  final bool isLoadingState;
  final List<OperatorData> dataListState;
  final List<OperatorData> fetchedDataListState;

  const SelectOperatorInitial({ required this.isLoadingState, required this.dataListState, required this.fetchedDataListState })
  : super(isLoading: isLoadingState, dataList: dataListState, fetchedDataList: fetchedDataListState);
}
