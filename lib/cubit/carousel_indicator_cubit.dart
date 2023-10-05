import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'carousel_indicator_state.dart';

class CarouselIndicatorCubit extends Cubit<CarouselIndicatorState> {
  CarouselIndicatorCubit() : super(const CarouselIndicatorInitial(indicatorIndexState: 0));

  void changeIndex(int index) {
    emit(CarouselIndicatorInitial(indicatorIndexState: index));
  }
}
