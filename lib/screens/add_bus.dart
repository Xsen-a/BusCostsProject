import 'dart:async';
import 'package:bus_costs/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:bus_costs/ui/widgets/preview_widget.dart';
import 'package:bus_costs/controllers/add_bus.dart';
import 'package:bus_costs/controllers/update_bus.dart';
import 'package:bus_costs/controllers/delete_bus.dart';
import 'package:flash/flash.dart';

class AddBusPage extends StatefulWidget {
  final int value;
  final String busTypeStr;
  final String chosenColor;
  final String currentBusNumber;
  final String currentCost;
  final String id;
  final bool updateStatus;
  final String title;
  const AddBusPage(
      {super.key,
      required this.title,
      required this.value,
      required this.busTypeStr,
      required this.chosenColor,
      required this.currentBusNumber,
      required this.currentCost,
      required this.id,
      required this.updateStatus});

  @override
  State<AddBusPage> createState() => _AddBusPageState();
}

Color normalBorder = Color(0xFF123A43);
Color errorBorder = Color(0xFFF15C5C);
Color textFieldBorderColorCost = normalBorder;
Color textFieldBorderColorNumber = normalBorder;
Color backgroundNormalColor = Color(0xFFB3E8F4);
Color backgroundErrorColor = Color(0xFFDA7A7A);
Color textFieldBackgroundColorNumber = backgroundNormalColor;
Color textFieldBackgroundColorCost = backgroundNormalColor;
String errorMessage = 'Такой маршрут уже существует';

final snackbar = SnackBar(
  duration: Duration(seconds: 3),
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  backgroundColor: backgroundErrorColor,
  content: Text(
    errorMessage,
    style: TextStyle(
      color: normalBorder,
      fontSize: 18,
      //fontFamily: 'Nunito',
      fontWeight: FontWeight.w800,
      height: 0,
    ),
  ),
);

Widget submitWidget(updateStatus, busTypeStr, busNumber, busCost, chosenColor,
    busId, context, Function errorColorTextField) {
  if (updateStatus) {
    return Column(children: [
      InkWell(
        onTap: () async {
          errorColorTextField(busCost, busNumber);
          if (double.tryParse(busCost.replaceAll(",", ".")) != null &&
              busNumber.replaceAll(" ", "") != "") {
            bool isCurrentBus = await checkBusExistenceUpdate(busNumber, busTypeStr, busId);
            if (isCurrentBus) {
              updateBus(busTypeStr, busNumber, busCost, chosenColor, busId);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreen(
                            selectedIndex: 2,
                          )));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          }
        },
        child: Container(
          margin: EdgeInsets.only(top: 10.0),
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
      ),
      InkWell(
        onTap: () {
          deleteBus(busId);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MainScreen(
                        selectedIndex: 2,
                      )));
        },
        child: Container(
          margin: EdgeInsets.only(top: 5.0),
          height: 40,
          width: MediaQuery.of(context).size.width - 200,
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            color: Color(0xFFF15C5C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            'Удалить',
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
      ),
    ]);
  } else {
    return InkWell(
      onTap: () async {
        errorColorTextField(busCost, busNumber);
        if (double.tryParse(busCost.replaceAll(",", ".")) != null &&
            busNumber.replaceAll(" ", "") != "") {
          bool busExists = await checkBusExistence(busNumber, busTypeStr);
          if (!busExists) {
            addNewBus(busTypeStr, busNumber, busCost, chosenColor);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 5),
              content: Text('error message'),
            ));
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MainScreen(
                          selectedIndex: 2,
                        )));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
        }
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
          'Добавить',
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
    );
  }
}

class _AddBusPageState extends State<AddBusPage> {
  late int value = 1;
  late String busTypeStr = "А";
  late String chosenColor = "0xFF9800";
  late String currentBusNumber = "";
  late String currentCost = "";
  late String id = "";
  late bool updateStatus = false;
  final numberController = TextEditingController();
  final costController = TextEditingController();

  Color hsvColor = Colors.orange;
  HSVColor color = HSVColor.fromColor(Colors.orange);

  void onChanged(HSVColor value) => color = value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
    busTypeStr = widget.busTypeStr;
    chosenColor = widget.chosenColor;
    currentBusNumber = widget.currentBusNumber;
    currentCost = widget.currentCost;
    numberController.text = widget.currentBusNumber;
    costController.text = widget.currentCost;
    color = HSVColor.fromColor(Color(int.parse(chosenColor)));
    updateStatus = widget.updateStatus;
    id = widget.id;
    textFieldBackgroundColorNumber = backgroundNormalColor;
    textFieldBackgroundColorCost = backgroundNormalColor;
    textFieldBorderColorCost = normalBorder;
    textFieldBorderColorNumber = normalBorder;
  }

  void errorColorTextField(busCost, busNumber) {
    if (double.tryParse(busCost.replaceAll(",", ".")) == null) {
      setState(() {
        textFieldBorderColorCost = errorBorder;
        textFieldBackgroundColorCost = backgroundErrorColor;
      });
      Timer(Duration(seconds: 3), () {
        setState(() {
          textFieldBorderColorCost = normalBorder;
          textFieldBackgroundColorCost = backgroundNormalColor;
        });
      });
    }
    if (busNumber.replaceAll(" ", "") == "") {
      setState(() {
        textFieldBorderColorNumber = errorBorder;
        textFieldBackgroundColorNumber = backgroundErrorColor;
      });
      Timer(Duration(seconds: 3), () {
        setState(() {
          textFieldBorderColorNumber = normalBorder;
          textFieldBackgroundColorNumber = backgroundNormalColor;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF0FEFF),
        appBar: AppBar(
          backgroundColor: Color(0xFFB3E9F5),
          title: Text(widget.title),
        ),
        body: Column(children: [
          Center(
              child: Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: Text(
                    "Превью",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF123A43),
                      fontSize: 20,
                      // fontFamily: 'Nunito',
                      fontWeight: FontWeight.w800,
                      height: 2,
                    ),
                  ))),
          PreviewWidget(
              bus_number: numberController.text,
              bus_type: busTypeStr,
              trip_cost: costController.text,
              trip_color: chosenColor,
              id: ""),
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
                      cursorColor: normalBorder,
                      style: TextStyle(
                          color: normalBorder,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: textFieldBackgroundColorNumber,
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                          hintText: '',
                          hintStyle: TextStyle(color: normalBorder),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: textFieldBorderColorNumber,
                                  width: 2.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: textFieldBorderColorNumber,
                                  width: 2.0))),
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
                      cursorColor: normalBorder,
                      style: TextStyle(
                          color: normalBorder,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: textFieldBackgroundColorCost,
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                          hintText: '',
                          hintStyle: TextStyle(color: normalBorder),
                          enabledBorder: OutlineInputBorder(
                              // Установка границы
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: textFieldBorderColorCost, width: 2.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: textFieldBorderColorCost,
                                  width: 2.0))),
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
                            groupValue: value,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Color(0xFF123A43).withOpacity(.32);
                              }
                              return Color(0xFF123A43);
                            }),
                            onChanged: (_) {
                              setState(() {
                                value = 1;
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
                            groupValue: value,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Color(0xFF123A43).withOpacity(.32);
                              }
                              return Color(0xFF123A43);
                            }),
                            onChanged: (_) {
                              setState(() {
                                value = 2;
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
          submitWidget(
              updateStatus,
              busTypeStr,
              numberController.text,
              costController.text,
              chosenColor,
              id,
              context,
              errorColorTextField),
        ]));
  }
}
