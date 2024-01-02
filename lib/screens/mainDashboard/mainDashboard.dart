import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:water_detector_app/screens/models/waterSourceModel.dart';
import 'package:water_detector_app/screens/services/api.dart';

class MainDashboardActivity extends StatefulWidget {
  const MainDashboardActivity({super.key});

  @override
  State<MainDashboardActivity> createState() => _MainDashboardActivityState();
}

class _MainDashboardActivityState extends State<MainDashboardActivity> {
  final ApiService apiService = ApiService();
  List<WaterSource> waterSourceData = [
    WaterSource(
        name: 'Ujjani Dam',
        currentLevel: 3.5,
        quality: 'Excellent',
        desc:
            'The Ujjani Dam, located near the village of Ujjani on the Bhima River in Solapur district, Maharashtra, India, is the largest dam on the river. Built from 1969 to 1980, it is an earthfill and gravity dam with a capacity of 3,313,071,000 m³. The dam, with a height of 56.4 m and length of 2534 m, serves various purposes, including irrigation, hydroelectric power generation (12 MW), drinking water supply, and fisheries. The reservoir, known as "Yashwant Sagar," has 41 doors. Despite being the last dam on the Bhima River, it intercepts a vast catchment area of 14,856 square km. The dam plays a crucial role in supplying water to Solapur and neighboring districts, even during low rainfall, thanks to contributions from the western side of Pune district. The multipurpose reservoir supports irrigation through the Left Bank Main Canal (LBMC) and the Right Bank Main Canal (RBMC). The dam stands as a significant infrastructure project, contributing to the sustainable development of the region.'),
    WaterSource(
        name: 'Ekrukh Hipparga Lake',
        currentLevel: 2.8,
        quality: 'Moderate',
        desc:
            'Ekrukh Hipparhe Lake was established during the period when Solapur was under British rule 1871. It has a capacity of 84,950,540 m3 and this lake is one of the historical man-made water reservoirs near Solapur city at a distance of around 12 km. The reservoir commands a gross area of 17,152 acres with maximum height of 21.45m. The total catchment area of the reservoir is 411.81 sq.km. In addition to water for irrigation and domestic use in villages, Ekrukh Lake provides drinking water to Solapur city and is one of the city’s major water resources.'),
    WaterSource(
        name: 'Ground Water',
        currentLevel: 4.2,
        quality: 'Excellent',
        desc:
            'In the city, groundwater availability fluctuates due to discontinuity in flow at greater depths and the presence of hard rock terrain. Recharging of upper shallow aquifers primarily occurs during the monsoon season. The city relies on both public (22%) and private (78%) bore-wells, some equipped with electric pumps. By 2021, records indicate 2195 bore-wells were drilled, with water tables ranging from 100 to 150 meters. There are around 10,000 bore-wells, with approximately 60% being seasonal (200 to 500 liters/day), 30% with medium discharge (500 to 2000 liters/day), and 10% exceeding 2500 liters/day. Groundwater contributes an estimated 3 to 4.5 MLD to the city\'s water resources. However, nearly 20% of bore-wells become unusable during the summer.'),
  ];
  int currentIndex = 0;
  /* @override
  void initState() {
    super.initState();
    _fetchWaterSources();
  }

  Future<void> _fetchWaterSources() async {
    try {
      final List<WaterSource> fetchedData =
          await apiService.fetchWaterSources();
      setState(() {
        waterSources = fetchedData;
      });
    } catch (error) {
      print('Error fetching water sources: $error');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Aquatic Advisor',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue.shade100,
        elevation: 0,
        centerTitle: true,
      ),
      body: _buildCurrentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.blue.shade100,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.show_chart), label: 'Water \n Level'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.water), label: 'Water \n Quality'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (currentIndex) {
      case 0:
        return _buildHomeScreen();
      case 1:
        return _buildWaterLevelMonitoringScreen();
      case 2:
        return _buildWaterQualityAnalysisScreen();
      case 3:
        return _buildSettingsScreen();
      default:
        return Container();
    }
  }

  Widget _buildHomeScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Water Sources',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        _buildWaterSourceList(),
      ],
    );
  }

  Widget _buildWaterSourceList() {
    return Expanded(
      child: ListView.builder(
        itemCount: waterSourceData.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              //This is going to be implemented soon
            },
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: ((context) => AlertDialog(
                        title: Text(
                          waterSourceData[index].name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: SingleChildScrollView(
                            child: Text(waterSourceData[index].desc)),
                        contentPadding: const EdgeInsets.all(8.0),
                      )));
            },
            child: Card(
              color: Colors.grey.shade100,
              elevation: 4,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                title: Text(
                  waterSourceData[index].name,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Current Level: ${waterSourceData[index].currentLevel}'),
                    Text('Quality: ${waterSourceData[index].quality}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWaterLevelMonitoringScreen() {
    List<FlSpot> ujjaniDam = [
      const FlSpot(0, 2.0),
      const FlSpot(1, 2.5),
      const FlSpot(2, 2.2),
      const FlSpot(3, 2.8),
      const FlSpot(4, 2.9),
      const FlSpot(5, 3.0),
      const FlSpot(6, 4.2),
      const FlSpot(7, 4.0),
    ];

    List<FlSpot> ekrukhHippargaLake = [
      const FlSpot(0, 1.5),
      const FlSpot(1, 2.0),
      const FlSpot(2, 2.5),
      const FlSpot(3, 3.2),
      const FlSpot(4, 3.8),
      const FlSpot(5, 3.0),
      const FlSpot(6, 2.2),
      const FlSpot(7, 2.9),
    ];

    List<FlSpot> groundWater = [
      const FlSpot(0, 3.0),
      const FlSpot(1, 3.5),
      const FlSpot(2, 2.8),
      const FlSpot(3, 3.2),
      const FlSpot(4, 3.9),
      const FlSpot(5, 3.7),
      const FlSpot(6, 3.0),
      const FlSpot(7, 2.8),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Water Level Monitoring',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(
                  show: true,
                  leftTitles: AxisTitles(drawBelowEverything: true),
                  bottomTitles: AxisTitles(
                    drawBelowEverything: true,
                  ),
                ),
                borderData: FlBorderData(show: true),
                minX: 0,
                maxX: 7,
                minY: 0,
                maxY: 5,
                lineBarsData: [
                  _buildLineChartBarData(ujjaniDam, Colors.blue),
                  _buildLineChartBarData(ekrukhHippargaLake, Colors.green),
                  _buildLineChartBarData(groundWater, Colors.orange),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineChartBarData _buildLineChartBarData(List<FlSpot> data, Color color) {
    return LineChartBarData(
      spots: data,
      isCurved: true,
      color: color,
      barWidth: 4,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false),
    );
  }

  Widget _buildWaterQualityAnalysisScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Quality Analysis'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Water Quality Analysis',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          _buildAnalysisDetails(),
        ],
      ),
    );
  }

  Widget _buildAnalysisDetails() {
    return const Expanded(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ujjani Dam',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('pH Level: 7.2'),
              Text('Turbidity: 15 NTU'),
              Text('Chemical Contaminants: None detected'),
              Text(
                'Ekrukh Hipparga Lake',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('pH Level: 7.2'),
              Text('Turbidity: 15 NTU'),
              Text('Chemical Contaminants: None detected'),
              Text(
                'Ground Water',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('pH Level: 7.2'),
              Text('Turbidity: 15 NTU'),
              Text('Chemical Contaminants: None detected'),
              // Add more analysis details as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade100,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text('Notification Preferences'),
              subtitle: Text('Configure when to receive water-related alerts'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle navigation to notification settings screen
              },
            ),
            ListTile(
              title: Text('Language Preferences'),
              subtitle: Text('Choose your preferred language'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle navigation to language settings screen
              },
            ),
            // Add more settings options as needed
          ],
        ),
      ),
    );
  }
}