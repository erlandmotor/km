import "package:flutter_local_notifications/flutter_local_notifications.dart";

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin localNotificationPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initLocalNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings("adalogo");

    final initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {}
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS
    );

    await localNotificationPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: 
    (NotificationResponse notificationResponse) async {

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