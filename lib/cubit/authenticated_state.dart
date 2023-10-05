part of 'authenticated_cubit.dart';

sealed class AuthenticatedState extends Equatable {
  const AuthenticatedState({ required this.authenticatedUser });

  final User authenticatedUser;

  @override
  List<Object> get props => [
    authenticatedUser
  ];
}

final class AuthenticatedInitial extends AuthenticatedState {
  final User authenticatedUserState;

  const AuthenticatedInitial({ required this.authenticatedUserState }) : super(authenticatedUser: authenticatedUserState);
}
