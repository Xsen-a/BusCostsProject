import 'package:flutter/material.dart';
import 'package:bus_costs/screens/add_bus.dart';

class BusWidget extends StatelessWidget {
  final String bus_number;
  final String bus_type;
  final String trip_cost;
  final String trip_color;
  final String id;

  BusWidget({
    required this.bus_number,
    required this.bus_type,
    required this.trip_cost,
    required this.trip_color,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    String formatted_color;
    if (trip_color.length != 10)
      formatted_color = trip_color.replaceAll("#", "0xFF");
    else
      formatted_color = trip_color;

    int value;
    if (bus_type == "А")
      value = 1;
    else
      value = 2;

    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddBusPage(
                        title: 'Редактировать маршрут',
                        value: value,
                        busTypeStr: bus_type,
                        chosenColor: trip_color,
                        currentBusNumber: bus_number,
                        currentCost: trip_cost,
                        id: id,
                        updateStatus: true,
                      )));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          width: MediaQuery.of(context).size.width - 40,
          height: 80,
          decoration: ShapeDecoration(
            color: Color(0xFFB3E8F4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            bus_number,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF123A43),
                              fontSize: 30,
                              //fontFamily: 'Nunito',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            bus_type,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF123A43),
                              fontSize: 30,
                              //fontFamily: 'Nunito',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: Color(int.parse(formatted_color)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    trip_cost,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 30,
                      //fontFamily: 'Nunito',
                      fontWeight: FontWeight.w800,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
