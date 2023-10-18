import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_history_state.dart';

class SearchHistoryCubit extends Cubit<SearchHistoryState> {
  SearchHistoryCubit() : super(const SearchHistoryInitial(isLoadingState: false, currentIndexState: 0));

  void updateState(bool isLoading, int currentIndex) {
    emit(SearchHistoryInitial(isLoadingState: isLoading, currentIndexState: currentIndex));
  }
}
