part of 'search_history_cubit.dart';

sealed class SearchHistoryState extends Equatable {
  const SearchHistoryState({ required this.isLoading, required this.currentIndex });

  final bool isLoading;
  final int currentIndex;

  @override
  List<Object> get props => [
    isLoading,
    currentIndex
  ];
}

final class SearchHistoryInitial extends SearchHistoryState {
  final bool isLoadingState;
  final int currentIndexState;

  const SearchHistoryInitial({ required this.isLoadingState, required this.currentIndexState }) :
  super(isLoading: isLoadingState, currentIndex: currentIndexState);
}
