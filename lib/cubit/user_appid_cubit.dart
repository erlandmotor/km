import 'package:adamulti_mobile_clone_new/model/user_appid.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_appid_state.dart';

class UserAppidCubit extends Cubit<UserAppidState> {
  UserAppidCubit() : super(const UserAppidInitial(userAppIdState: UserAppid(appId: "", phone: "")));

  void updateState(UserAppid data) {
    emit(UserAppidInitial(userAppIdState: data));
  } 
}
