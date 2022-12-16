import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/registerscreen.dart';

class splashScreen extends StatefulWidget {
  @override
  splashScreenState createState() => splashScreenState();
}

class splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (ctx) => Login()), (Route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(title: const Text("Homestay Raya"), actions: [
            IconButton(
                onPressed: registerHome,
                icon: const Icon(Icons.app_registration_rounded))
          ]),
          body: const Center(child: Text("Homestay Raya Splash Screen")),
        ));
  }

  void registerHome() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }
}
