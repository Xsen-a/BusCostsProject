import 'package:flutter/material.dart';
import 'screens/buses.dart';
import 'screens/statistics.dart';
import 'screens/trips.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'database.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Создай базу данных перед запуском приложения:
  await createDatabase();

  runApp(const BusApp());
}

class BusApp extends StatelessWidget {
  const BusApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    createDatabase();
    return MaterialApp(
      title: 'Мои поездки',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFB3E9F5)),
        useMaterial3: true,
      ),
      home: const MainScreen(selectedIndex: 1),
    );
  }
}

class MainScreen extends StatefulWidget {
  final int selectedIndex;
  const MainScreen({super.key, required this.selectedIndex});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int currentSelectedIndex = 1;

  Color navBarColor = Color(0xFFB3E9F5);

  @override
  void initState() {
    super.initState();
    currentSelectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      currentSelectedIndex = index;
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
        body: _pages[currentSelectedIndex],
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
          currentIndex: currentSelectedIndex,
          onTap: _onItemTapped,
          backgroundColor: navBarColor,
        ),
      ),
    );
  }
}