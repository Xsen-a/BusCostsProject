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
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // указываем количество колонок
          ),
          itemCount: 4, // общее количество ячеек
          itemBuilder: (BuildContext context, int index) {
            if (index == 1) {
              return GridTile(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.blue,
                        child: Center(child: Text('Ячейка 1')),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.blue,
                        child: Center(child: Text('Ячейка 2')),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                color: Colors.blue,
                child: Center(child: Text('Ячейка $index')),
              );
            }
          },
        ));
  }
}
