part of 'bottom_navigation_cubit.dart';

sealed class BottomNavigationState extends Equatable {
  const BottomNavigationState({ required this.navigationIndex });

  final int navigationIndex;

  @override
  List<Object> get props => [
    navigationIndex
  ];
}

final class BottomNavigationInitial extends BottomNavigationState {
  final int navigationIndexState;

  const BottomNavigationInitial({ required this.navigationIndexState }) : super(navigationIndex: navigationIndexState);
}
