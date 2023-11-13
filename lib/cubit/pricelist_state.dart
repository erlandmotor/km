part of 'pricelist_cubit.dart';

sealed class PricelistState extends Equatable {
  const PricelistState({
    required this.isLoading,
    required this.isSearching,
    required this.pricelistGroupData,
    required this.pricelistSearchData
  });

  final bool isLoading;
  final bool isSearching;
  final PricelistGroupResponse pricelistGroupData;
  final PricelistSearchResponse pricelistSearchData;

  @override
  List<Object> get props => [
    isLoading,
    isSearching,
    pricelistGroupData,
    pricelistSearchData
  ];
}

final class PricelistInitial extends PricelistState {

  final bool isLoadingState;
  final bool isSearchingState;
  final PricelistGroupResponse pricelistGroupDataState;
  final PricelistSearchResponse pricelistSearchDataState;

  const PricelistInitial({ required this.isLoadingState, required this.isSearchingState,
  required this.pricelistGroupDataState, required this.pricelistSearchDataState }) :
  super(isLoading: isLoadingState, isSearching: isSearchingState, pricelistGroupData: pricelistGroupDataState,
  pricelistSearchData: pricelistSearchDataState);
}
