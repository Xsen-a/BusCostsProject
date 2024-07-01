import 'package:bus_costs/controllers/get_trips.dart';
import 'package:bus_costs/ui/widgets/trip.dart';
import 'package:flutter/material.dart';

// Нужно вернуть в Future Builder список виджетов (???)

Future<List<Widget>> getTripsWidgets() async {
  List<Map<String, dynamic>> trips = await getTripsList();
  List<Widget> tripsWidgetList = [];

  // Получение данных о поездке
  for (var trip in trips) {
    Map<String, dynamic> busName = await getBusNumber(trip["bus_id"]);
    Map<String, dynamic> busColor = await getBusColor(trip["bus_id"]);
    String colorValue = busColor["bus_color"].toString().replaceAll("#", "0xFF");
    tripsWidgetList.add(TripWidget(
        bus_number: busName.values.first.toString(),
        trip_date: trip["trip_date"],
        trip_time: trip["trip_time"],
        trip_cost: trip["bus_cost"],
        trip_color: int.parse(colorValue)));
  }
  return tripsWidgetList;
}


