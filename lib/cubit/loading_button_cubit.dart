import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loading_button_state.dart';

class LoadingButtonCubit extends Cubit<LoadingButtonState> {
  LoadingButtonCubit() : super(const LoadingButtonInitial(isLoadingState: false));

  updateState(bool isLoadingState) {
    emit(LoadingButtonInitial(isLoadingState: isLoadingState));
  }
}
