part of 'select_product_cubit.dart';

sealed class SelectProductState extends Equatable {
  const SelectProductState({ required this.isLoading, required this.dataList, required this.fetchedDataList });

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

final class SelectProductInitial extends SelectProductState {

  final bool isLoadingSate;
  final List<ProductData> dataListState;
  final List<ProductData> fetchedDataListState;

  const SelectProductInitial({ required this.isLoadingSate, required this.dataListState, required this.fetchedDataListState }) :
  super(isLoading: isLoadingSate, dataList: dataListState, fetchedDataList: fetchedDataListState);
}
