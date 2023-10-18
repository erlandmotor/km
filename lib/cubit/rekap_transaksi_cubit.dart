import 'package:adamulti_mobile_clone_new/model/rekap_transaksi_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'rekap_transaksi_state.dart';

class RekapTransaksiCubit extends Cubit<RekapTransaksiState> {
  RekapTransaksiCubit() : super(const RekapTransaksiInitial(isLoadingState: true, dataListState: []));

  var listOfCurrentDateTime = <DateTime?>[DateTime(DateTime.now().year, DateTime.now().month, 1), 
  DateTime(DateTime.now().year, DateTime.now().month + 1, 0)];

  void updateState(List<RekapTransaksiData> dataListState, bool isLoadingState) {
    emit(RekapTransaksiInitial(dataListState: dataListState, isLoadingState: isLoadingState));
  }

  void resetState() {
    listOfCurrentDateTime = <DateTime?>[DateTime(DateTime.now().year, DateTime.now().month, 1), 
    DateTime(DateTime.now().year, DateTime.now().month + 1, 0)];
    emit(const RekapTransaksiInitial(dataListState: [], isLoadingState: true));
  }
}
