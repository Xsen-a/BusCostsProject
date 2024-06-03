import 'package:flutter/material.dart';
import 'package:bus_costs/ui/widgets/bus_info.dart';
import 'add_bus.dart';

class BusesPage extends StatefulWidget {
  const BusesPage({super.key, required this.title});
  final String title;
  @override
  State<BusesPage> createState() => _BusesPageState(title: title);
}

class _BusesPageState extends State<BusesPage> {
  String title;
  _BusesPageState({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0FEFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFB3E9F5),
        title: Text(widget.title),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddBusPage(title: 'Добавить маршрут')));
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width - 200,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: Color(0xFF96E0F0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Добавить маршрут',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF123A43),
                            fontSize: 14,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w800,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  BusWidget(
                      bus_number: '17',
                      trip_cost: '50',
                      trip_color: 0xFFFF604A),
                  BusWidget(
                      bus_number: '6',
                      trip_cost: '38',
                      trip_color: 0xFF9EFFB9)
                ],
              ))),
    );
  }
}