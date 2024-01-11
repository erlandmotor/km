part of 'google_account_cubit.dart';

sealed class GoogleAccountState extends Equatable {
  const GoogleAccountState({ required this.userData });

  final GoogleSignInAccount? userData;

  @override
  List<Object> get props => [
  ];
}

final class GoogleAccountInitial extends GoogleAccountState {
  final GoogleSignInAccount? userDataState;

  const GoogleAccountInitial({ required this.userDataState }) : super(userData: userDataState);
}
