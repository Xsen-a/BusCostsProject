import 'package:bus_costs/controllers/get_buses.dart';
import 'package:bus_costs/controllers/get_trips.dart';
import 'package:bus_costs/ui/widgets/bus_info.dart';
import 'package:bus_costs/ui/widgets/trip.dart';
import 'package:flutter/material.dart';

// Нужно вернуть в Future Builder список виджетов (???)

Future<List<Widget>> getBusesWidgets() async {
  List<Map<String, dynamic>> buses = await getBusesList();
  List<Widget> busesWidgetList = [];

  // Получение данных о поездке
  for (var bus in buses) {
    String colorValue = bus["bus_color"].toString().replaceAll("#", "0xFF");
    String bus_type_str;
    if (bus["bus_type"] == 1) {
      bus_type_str = "А";
    } else {
      bus_type_str = "Т";
    }
    busesWidgetList.add(
      BusWidget(
          bus_number: bus["bus_num"],
          bus_type: bus_type_str,
          trip_cost: bus["bus_cost"],
          trip_color: colorValue,
          id: bus["bus_id"].toString()),
    );
  }
  return busesWidgetList;
}
