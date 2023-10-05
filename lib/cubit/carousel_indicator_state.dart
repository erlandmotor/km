part of 'carousel_indicator_cubit.dart';

sealed class CarouselIndicatorState extends Equatable {
  const CarouselIndicatorState({ required this.indicatorIndex });

  final int indicatorIndex;

  @override
  List<Object> get props => [
    indicatorIndex
  ];
}

final class CarouselIndicatorInitial extends CarouselIndicatorState {

  final int indicatorIndexState;

  const CarouselIndicatorInitial({ required this.indicatorIndexState }) :
  super(indicatorIndex: indicatorIndexState);
}
