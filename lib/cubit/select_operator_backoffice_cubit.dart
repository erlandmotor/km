import 'package:adamulti_mobile_clone_new/model/setting_kategori_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_operator_backoffice_state.dart';

class SelectOperatorBackofficeCubit extends Cubit<SelectOperatorBackofficeState> {
  SelectOperatorBackofficeCubit() : super(const SelectOperatorBackofficeInitial(isLoadingState: true, dataListState: [], fetchedDataListState: []));

  void updateState(bool isLoading, List<SettingKategoriResponse> dataList, List<SettingKategoriResponse> fetchedDataList) {
    emit(SelectOperatorBackofficeInitial(isLoadingState: isLoading, 
      dataListState: dataList, 
      fetchedDataListState: fetchedDataList
      )
    );
  }
}
