part of 'select_product_ppob_cubit.dart';

sealed class SelectProductPpobState extends Equatable {
  const SelectProductPpobState({ required this.isLoading, required this.dataList, required this.fetchedDataList });

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

final class SelectProductPpobInitial extends SelectProductPpobState {
  final bool isLoadingState;
  final List<ProductData> dataListState;
  final List<ProductData> fetchedDataListState;

  const SelectProductPpobInitial({ required this.isLoadingState, required this.dataListState, required this.fetchedDataListState }) :
  super(dataList: dataListState, isLoading: isLoadingState, fetchedDataList: fetchedDataListState);
}
