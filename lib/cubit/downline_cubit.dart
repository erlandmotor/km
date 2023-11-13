import 'package:adamulti_mobile_clone_new/model/get_downline_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'downline_state.dart';

class DownlineCubit extends Cubit<DownlineState> {
  DownlineCubit() : super(const DownlineInitial(isLoadingState: true, dataListSate: []));

  void updateState(bool isLoading, List<DownlineData> dataList) {
    emit(DownlineInitial(isLoadingState: isLoading, dataListSate: dataList));
  }
}
