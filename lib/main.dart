import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/helper/convertAddress.dart';
import 'package:uber_clone/screens/home.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppData(),
          child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
  ),
    ));
}

////////////////hi
