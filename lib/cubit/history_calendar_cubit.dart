import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'history_calendar_state.dart';

class HistoryCalendarCubit extends Cubit<HistoryCalendarState> {
  HistoryCalendarCubit() : super(HistoryCalendarInitial(selectedDateTimesState: [DateTime.now()]));

  void updateState(List<DateTime?> data) {
    emit(HistoryCalendarInitial(selectedDateTimesState: data));
  }
}
