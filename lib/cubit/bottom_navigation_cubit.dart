import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(const BottomNavigationInitial(navigationIndexState: 0));

  void changeNavigationIndex(int index) {
    emit(BottomNavigationInitial(navigationIndexState: index));
  }
}
