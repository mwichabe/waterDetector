import 'package:flutter/material.dart';
import 'package:water_detector_app/screens/models/waterSourceModel.dart';
import 'package:water_detector_app/screens/waterLevelMonitoring/waterLevelMonitoring.dart';

class WaterSourceListWidget extends StatelessWidget {
  final List<WaterSource> waterSources;

  WaterSourceListWidget({required this.waterSources});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: waterSources.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(
                waterSources[index].name,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current Level: ${waterSources[index].currentLevel}'),
                  Text('Quality: ${waterSources[index].quality}'),
                  // Add more information as needed
                ],
              ),
              onTap: () {
                // Navigate to the Water Level Monitoring screen with the selected water source
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WaterLevelMonitoringScreen(
                        waterSource: waterSources[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
