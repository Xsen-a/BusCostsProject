import 'dart:async';
import 'package:bus_costs/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:bus_costs/ui/widgets/preview_widget.dart';
import 'package:bus_costs/controllers/add_bus.dart';
import 'package:bus_costs/controllers/update_bus.dart';
import 'package:bus_costs/controllers/get_trips.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

class AddTripPage extends StatefulWidget {
  final String tripDate;
  final String tripTime;
  final bool ticketStatus;
  final String busId;
  final String busCost;
  final bool updateStatus;
  final String title;
  const AddTripPage(
      {super.key,
      required this.title,
      required this.tripDate,
      required this.tripTime,
      required this.ticketStatus,
      required this.busId,
      required this.busCost,
      required this.updateStatus});

  @override
  State<AddTripPage> createState() => _AddBusPageState();
}

Color normalBorder = Color(0xFF123A43);
Color errorBorder = Color(0xFFF15C5C);
Color textFieldBorderColorCost = normalBorder;
Color textFieldBorderColorNumber = normalBorder;
Color backgroundNormalColor = Color(0xFFB3E8F4);
Color backgroundErrorColor = Color(0xFFDA7A7A);
Color textFieldBackgroundColorNumber = backgroundNormalColor;
Color textFieldBackgroundColorCost = backgroundNormalColor;

class Bus {
  final String number;
  const Bus(this.number);

  @override
  String toString() {
    return number;
  }
}

class _AddBusPageState extends State<AddTripPage> {
  // late String tripDate;
  // late String tripTime;
  // late String ticketStatus;
  // late String busId;
  // late String busCost;
  // late bool updateStatus;
  // late String title;
  late bool ticketStatus = false;
  late int value = 1;
  late String busTypeStr = "А";
  late String chosenColor = "0xFF9800";
  late String currentBusNumber = "";
  late String currentCost = "";
  late String id = "";
  late bool updateStatus = false;
  final numberController = TextEditingController();
  final costController = TextEditingController();

  List<Bus> busNumbers = [Bus("17"), Bus("6"), Bus("17"), Bus("6"), Bus("17"), Bus("6"), Bus("17"), Bus("6")];

  Color hsvColor = Colors.orange;
  HSVColor color = HSVColor.fromColor(Colors.orange);

  void onChanged(HSVColor value) => color = value;

  @override
  void initState() {
    super.initState();
    //value = widget.tripDate;
    busTypeStr = widget.tripTime;
    ticketStatus = widget.ticketStatus;
    currentBusNumber = widget.busId;
    currentCost = widget.busCost;
    updateStatus = widget.updateStatus;
    color = HSVColor.fromColor(Color(int.parse(chosenColor)));
    textFieldBackgroundColorNumber = backgroundNormalColor;
    textFieldBackgroundColorCost = backgroundNormalColor;
    textFieldBorderColorCost = normalBorder;
    textFieldBorderColorNumber = normalBorder;
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: CustomDropdown<Bus>.searchRequest(
              futureRequest: getFormattedBusNumbers,
              hintText: 'Выберите маршрут',
              searchHintText: 'Поиск',
              noResultFoundText: 'Маршрутов не найдено',
              items: busNumbers,
              decoration: CustomDropdownDecoration(
                closedFillColor: textFieldBackgroundColorNumber,
                expandedFillColor: textFieldBackgroundColorNumber,
                listItemStyle: const TextStyle(
                  color: Color(0xFF123A43),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
                searchFieldDecoration: const SearchFieldDecoration(
                  fillColor: Color(0xFFF0FEFF),
                ),
                hintStyle: const TextStyle(
                  color: Color(0xFF123A43),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              onChanged: (value) {
                currentBusNumber = value!.number.toString();
                print(currentBusNumber);
              },
            ),
          ),
          CustomCheckBoxGroup(
            buttonTextStyle: ButtonTextStyle(
              selectedColor: textFieldBackgroundColorNumber,
              unSelectedColor: normalBorder,
              textStyle: const TextStyle(
                fontSize: 18,
              ),
              selectedTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            selectedBorderColor: Color(0xFFF0FEFF),
            unSelectedBorderColor: Color(0xFFF0FEFF),
            unSelectedColor: textFieldBackgroundColorNumber,
            buttonLables: const [
              "Проездной",
            ],
            buttonValuesList: const [
              true,
            ],
            checkBoxButtonValues: (values) {
              print(values);
              ticketStatus = values.first;
            },
            spacing: 0,
            horizontal: false,
            enableButtonWrap: false,
            width: 500,
            absoluteZeroSpacing: false,
            selectedColor: normalBorder,
            padding: 10,
          ),
        ]));
  }
}
