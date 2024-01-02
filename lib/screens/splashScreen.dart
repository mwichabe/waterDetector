import 'package:flutter/material.dart';
import 'package:water_detector_app/main.dart';
import 'package:water_detector_app/screens/mainDashboard/mainDashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _containerSize = 100.0;
  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _containerSize = 300.0;
    });

    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MainDashboardActivity(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(color: Colors.black12),
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                width: _containerSize,
                height: _containerSize,
                child: ClipOval(child: Image.asset('ios/assets/logo.jpg')),
              ),
            )));
  }
}
