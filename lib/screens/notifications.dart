import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _enableNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification\nPreferences',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade100,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text('Enable Notifications'),
              subtitle: Text('Receive water-related alerts'),
              trailing: Switch(
                value: _enableNotifications,
                onChanged: (value) async {
                  setState(() {
                    _enableNotifications = value;
                  });

                  if (value) {
                    await _requestNotificationPermission();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _requestNotificationPermission() async {
    if (await Permission.notification.request().isGranted) {
      // Permission is granted
      initializeNotifications();
      showNotification();
    } else {
      // Permission is not granted
      print('Notification permission is not granted.');
    }
  }

  void initializeNotifications() {
    // Initialize your notification
    // flutterLocalNotificationsPlugin.initialize(
    //   InitializationSettings(
    //     android: AndroidInitializationSettings('app_icon'),
    //     iOS: IOSInitializationSettings(),
    //   ),
    // );
  }

  void showNotification() {
    // showing a notification using flutter_local_notifications
    // flutterLocalNotificationsPlugin.show(
    //   0,
    //   'Water Detector',
    //   'You have new water-related alert',
    //   NotificationDetails(
    //     android: AndroidNotificationDetails(
    //       'channel_id',
    //       'channel_name',
    //       'channel_description',
    //     ),
    //   ),
    // );
  }
}
