part of 'getme_cubit.dart';

sealed class GetmeState extends Equatable {
  const GetmeState({ required this.data});

  final GetMeResponse data;

  @override
  List<Object> get props => [
    data
  ];
}

final class GetmeInitial extends GetmeState {

  final GetMeResponse dataState;

  const GetmeInitial({ required this.dataState }) : super(data: dataState);
}
