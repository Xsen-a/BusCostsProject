import 'package:flutter/material.dart';
import 'screens/buses.dart';
import 'screens/statistics.dart';
import 'screens/trips.dart';
import 'package:flutter_svg/flutter_svg.dart';


void main() {
  runApp(const BusApp());
}

class BusApp extends StatelessWidget {
  const BusApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A for dictation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFB3E9F5)),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;
  Color navBarColor = Color(0xFFB3E9F5);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      StatisticsPage(title: 'Статистика'),
      TripsPage(title: 'Мои поездки'),
      BusesPage(title: 'Мои маршруты'),
    ];

    return MaterialApp(
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/stats.svg"),
                label: 'Статистика'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/home.svg"),
                label: 'Поездки'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/buses.svg"),
                label: 'Транспорт'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: navBarColor,
        ),
      ),
    );
  }
}