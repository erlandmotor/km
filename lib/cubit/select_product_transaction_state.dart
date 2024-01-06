part of 'select_product_transaction_cubit.dart';

sealed class SelectProductTransactionState extends Equatable {
  const SelectProductTransactionState({
    required this.isLoading,
    required this.dataList,
    required this.fetchedDataList
  });

  final bool isLoading;
  final List<ProductData> dataList;
  final List<ProductData> fetchedDataList;

  @override
  List<Object> get props => [
    isLoading,
    dataList,
    fetchedDataList
  ];
}

final class SelectProductTransactionInitial extends SelectProductTransactionState {

  final bool isLoadingState;
  final List<ProductData> dataListState;
  final List<ProductData> fetchedDataListState;

  const SelectProductTransactionInitial({ required this.isLoadingState, required this.dataListState, required this.fetchedDataListState })
  : super(isLoading: isLoadingState, dataList: dataListState, fetchedDataList: fetchedDataListState);
}
