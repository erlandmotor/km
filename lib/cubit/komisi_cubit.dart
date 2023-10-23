import 'package:adamulti_mobile_clone_new/model/komisi_history_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'komisi_state.dart';

class KomisiCubit extends Cubit<KomisiState> {
  KomisiCubit() : super(const KomisiInitial(isLoadingState: true, totalKomisiState: 0, dataListState: []));

  var currentPage = 1;
  var listOfCurrentDateTime = <DateTime?>[DateTime(DateTime.now().year, DateTime.now().month, 1), 
  DateTime(DateTime.now().year, DateTime.now().month + 1, 0)];

  void updateState(bool isLoading, List<KomisiHistoryData> dataList, int komisiTotal) {
    emit(KomisiInitial(isLoadingState: isLoading, 
      totalKomisiState: komisiTotal, 
      dataListState: dataList
      )
    );
  }

  void resetState() {
    currentPage = 1;
    listOfCurrentDateTime = <DateTime?>[DateTime(DateTime.now().year, DateTime.now().month, 1), 
    DateTime(DateTime.now().year, DateTime.now().month + 1, 0)];
    emit(const KomisiInitial(dataListState: [], isLoadingState: true, totalKomisiState: 0));
  }
}
