
import 'package:permission_handler/permission_handler.dart';

Future<void> requestNotificationPermission() async {
  // Android 13+ requires POST_NOTIFICATIONS
  final status = await Permission.notification.request();

  if (status.isGranted) {
    // print("Notification permission granted!");
  } else if (status.isDenied) {
    // print("Notification permission denied!");
  } else if (status.isPermanentlyDenied) {
    // print("Permission permanently denied. Open app settings to allow.");
    // await openAppSettings();
  }
}
