import 'package:adamulti_mobile_clone_new/model/login_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authenticated_state.dart';

class AuthenticatedCubit extends Cubit<AuthenticatedState> {
  AuthenticatedCubit() : super(AuthenticatedInitial(authenticatedUserState: User(idreseller: "", nAMARESELLER: "", saldo: "")));

  void updateUserState(User user) {
    emit(AuthenticatedInitial(authenticatedUserState: user));
  }
}
