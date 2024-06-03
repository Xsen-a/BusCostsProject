import 'package:flutter/material.dart';
import 'package:bus_costs/ui/widgets/trip.dart';

class AddTripPage extends StatefulWidget {
  const AddTripPage({super.key, required this.title});

  final String title;

  @override
  State<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF0FEFF),
        appBar: AppBar(
          backgroundColor: Color(0xFFB3E9F5),
          title: Text(widget.title),
        ));
  }
}
