import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'identity_number_state.dart';

class IdentityNumberCubit extends Cubit<IdentityNumberState> {
  IdentityNumberCubit() : super(const IdentityNumberInitial(identityNumberState: ""));

  void updateState(String identityNumber) {
    emit(IdentityNumberInitial(identityNumberState: identityNumber));
  } 
}
