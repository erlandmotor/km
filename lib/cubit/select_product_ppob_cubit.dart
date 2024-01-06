import 'package:adamulti_mobile_clone_new/model/product_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_product_ppob_state.dart';

class SelectProductPpobCubit extends Cubit<SelectProductPpobState> {
  SelectProductPpobCubit() : super(const SelectProductPpobInitial(isLoadingState: true, dataListState: [], fetchedDataListState: []));

  void updateState(bool isLoading, List<ProductData> dataList, List<ProductData> fetchedDataList) {
    emit(SelectProductPpobInitial(isLoadingState: isLoading, dataListState: dataList, fetchedDataListState: fetchedDataList));
  }
}
