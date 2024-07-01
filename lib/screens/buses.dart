import 'package:bus_costs/modules/get_buses_widgtes.dart';
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
                        child: const Text(
                          'Добавить Маршрут',
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
                  future: getBusesWidgets(),
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
