import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notification_count_state.dart';

class NotificationCountCubit extends Cubit<NotificationCountState> {
  NotificationCountCubit() : super(const NotificationCountInitial(notificationCountState: 0));

  void updateState(int data) {
    emit(NotificationCountInitial(notificationCountState: data));
  }
}
