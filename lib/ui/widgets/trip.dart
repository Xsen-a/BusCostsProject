import 'package:flutter/material.dart';

class TripWidget extends StatelessWidget {
  final String bus_number;
  final String trip_date;
  final String trip_time;
  final String trip_cost;
  final int trip_color;

  TripWidget(
      {super.key, required this.bus_number,
      required this.trip_date,
      required this.trip_time,
      required this.trip_cost,
      required this.trip_color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: ShapeDecoration(
        color: const Color(0xFFB3E8F4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 70,
            height: 60,
            alignment: Alignment.center,
            child: Text(
              bus_number,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF123A43),
                fontSize: 24,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                width: 80,
                height: 60,
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      trip_date,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Color(0xFF316570),
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        height: 0,
                      ),
                    ),
                    Text(
                      trip_time,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Color(0xFF316570),
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 80,
            height: 60,
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
              style: const TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: 20,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w800,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
