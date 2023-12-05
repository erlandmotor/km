import 'package:adamulti_mobile_clone_new/model/kategori_with_menu_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorite_menu_state.dart';

class FavoriteMenuCubit extends Cubit<FavoriteMenuState> {
  FavoriteMenuCubit() : super(FavoriteMenuInitial(isLoadingState: true, menuDataState: KategoriWithMenuResponse()));

  void updateStae(bool isLoading, KategoriWithMenuResponse menuData) {
    emit(FavoriteMenuInitial(isLoadingState: isLoading, menuDataState: menuData));
  }
}
