import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'google_account_state.dart';

class GoogleAccountCubit extends Cubit<GoogleAccountState> {
  GoogleAccountCubit() : super(const GoogleAccountInitial(userDataState: null));

  updateState(GoogleSignInAccount? data) {
    emit(GoogleAccountInitial(userDataState: data));
  }
}
