part of 'history_calendar_cubit.dart';

sealed class HistoryCalendarState extends Equatable {
  const HistoryCalendarState({ required this.selectedDateTimes });

  final List<DateTime?> selectedDateTimes;

  @override
  List<Object> get props => [
    selectedDateTimes
  ];
}

final class HistoryCalendarInitial extends HistoryCalendarState {

  final List<DateTime?> selectedDateTimesState;

  const HistoryCalendarInitial({ required this.selectedDateTimesState }) : super(
    selectedDateTimes: selectedDateTimesState
  );
}
