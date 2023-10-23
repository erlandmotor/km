part of 'komisi_cubit.dart';

sealed class KomisiState extends Equatable {
  const KomisiState({ required this.isLoading, required this.totalKomisi, required this.dataList });

  final bool isLoading;
  final int totalKomisi;
  final List<KomisiHistoryData> dataList;

  @override
  List<Object> get props => [
    isLoading,
    totalKomisi,
    dataList
  ];
}

final class KomisiInitial extends KomisiState {
  final bool isLoadingState;
  final int totalKomisiState;
  final List<KomisiHistoryData> dataListState;

  const KomisiInitial({ required this.isLoadingState, required this.totalKomisiState, required this.dataListState }) : super(
    isLoading: isLoadingState, totalKomisi: totalKomisiState, dataList: dataListState
  );
}
