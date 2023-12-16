part of 'notifications_cubit.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState({ required this.isLoading, required this.notificationList });

  final bool isLoading;
  final List<NotificationData> notificationList;

  @override
  List<Object> get props => [
    isLoading,
    notificationList
  ];
}

final class NotificationsInitial extends NotificationsState {

  final bool isLoadingState;
  final List<NotificationData> notificationListState;

  const NotificationsInitial({ required this.isLoadingState, required this.notificationListState }) :
  super(isLoading: isLoadingState, notificationList: notificationListState);
}
