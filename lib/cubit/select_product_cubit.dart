import 'package:adamulti_mobile_clone_new/model/product_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_product_state.dart';

class SelectProductCubit extends Cubit<SelectProductState> {
  SelectProductCubit() : super(const SelectProductInitial(isLoadingSate: true, dataListState: [], fetchedDataListState: []));

  void updateState(bool isLoading, List<ProductData> dataList, List<ProductData> fetchedDataList) {
    emit(SelectProductInitial(isLoadingSate: isLoading, 
    dataListState: dataList, 
    fetchedDataListState: fetchedDataList)
    );
  } 
}
