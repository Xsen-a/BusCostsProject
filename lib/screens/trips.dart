import 'package:flutter/material.dart';
import 'add_trip.dart';
import 'package:bus_costs/modules/get_trips_widgets.dart';
import 'package:bus_costs/ui/widgets/trip.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({super.key, required this.title});

  final String title;

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF0FEFF),
        appBar: AppBar(
          backgroundColor: Color(0xFFB3E9F5),
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddTripPage(
                                title: 'Добавить поездку',
                                tripDate: '',
                                tripTime: '',
                                ticketStatus: false,
                                busId: '',
                                busCost: '',
                                updateStatus: false)));
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
                    child: const Text(
                      'Добавить поездку',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF123A43),
                        fontSize: 14,
                        //fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        height: 0,
                      ),
                    ),
                  ),
                )),
            FutureBuilder<List<Widget>>(
              future: getTripsWidgets(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  List<Widget> tripsWidgetsList = snapshot.data!;
                  return Expanded(
                      child: Container(
                          child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: tripsWidgetsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return tripsWidgetsList[index];
                    },
                  )));
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Ошибка при загрузке данных'),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        )));
  }
}
