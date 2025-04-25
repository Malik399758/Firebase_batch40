import 'package:firebase_batch40/sign_up_screen.dart';
import 'package:firebase_batch40/views/auth_module/log_in.dart';
import 'package:firebase_batch40/views/firebasefirestore/firestore_screen.dart';
import 'package:firebase_batch40/views/pagination/pagination_screen.dart';
import 'package:firebase_batch40/views/theme_module/theme_provider.dart';
import 'package:firebase_batch40/views/theme_module/theme_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: themeProvider.themeData,
      home: SignUpScreen()
      //SignUpScreen()
      // You can replace with: FirestoreScreen(), PaginationScreen(), LoginScreen(), SignUpScreen()
    );
  }
}
