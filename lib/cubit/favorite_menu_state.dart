part of 'favorite_menu_cubit.dart';

sealed class FavoriteMenuState extends Equatable {
  const FavoriteMenuState({ required this.isLoading, required this.menuData });

  final bool isLoading;
  final KategoriWithMenuResponse menuData;
  @override
  List<Object> get props => [
    isLoading,
    menuData
  ];
}

final class FavoriteMenuInitial extends FavoriteMenuState {

  final bool isLoadingState;
  final KategoriWithMenuResponse menuDataState;

  const FavoriteMenuInitial({ required this.isLoadingState, required this.menuDataState }) :
  super(isLoading: isLoadingState, menuData: menuDataState);
}
