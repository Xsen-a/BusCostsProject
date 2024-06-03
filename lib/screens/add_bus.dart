import 'package:flutter/material.dart';
import 'package:bus_costs/ui/widgets/trip.dart';

class AddBusPage extends StatefulWidget {
  const AddBusPage({super.key, required this.title});

  final String title;

  @override
  State<AddBusPage> createState() => _AddBusPageState();
}

class _AddBusPageState extends State<AddBusPage> {
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
