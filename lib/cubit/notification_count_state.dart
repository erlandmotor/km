part of 'notification_count_cubit.dart';

sealed class NotificationCountState extends Equatable {
  const NotificationCountState({ required this.notificationCount });

  final int notificationCount;

  @override
  List<Object> get props => [
    notificationCount
  ];
}

final class NotificationCountInitial extends NotificationCountState {
  final int notificationCountState;

  const NotificationCountInitial({ required this.notificationCountState }) : super(
    notificationCount: notificationCountState
  );
}
