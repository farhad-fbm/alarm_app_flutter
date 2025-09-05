// import 'package:flutter/material.dart';
// import 'package:my_app/helpers/location_helper.dart';
// import 'package:my_app/constants/app_colors.dart';

// class AlarmScreen extends StatelessWidget {
//   const AlarmScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     String? savedLocation = LocationHelper.getSavedLocation();

//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(40.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     savedLocation != null
//                         ? "Selected Location:"
//                         : "No location saved",
//                     style: TextStyle(fontSize: 18, color: Colors.white),
                
//                   ),
//                   Text(
//                     savedLocation ?? "",
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
                  
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}