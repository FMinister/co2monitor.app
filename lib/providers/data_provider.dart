import 'dart:convert';

import 'package:flutter/material.dart';

import "package:http/http.dart" as http;

List<Co2Data> co2DataFromJson(String str) =>
    List<Co2Data>.from(json.decode(str).map((x) => Co2Data.fromJson(x)));

class Co2Data {
  Co2Data({
    required this.date,
    required this.temp,
    required this.co2,
    required this.location,
  });

  DateTime date;
  double temp;
  int co2;
  String location;

  factory Co2Data.fromJson(Map<String, dynamic> json) => Co2Data(
        date: DateTime.parse(json["Date"]),
        temp: json["Temp"]?.toDouble(),
        co2: json["CO2"],
        location: json["Location"],
      );
}

class Data with ChangeNotifier {
  Data(this._data);

  List<Co2Data> _data = [];

  List<Co2Data> get data {
    return [..._data].reversed.toList();
  }

  Future<void> fetchAndSetData() async {
    final url = Uri.http(
      "http://192.168.178.33:8008",
      "/api/CO2AndTempDataByDays/1",
    );
    try {
      final response = await http.get(url);
      _data = co2DataFromJson(response.body);

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
