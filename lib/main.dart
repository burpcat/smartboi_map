// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'package:smartboi_map/map_screen.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Firestore Map Demo',
//       home: HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   String lastUpdated = '';
//   String count = '';
//
//   @override
//   void initState() {
//     super.initState();
//     fetchLastUpdate();
//     fetchCount();
//   }
//
//   Future<void> fetchLastUpdate() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     DocumentSnapshot snapshot = await firestore.collection('4S').doc('gps-data').get();
//     print('Snapshot: $snapshot');
//     if (snapshot.exists) {
//       String lastUpdatedString = snapshot.get('latest_update');
//       setState(() {
//         lastUpdated = 'Last Updated: $lastUpdatedString';
//       });
//     }
//   }
//
//   Future<void> fetchCount() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     DocumentSnapshot snapshot = await firestore.collection('4S').doc('rfid-data').get();
//     print('Snapshot: $snapshot');
//     if (snapshot.exists) {
//       int presentCount = snapshot.get('present_count');
//       setState(() {
//         count = 'Count: $presentCount';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firestore Map Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => MapScreen(documentId: 'gps-data')),
//                 );
//               },
//               child: Text('View Map'),
//             ),
//             SizedBox(height: 20.0),
//             Text(
//               lastUpdated.isNotEmpty ? lastUpdated : 'Fetching last update...',
//               style: TextStyle(fontSize: 16.0),
//             ),
//             SizedBox(height: 10.0),
//             Text(
//               count.isNotEmpty ? count : 'Fetching count...',
//               style: TextStyle(fontSize: 16.0),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:smartboi_map/map_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Map Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Map Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapScreen(documentId: 'gps-data')),
                );
              },
              child: Text('View Map'),
            ),
            SizedBox(height: 20.0),
            LastUpdatedText(),
            SizedBox(height: 10.0),
            CountText(),
          ],
        ),
      ),
    );
  }
}

class LastUpdatedText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('4S').doc('gps-data').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String lastUpdatedString = snapshot.data!.get('latest_update');
          return Text(
            'Last Updated: $lastUpdatedString',
            style: TextStyle(fontSize: 16.0),
          );
        } else {
          return Text(
            'Fetching last update...',
            style: TextStyle(fontSize: 16.0),
          );
        }
      },
    );
  }
}

class CountText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('4S').doc('rfid-data').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          int presentCount = snapshot.data!.get('present_count');
          return Text(
            'Count: $presentCount',
            style: TextStyle(fontSize: 16.0),
          );
        } else {
          return Text(
            'Fetching count...',
            style: TextStyle(fontSize: 16.0),
          );
        }
      },
    );
  }
}
