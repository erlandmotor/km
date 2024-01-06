import 'package:adamulti_mobile_clone_new/model/operator_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_operator_state.dart';

class SelectOperatorCubit extends Cubit<SelectOperatorState> {
  SelectOperatorCubit() : super(const SelectOperatorInitial(isLoadingState: true, dataListState: [], fetchedDataListState: []));

  void updateState(bool isLoading, List<OperatorData> dataList, List<OperatorData> fetchedDataList) {
    emit(SelectOperatorInitial(
      isLoadingState: isLoading, 
      dataListState: dataList, 
      fetchedDataListState: fetchedDataList
      )
    );
  }
}
