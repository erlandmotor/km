part of 'user_appid_cubit.dart';

sealed class UserAppidState extends Equatable {
  const UserAppidState({ required this.userAppId });

  final UserAppid userAppId;

  @override
  List<Object> get props => [
    userAppId
  ];
}

final class UserAppidInitial extends UserAppidState {
  final UserAppid userAppIdState;

  const UserAppidInitial({ required this.userAppIdState }) : super(userAppId: userAppIdState);
}
