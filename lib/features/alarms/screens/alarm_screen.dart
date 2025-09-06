import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:my_app/common_widgets/custom_location_button.dart';
import 'package:my_app/constants/app_colors.dart';
import 'package:my_app/helpers/flutter_local_notification.dart';
import 'package:my_app/helpers/location_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String? savedLocation;
  // late Box locationBox;
  // late Box alarmsBox;

  // Use a local dummy list instead of Hive
  List<DateTime> alarms = [
    DateTime.now().add(Duration(minutes: 2)),
    DateTime.now().add(Duration(minutes: 4)),
  ];

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();

    const androidChannel = AndroidNotificationChannel(
      'alarm_channel',
      'Alarms',
      description: 'Channel for alarms',
      importance: Importance.max,
    );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidChannel);

    var androidInit = const AndroidInitializationSettings('app_icon');
    var initSettings = InitializationSettings(android: androidInit);
    flutterLocalNotificationsPlugin.initialize(initSettings);

    // Request notification permission
    requestNotificationPermission().then((_) async {
      // Schedule a test notification 5 seconds from now
      await scheduleAlarm(DateTime.now().add(Duration(seconds: 5)));
    });

    savedLocation = LocationHelper.getSavedLocation();
    // locationBox = Hive.box('locationDB');
    // alarmsBox = Hive.box('alarmsDB');
  }

  Future<void> scheduleAlarm(DateTime dateTime) async {
    // First, update the list immediately
    setState(() {
      alarms.add(dateTime);
      alarms.sort((a, b) => a.compareTo(b));
    });

    try {
      int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);

      var androidChannel = AndroidNotificationDetails(
        'alarm_channel', //channer id
        'Alarms', //channel name
        channelDescription: 'Channel for alarms',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      );

      var notificationDetails = NotificationDetails(android: androidChannel);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'Alarm',
        'It\'s time!',
        tz.TZDateTime.from(dateTime, tz.local),
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        // matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );
    } catch (e) {
      print("Error scheduling notification: $e");
    }
  }

  Future<void> pickDateTime() async {
    var status = await Permission.notification.status;
    if (!status.isGranted) {
      await requestNotificationPermission();
      status = await Permission.notification.status;
      if (!status.isGranted) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Notification permission is required to set alarms.',
              ),
            ),
          );
        }
        return;
      }
    }
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (!mounted || date == null) return;

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (!mounted || time == null) return;

    DateTime dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    await scheduleAlarm(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    // List<MapEntry> alarms = alarmsBox.toMap().entries.toList();
    // alarms.sort(
    //   (a, b) => DateTime.parse(a.value).compareTo(DateTime.parse(b.value)),
    // );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: DefaultTextStyle(
        style: const TextStyle(color: AppColors.txt),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (savedLocation != null) ...[
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selected Location",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.white70),
                        SizedBox(width: 8),
                        Expanded(child: Text(savedLocation!)),
                      ],
                    ),
                    SizedBox(height: 16),
                    CustomLocationButton(
                      onClick: pickDateTime,
                      btnText: 'Add Alarm',
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Alarms",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: alarms.length,
                itemBuilder: (context, index) {
                  // DateTime alarmTime = DateTime.parse(alarms[index].value);
                  DateTime alarmTime = alarms[index];
                  return Card(
                    color: Colors.grey[800],
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: ListTile(
                      title: Text(
                        DateFormat.jm().format(alarmTime),
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        DateFormat('EEE dd MMM yyyy').format(alarmTime),
                      ),
                      trailing: Switch(
                        value: true,
                        onChanged: (val) {
                          // Optional: toggle alarm on/off
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
