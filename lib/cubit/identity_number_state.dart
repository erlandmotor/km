part of 'identity_number_cubit.dart';

sealed class IdentityNumberState extends Equatable {
  const IdentityNumberState({ required this.identityNumber });

  final String identityNumber;

  @override
  List<Object> get props => [
    identityNumber
  ];
}

final class IdentityNumberInitial extends IdentityNumberState {
  final String identityNumberState;

  const IdentityNumberInitial({ required this.identityNumberState }) : super(identityNumber: identityNumberState);
}
