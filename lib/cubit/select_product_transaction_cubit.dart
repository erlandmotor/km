import 'package:adamulti_mobile_clone_new/model/product_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_product_transaction_state.dart';

class SelectProductTransactionCubit extends Cubit<SelectProductTransactionState> {
  SelectProductTransactionCubit() : super(const SelectProductTransactionInitial(isLoadingState: true, dataListState: [], fetchedDataListState: []));

  void updateState(bool isLoading, List<ProductData> dataList, List<ProductData> fetchedDataList) {
    emit(SelectProductTransactionInitial(isLoadingState: isLoading, dataListState: dataList, fetchedDataListState: fetchedDataList));
  }
}
