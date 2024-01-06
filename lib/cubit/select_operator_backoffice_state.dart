part of 'select_operator_backoffice_cubit.dart';

sealed class SelectOperatorBackofficeState extends Equatable {
  const SelectOperatorBackofficeState({
    required this.isLoading,
    required this.dataList,
    required this.fetchedDataList
  });

  final bool isLoading;
  final List<SettingKategoriResponse> dataList;
  final List<SettingKategoriResponse> fetchedDataList;

  @override
  List<Object> get props => [
    isLoading,
    dataList,
    fetchedDataList
  ];
}

final class SelectOperatorBackofficeInitial extends SelectOperatorBackofficeState {
  final bool isLoadingState;
  final List<SettingKategoriResponse> dataListState;
  final List<SettingKategoriResponse> fetchedDataListState;

  const SelectOperatorBackofficeInitial({
    required this.isLoadingState,
    required this.dataListState,
    required this.fetchedDataListState
  }) : super(
    isLoading: isLoadingState,
    dataList: dataListState,
    fetchedDataList: fetchedDataListState
  );
}
