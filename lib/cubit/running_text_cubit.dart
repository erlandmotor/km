import 'package:adamulti_mobile_clone_new/model/running_text_data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'running_text_state.dart';

class RunningTextCubit extends Cubit<RunningTextState> {
  RunningTextCubit() : super(const RunningTextInitial(dataListState: [], currentIndexState: 0, nextIndexState: 0));

  void updateState(List<RunningTextData> dataList, int currentIndex, int nextIndex) {
    emit(RunningTextInitial(dataListState: dataList, currentIndexState: currentIndex, nextIndexState: nextIndex));
  }
}
