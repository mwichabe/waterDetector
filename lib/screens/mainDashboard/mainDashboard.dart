import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:water_detector_app/main.dart';
import 'package:water_detector_app/screens/models/waterSourceModel.dart';
import 'package:water_detector_app/screens/notifications.dart';
import 'package:water_detector_app/screens/reportscreen.dart';
import 'package:water_detector_app/screens/services/api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _problemController = TextEditingController();

  //text editing Controllers

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
        title: const Text(
            'Water Quality Analysis\n Blue: Ujjani Dam\n Yellow: ekrukhHippargaLake \n Green: Ground Water'),
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
              Text('pH Level: 7.0'),
              Text('Turbidity: 18 NTU'),
              Text('Chemical Contaminants:  detected'),
              Text(
                'Ground Water',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('pH Level: 7.5'),
              Text('Turbidity: 12 NTU'),
              Text('Chemical Contaminants: None detected'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
            const Text(
              'App Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Notification Preferences'),
              subtitle:
                  const Text('Configure when to receive water-related alerts'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationSettingsScreen()));
              },
            ),
            ListTile(
              title: const Text('Restart The App'),
              subtitle: const Text('This App will Restart'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
            ),
            ListTile(
                title: const Text('User Report'),
                subtitle: const Text('Generate your Report'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _generateUserReport();
                }),
          ],
        ),
      ),
    );
  }

  void _generateUserReport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('User Report'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _problemController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      labelText:
                          'What is your possible solution to solve water problem?'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  maxLines: 5,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReportScreen(
                            name: _nameController.text,
                            email: _emailController.text,
                            solution: _problemController.text,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Generate Report'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _generateAndDownloadReport() async {
    final pdf = pw.Document();

    // Add user information and report content to the PDF
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('User Report', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 16),
              pw.Text('Name: ${_nameController.text}'),
              pw.Text('Email: ${_emailController.text}'),
              pw.Text('Solution: ${_problemController.text}'),
            ],
          );
        },
      ),
    );

    // Save the PDF to a file
    final output = await getExternalStorageDirectory();
    final file = File('${output?.path}/user_report.pdf');
    await file.writeAsBytes(await pdf.save());

    // Show a confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Generated'),
        content: Text(
            'The user report has been generated and saved as: ${file.path}'),
      ),
    );
  }
}
