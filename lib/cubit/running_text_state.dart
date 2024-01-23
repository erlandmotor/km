part of 'running_text_cubit.dart';

sealed class RunningTextState extends Equatable {
  const RunningTextState({ required this.dataList, required this.currentIndex, required this.nextIndex });

  final List<RunningTextData> dataList;
  final int currentIndex;
  final int nextIndex;

  @override
  List<Object> get props => [
    dataList,
    currentIndex,
    nextIndex
  ];
}

final class RunningTextInitial extends RunningTextState {
  final List<RunningTextData> dataListState;
  final int currentIndexState;
  final int nextIndexState;

  const RunningTextInitial({ required this.dataListState, required this.currentIndexState,
  required this.nextIndexState }) : super(dataList: dataListState, currentIndex: currentIndexState,
  nextIndex: nextIndexState);
}
