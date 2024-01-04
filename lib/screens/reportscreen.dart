import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:water_detector_app/widgets/weatherUpdate.dart';

class ReportScreen extends StatefulWidget {
  final String name;
  final String email;
  final String solution;

  const ReportScreen({
    super.key,
    required this.name,
    required this.email,
    required this.solution,
  });

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Report'),
      ),
      body: Screenshot(
        controller: _screenshotController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeatherUpdateWidget(),
              SizedBox(height: 16),
              _buildHeader(),
              SizedBox(height: 16),
              _buildUserInfo(),
              SizedBox(height: 16),
              _buildSolution(),
              SizedBox(height: 16),
              _buildScreenshotButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Official Aquatic Advisor User Report',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Divider(
          color: Colors.black,
          thickness: 2,
          height: 20,
        ),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name: ${widget.name}',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          'Email: ${widget.email}',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildSolution() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Possible Solution:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          widget.solution,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildScreenshotButton() {
    return Center(
      child: Image.asset(
        'assets/logo.jpg',
        fit: BoxFit.cover,
        height: 180.0,
        width: 150.0,
      ),
    );
  }

  Future<void> _saveScreenshot(Uint8List imageBytes) async {
    try {
      // Get the local directory using path_provider
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String appDocPath = appDocDir.path;

      // Generate a unique filename
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String filePath = '$appDocPath/screenshot_$timestamp.png';

      // Write the image to the local file
      File file = File(filePath);
      await file.writeAsBytes(imageBytes);

      // Display a message or perform any other actions based on the saved file
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Screenshot saved to $filePath')),
      );
    } catch (e) {
      // Handle the error
      print('Error saving screenshot: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving screenshot')),
      );
    }
  }
}
