import 'package:flutter/material.dart';

class BusWidget extends StatelessWidget {
  final String bus_number;
  final String trip_cost;
  final int trip_color;

  BusWidget(
      {required this.bus_number,
      required this.trip_cost,
      required this.trip_color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
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
              width: 70,
              height: 80,
              alignment: Alignment.center,
              child: Text(
                bus_number,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF123A43),
                  fontSize: 30,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: Color(trip_color),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                trip_cost,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF1E1E1E),
                  fontSize: 30,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w800,
                  height: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
