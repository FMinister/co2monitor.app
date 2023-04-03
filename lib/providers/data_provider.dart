import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import "package:http/http.dart" as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part "data_provider.g.dart";

const String apiUrl = "192.168.178.33:8008";

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

@riverpod
Future<Co2Data> fetchLatestData(FetchLatestDataRef ref) async {
  final url = Uri.http(
    apiUrl,
    "/api/latestData",
  );
  final response = await http.get(url);
  final latestData = latestCo2DataFromJson(response.body);

  return latestData;
}

@riverpod
Future<List<Co2Data>> fetchData(FetchDataRef ref) async {
  final url = Uri.http(
    apiUrl,
    "/api/CO2AndTempDataByHour/6",
  );
  final response = await http.get(url);
  final data = co2DataFromJson(response.body);

  return data;
}

@riverpod
class Data extends _$Data {
  @override
  Future<List<Co2Data>> build() async {
    return await getData();
  }

  Future<List<Co2Data>> getData({int period = 6}) async {
    state = const AsyncValue.loading();
    final url = Uri.http(
      apiUrl,
      "/api/CO2AndTempDataByHour/$period",
    );
    final response = await http.get(url);
    final data = co2DataFromJson(response.body);

    state = AsyncValue.data(data);

    return data;
  }
}

@riverpod
class LatestData extends _$LatestData {
  @override
  Future<Co2Data> build() async {
    return await getLatestData();
  }

  Future<Co2Data> getLatestData() async {
    state = const AsyncValue.loading();
    final url = Uri.http(
      apiUrl,
      "/api/latestData",
    );
    final response = await http.get(url);
    final latestData = latestCo2DataFromJson(response.body);

    state = AsyncValue.data(latestData);

    return latestData;
  }
}

// class DataProvider with ChangeNotifier {
//   List<Co2Data> _data = [];
//   Co2Data _latestData = Co2Data(
//     date: DateTime.now(),
//     temp: 20,
//     co2: 400,
//     location: "Arbeitszimmer",
//   );
//   int _period = 6;

//   DataProvider() {
//     getPeriod();
//   }

//   List<Co2Data> get data {
//     return [..._data];
//   }

//   Co2Data get latestData {
//     return _latestData;
//   }

//   int get period {
//     return _period;
//   }

//   Future<void> setPeriod(int co2Period) async {
//     final prefs = await SharedPreferences.getInstance();
//     _period = co2Period;
//     prefs.setInt("co2Period", co2Period);
//     await fetchAndSetData(period: co2Period);
//     // notifyListeners();
//   }

//   Future<int> getPeriod() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (!prefs.containsKey("co2Period")) {
//       prefs.setInt("co2Period", _period);
//     } else {
//       _period = prefs.getInt("co2Period")!;
//     }

//     return _period;
//   }

//   Future<void> fetchAndSetData({int period = 6}) async {
//     final url = Uri.http(
//       "192.168.178.33:8008",
//       "/api/CO2AndTempDataByHour/$_period",
//     );
//     try {
//       final response = await http.get(url);
//       _data = co2DataFromJson(response.body);
//       notifyListeners();
//     } catch (error) {
//       _data = [];
//       rethrow;
//     }
//   }
//     try {
//       final response = await http.get(url);
//       _latestData = latestCo2DataFromJson(response.body);
//       _data.add(_latestData);
//       notifyListeners();
//     } catch (error) {
//       _data = [];
//       rethrow;
//     }
//   }
// }

//   Future<void> fetchLatestData() async {
//     final url = Uri.http(
//       "192.168.178.33:8008",
//       "/api/latestData",
//     );
//     try {
//       final response = await http.get(url);
//       _latestData = latestCo2DataFromJson(response.body);
//       notifyListeners();
//     } catch (error) {
//       _data = [];
//       rethrow;
//     }
//   }

//   Future<void> fetchLatestDataEveryMinute() async {
//     final url = Uri.http(
//       "192.168.178.33:8008",
//       "/api/latestData",
//     );
//     try {
//       final response = await http.get(url);
//       _latestData = latestCo2DataFromJson(response.body);
//       _data.add(_latestData);
//       notifyListeners();
//     } catch (error) {
//       _data = [];
//       rethrow;
//     }
//   }
// }
