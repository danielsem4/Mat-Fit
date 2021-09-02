import 'package:firebase_core/firebase_core.dart';
import 'package:fit_app/authentication.dart';
import 'package:fit_app/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(),
      ),
      StreamProvider(
        create: (context) => context.read<AuthenticationService>().authStateChanges, initialData: null,
        ),
      ],
      child: MaterialApp(
      title: 'Mat-Fit',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Wrapper() ,
    ));
  }
}







