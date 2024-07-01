import 'package:bus_costs/screens/buses.dart';
import 'package:flutter/material.dart';
import 'package:bus_costs/ui/widgets/trip.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:bus_costs/ui/widgets/bus_info.dart';
import 'package:bus_costs/controllers/add_bus.dart';

class AddBusPage extends StatefulWidget {
  const AddBusPage({super.key, required this.title});

  final String title;

  @override
  State<AddBusPage> createState() => _AddBusPageState();
}

class _AddBusPageState extends State<AddBusPage> {
  HSVColor color = HSVColor.fromColor(Colors.orange);
  void onChanged(HSVColor value) => color = value;
  int _value = 1;
  String busTypeStr = "А";
  String chosenColor = "#FF9800";
  Color hsvColor = Colors.orange;
  String currentBusNumber = "";
  String currentCost = "";
  final numberController = TextEditingController();
  final costController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF0FEFF),
        appBar: AppBar(
          backgroundColor: Color(0xFFB3E9F5),
          title: Text(widget.title),
        ),
        body: Column(children: [
          AutoHeightGridView(
              itemCount: 4,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(12),
              shrinkWrap: true,
              builder: (context, index) {
                if (index == 0) {
                  return Column(children: [
                    const Text(
                      'Номер',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF123A43),
                        fontSize: 20,
                        // fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        height: 2,
                      ),
                    ),
                    TextField(
                      controller: numberController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '',
                      ),
                      onChanged: (_) {
                        setState(() {
                          currentBusNumber = numberController.text;
                        });
                      },
                    )
                  ]);
                }
                if (index == 1) {
                  return Column(children: [
                    const Text(
                      'Стоимость',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF123A43),
                        fontSize: 20,
                        // fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        height: 2,
                      ),
                    ),
                    TextField(
                      controller: costController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '',
                      ),
                      onChanged: (_) {
                        setState(() {
                          currentCost = costController.text;
                        });
                      },
                    )
                  ]);
                }
                if (index == 2) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(
                        'Цвет',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF123A43),
                          fontSize: 20,
                          // fontFamily: 'Nunito',
                          fontWeight: FontWeight.w800,
                          height: 2,
                        ),
                      ),
                      Text(
                        chosenColor,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF123A43),
                          fontSize: 20,
                          // fontFamily: 'Nunito',
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       color: color.toColor()),
                      //   margin:
                      //       EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                      //   width: 200,
                      //   height: 30,
                      // ),
                      PaletteValuePicker(
                          color: color,
                          onChanged: (value) {
                            super.setState(() {
                              onChanged(value);
                              hsvColor = value.toColor();
                              chosenColor =
                                  '#${hsvColor.value.toRadixString(16).substring(2)}';
                            });
                          })
                    ],
                  );
                }
                return Column(children: [
                  const Text(
                    'Тип транспорта',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF123A43),
                      fontSize: 20,
                      // fontFamily: 'Nunito',
                      fontWeight: FontWeight.w800,
                      height: 2,
                    ),
                  ),
                  Container(
                    child: Column(children: [
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _value,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Color(0xFF123A43).withOpacity(.32);
                              }
                              return Color(0xFF123A43);
                            }),
                            onChanged: (_) {
                              setState(() {
                                _value = 1;
                                busTypeStr = "А";
                              });
                            },
                          ),
                          const SizedBox(width: 2.0),
                          const Text(
                            'Автобус',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF123A43),
                              fontSize: 18,
                              // fontFamily: 'Nunito',
                              fontWeight: FontWeight.w800,
                              height: 2,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: _value,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Color(0xFF123A43).withOpacity(.32);
                              }
                              return Color(0xFF123A43);
                            }),
                            onChanged: (_) {
                              setState(() {
                                _value = 2;
                                busTypeStr = "Т";
                              });
                            },
                          ),
                          const SizedBox(width: 2.0),
                          const Text(
                            'Троллейбус',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF123A43),
                              fontSize: 18,
                              // fontFamily: 'Nunito',
                              fontWeight: FontWeight.w800,
                              height: 2,
                            ),
                          )
                        ],
                      )
                    ]),
                  ),
                ]);
              }),
          const Center(
              child: const Text(
            "Превью",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF123A43),
              fontSize: 18,
              // fontFamily: 'Nunito',
              fontWeight: FontWeight.w800,
              height: 2,
            ),
          )),
          BusWidget(
              bus_number: numberController.text,
              bus_type: busTypeStr,
              trip_cost: costController.text,
              trip_color: chosenColor),
          InkWell(
            onTap: () {
              addNewBus(busTypeStr, numberController.text, costController.text, chosenColor);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BusesPage(title: 'Мои маршруты')));
            },
            child: Container(
              margin: EdgeInsets.only(top: 30.0),
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
                'Сохранить',
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
          )
        ]));
  }
}
