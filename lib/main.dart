import 'package:flutter/material.dart';
import 'package:housr_booking_app/db/shared_prefence.dart';
import 'package:housr_booking_app/screen/get_started.dart';
import 'package:housr_booking_app/screen/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: _checkIfLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData && snapshot.data == true) {
            return const MyHomePage();
          } else {
            return const GetStarted();
          }
        },
      ),
    );
  }

  Future<bool> _checkIfLoggedIn() async {
    final username = await UserPreferences.getUsername();
    return username != null;
  }
}
