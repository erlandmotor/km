import 'package:adamulti_mobile_clone_new/model/notification_paginate_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(const NotificationsInitial(isLoadingState: true, notificationListState: []));

  void updateState(bool isLoading, List<NotificationData> notificationList) {
    emit(NotificationsInitial(isLoadingState: isLoading, notificationListState: notificationList));
  }
}
