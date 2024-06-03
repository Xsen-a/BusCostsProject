import 'package:bus_costs/controllers/get_trips.dart';
import 'package:bus_costs/ui/widgets/trip.dart';
import 'package:flutter/material.dart';

// Нужно вернуть в Future Builder список виджетов (???)

Future<List<Widget>> getTripsWidgets() async {
  List<Map<String, dynamic>> trips = await getTripsList();
  Map<String, List<String>> tripData = {};
  List<Widget> tripsWidgetList = [];

  // Получение данных о поездке
  for (var trip in trips) {
    print(trip);
    Map<String, dynamic> busName = await getBusNumber(trip["bus_id"]);
    Map<String, dynamic> busColor = await getBusColor(trip["bus_id"]);
    String colorValue = busColor["bus_color"].toString().replaceAll("#", "0xFF");
    print(colorValue);
    tripData.addAll({
      trip["trip_id"].toString(): [
        busName.toString(),
        trip["trip_date"],
        trip["trip_time"],
        trip["bus_cost"],
        colorValue
      ]
    });
  }

  // Формирование списка виджетов
  for (var element in tripData.entries) {
    tripsWidgetList.add(TripWidget(
        bus_number: element.value[0],
        trip_date: element.value[1],
        trip_time: element.value[2],
        trip_cost: element.value[3],
        trip_color: int.parse(element.value[4])));
  }
  return tripsWidgetList;
  //return [TripWidget(bus_number: '17', trip_date: '2024-02-06', trip_time: '17:02', trip_cost: '50', trip_color: 0xFFFF604A)];
}


