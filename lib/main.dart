import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpeedDashboard(),
    );
  }
}

class SpeedDashboard extends StatefulWidget {
  const SpeedDashboard({super.key});

  @override
  _SpeedDashboardState createState() => _SpeedDashboardState();
}

class _SpeedDashboardState extends State<SpeedDashboard> {
  double _speed = 66;
  double _fuel = 43;
  double _battery = 8;
  double _range = 157;

  void _updateSpeed(double speed) {
    setState(() {
      _speed = speed;
      _fuel = 43 - (_speed / 4);
      _battery = 8 - (_speed / 20);
      _range = 157 - (_speed / 2);

      if (_fuel < 0) _fuel = 0;
      if (_battery < 0) _battery = 0;
      if (_range < 0) _range = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2F41),
      body: Column(
        children: [

          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Tesla Model 3',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Image.network(
                  'https://static.vecteezy.com/system/resources/previews/048/936/011/non_2x/ai-generated-a-white-tesla-model-3-car-free-png.png',
                  height: 320,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[800],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCircleData('🛢️ Fuel', '${_fuel.toStringAsFixed(0)}%'),
                        _buildCircleData('⚡ Battery', '${_battery.toStringAsFixed(0)}%'),
                        _buildCircleData('🗺️ Range', '${_range.toStringAsFixed(0)} km'),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${_speed.toStringAsFixed(0)} km/h',
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 8,
                              ),
                              overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 14,
                              ),
                              activeTrackColor: Colors.white,
                              inactiveTrackColor: Colors.blueGrey[500],
                              thumbColor: Colors.white,
                              trackHeight: 2,
                            ),
                            child: Slider(
                              value: _speed,
                              min: 0,
                              max: 180,
                              divisions: 180,
                              label: _speed.toStringAsFixed(0),
                              onChanged: _updateSpeed,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleData(String title, String value) {
    return Column(
      children: [
        Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueGrey[700],
          ),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          style: const TextStyle(fontSize: 16, color: Colors.white70),
          title,
        ),
      ],
    );
  }
}
