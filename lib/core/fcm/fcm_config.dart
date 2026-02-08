import 'dart:developer';

import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

bool isFCMInitialized = false;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

}

class FCMService {
  static final FCMService _instance = FCMService._internal();
  factory FCMService() => _instance;
  FCMService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  String? _fcmToken;
  String? get fcmToken => _fcmToken;

  /// Initialize FCM and set up all notification handlers
  Future<void> initialize() async {
    if (isFCMInitialized) return;
    // Request notification permissions (iOS and Android 13+)
    NotificationSettings settings = await _firebaseMessaging
        .requestPermission();

    log('User granted permission: ${settings.authorizationStatus}');

    // Initialize local notifications for foreground handling
    await _initializeLocalNotifications();

    // Get and store FCM token (unique device identifier)
    _fcmToken = await _firebaseMessaging.getToken();
    log('FCM Token: $_fcmToken');
    // Send this token to your backend server to send notifications

    // Listen for token refresh (happens when app reinstalled, data cleared, etc.)
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      _fcmToken = newToken;
      log('FCM Token refreshed: $newToken');
      // Update token on your server
    });

    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // Handle notification when app is in FOREGROUND
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle notification tap when app is in BACKGROUND (not terminated)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // Check if app was opened from a TERMINATED state by tapping notification
    RemoteMessage? initialMessage = await _firebaseMessaging
        .getInitialMessage();

    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }

    isFCMInitialized = true;
  }

  /// Initialize local notifications plugin
  Future<void> _initializeLocalNotifications() async {
    // Android notification icon (place in android/app/src/main/res/drawable/)
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS notification settings
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // Initialize with callback for when notification is tapped
    await _localNotifications.initialize(settings: initSettings);

    // Create notification channel for Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // Must match AndroidManifest
      'High Importance Notifications',
      description: 'This channel is used for important notifications',
      importance: Importance.high, // Shows as heads-up notification
      playSound: true,
      enableVibration: true,

    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  /// Handle messages when app is in FOREGROUND
  void _handleForegroundMessage(RemoteMessage message) {
    showLocalNotification(message);
  }

  /// Display local notification
  Future<void> showLocalNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    // AndroidNotification? android = message.notification?.android;
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications',
          importance: Importance.max,
          priority: Priority.high,
          color: AppColors.primerColor,
          playSound: true,
          enableVibration: true,
        );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    if (notification != null) {
      await _localNotifications.show(
        id: notification.hashCode, // Unique notification ID
        title: notification.title,
        body: notification.body,
        notificationDetails: notificationDetails,
        payload: message.data.toString(), // Pass data for tap handling
      );
    }
  }

  /// Handle notification tap (from background or terminated state)
  void _handleNotificationTap(RemoteMessage message) {
    log('Notification tapped!');
    log('Message data: ${message.data}');

    // Navigate to specific screen based on data
    if (message.data['screen'] != null) {
      // Example: Navigate to specific screen
      // navigatorKey.currentState?.pushNamed(message.data['screen']);
    }
  }

  /// Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
    print('Subscribed to topic: $topic');
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    print('Unsubscribed from topic: $topic');
  }
}
