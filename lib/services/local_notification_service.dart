import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin localNotificationPlugin = FlutterLocalNotificationsPlugin();

  final globalNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "Main Navigator");


  Future<void> initLocalNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings("adalogo");

    final initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {},
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS
    );

    await localNotificationPlugin.initialize(initializationSettings, 
    onDidReceiveNotificationResponse: 
    (NotificationResponse notificationResponse) async {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          // final context = globalNavigatorKey.currentContext!;
          // context.goNamed("main");

        case NotificationResponseType.selectedNotificationAction:
          // Perhaps this section is for custom action with notification
          break;
      }
    });
  }

  NotificationDetails localNotificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails("channel id", "channel name", importance: Importance.max, priority: Priority.max),
      iOS: DarwinNotificationDetails()
    );
  }

  Future<void> showLocalNotification({
    int id = 0, String? title, String? body, String? payload 
  }) async {
    return localNotificationPlugin.show(id, title, body, localNotificationDetails());
  }
}