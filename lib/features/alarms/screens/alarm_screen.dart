import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:my_app/helpers/location_helper.dart';
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
  late Box locationBox ;
  late Box alarmsBox ;

  @override
  void initState() {
    super.initState();

    tz.initializeTimeZones();

    var androidInit = const AndroidInitializationSettings('app_icon');
    var initSettings = InitializationSettings(android: androidInit);
    flutterLocalNotificationsPlugin.initialize(initSettings);

    // Load saved location
    savedLocation = LocationHelper.getSavedLocation();
    locationBox = Hive.box('locationDB');
    alarmsBox = Hive.box('alarmsDB');
  }

  Future<void> scheduleAlarm(DateTime dateTime) async {
    int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Alarm',
      'It\'s time!',
      tz.TZDateTime.from(dateTime, tz.local), // Convert to TZDateTime
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_channel',
          'Alarms',
          channelDescription: 'Channel for alarms',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode:
          AndroidScheduleMode.exactAllowWhileIdle, // Ensure exact timing
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );

    alarmsBox.put(id, dateTime.toIso8601String());
    setState(() {});
  }

  Future<void> pickDateTime() async {
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
    scheduleAlarm(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    List<MapEntry> alarms = alarmsBox.toMap().entries.toList();
    alarms.sort(
      (a, b) => DateTime.parse(a.value).compareTo(DateTime.parse(b.value)),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (savedLocation != null) ...[
              Text(
                "Selected Location",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 8),
                  Expanded(child: Text(savedLocation!)),
                ],
              ),
              SizedBox(height: 16),
            ],
            ElevatedButton(onPressed: pickDateTime, child: Text('Add Alarm')),
            SizedBox(height: 16),
            Text("Alarms", style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: alarms.length,
                itemBuilder: (context, index) {
                  DateTime alarmTime = DateTime.parse(alarms[index].value);
                  return Card(
                    color: Colors.grey[800],
                    margin: EdgeInsets.symmetric(vertical: 4),
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
