import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import "package:http/http.dart" as http;

List<Co2Data> co2DataFromJson(String str) =>
    List<Co2Data>.from(json.decode(str).map((x) => Co2Data.fromJson(x)));

Co2Data latestCo2DataFromJson(String str) => Co2Data.fromJson(json.decode(str));

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

class DataProvider with ChangeNotifier {
  List<Co2Data> _data = [];
  Co2Data _latestData = Co2Data(
    date: DateTime.now(),
    temp: 20,
    co2: 400,
    location: "Arbeitszimmer",
  );

  List<Co2Data> get data {
    return [..._data];
  }

  Co2Data get latestData {
    return _latestData;
  }

  Future<void> fetchAndSetData() async {
    final url = Uri.http(
      "192.168.178.33:8008",
      "/api/CO2AndTempDataByHour/12",
    );
    try {
      final response = await http.get(url);
      _data = co2DataFromJson(response.body);
      notifyListeners();
    } catch (error) {
      _data = [];
      rethrow;
    }
  }

  Future<void> fetchLatestData() async {
    final url = Uri.http(
      "192.168.178.33:8008",
      "/api/latestData",
    );
    try {
      final response = await http.get(url);
      _latestData = latestCo2DataFromJson(response.body);
      notifyListeners();
    } catch (error) {
      _data = [];
      rethrow;
    }
  }

  Future<void> fetchLatestDataEveryMinute() async {
    final url = Uri.http(
      "192.168.178.33:8008",
      "/api/latestData",
    );
    try {
      final response = await http.get(url);
      _latestData = latestCo2DataFromJson(response.body);
      _data.add(_latestData);
      notifyListeners();
    } catch (error) {
      _data = [];
      rethrow;
    }
  }
}
