import 'package:adamulti_mobile_clone_new/model/pricelist_group_response.dart';
import 'package:adamulti_mobile_clone_new/model/pricelist_search_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pricelist_state.dart';

class PricelistCubit extends Cubit<PricelistState> {
  PricelistCubit() : super(PricelistInitial(
    isLoadingState: true,
    isSearchingState: false,
    pricelistGroupDataState: PricelistGroupResponse(),
    pricelistSearchDataState: PricelistSearchResponse()
  ));

  void updateState(
    bool isLoading,
    bool isSearching,
    PricelistGroupResponse pricelistGroupData,
    PricelistSearchResponse pricelistSearchData
  ) {
    emit(PricelistInitial(
      isLoadingState: isLoading, 
      isSearchingState: isSearching, 
      pricelistGroupDataState: pricelistGroupData, 
      pricelistSearchDataState: pricelistSearchData
      )
    );
  }
}
