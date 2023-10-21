import 'dart:async';
import 'dart:convert';

import 'package:co2app/providers/init_provider.dart';
import 'package:co2app/providers/period_provider.dart';
import "package:http/http.dart" as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "data_provider.g.dart";

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

  final DateTime date;
  final double temp;
  final int co2;
  final int location;

  factory Co2Data.fromRawJson(String str) => Co2Data.fromJson(json.decode(str));

  factory Co2Data.fromJson(Map<String, dynamic> json) => Co2Data(
        date: DateTime.parse(json["created_at"]).toLocal(),
        temp: json["temp"]?.toDouble(),
        co2: json["co2"],
        location: json["location_id"],
      );
}

@riverpod
class Data extends _$Data {
  @override
  Future<List<Co2Data>> build() async {
    return await getData();
  }

  Future<List<Co2Data>> getData() async {
    final period = await ref
        .watch(periodNotifierProvider.selectAsync((data) => data.period));
    final apiUrl =
        await ref.watch(initStateProvider.selectAsync((data) => data.apiUrl));
    final apiKey =
        await ref.watch(initStateProvider.selectAsync((data) => data.apiKey));
    state = const AsyncValue.loading();
    if (apiUrl == "" || apiKey == "") {
      state = const AsyncValue.data([]);
      return [];
    }
    try {
      final url = Uri.parse(
        "$apiUrl/api/co2data/1/search?period=${period}h",
      );
      final response = await http.get(url, headers: {
        "X-API-KEY": apiKey,
      });
      final data = co2DataFromJson(response.body);

      state = AsyncValue.data(data);

      return data;
    } catch (err) {
      state = AsyncError(err, StackTrace.current);

      rethrow;
    }
  }

  Future<void> updateData(Co2Data latestData) async {
    state = const AsyncValue.loading();
    state.value!.removeAt(0);
    state = AsyncValue.data([...state.value!, latestData]);
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
    final apiUrl =
        await ref.watch(initStateProvider.selectAsync((data) => data.apiUrl));
    final apiKey =
        await ref.watch(initStateProvider.selectAsync((data) => data.apiKey));
    final url = Uri.parse(
      "$apiUrl/api/co2data/1/latest",
    );
    if (apiUrl == "" || apiKey == "") {
      state = AsyncValue.data(Co2Data(
        date: DateTime.now(),
        temp: 0,
        co2: 0,
        location: 0,
      ));
      return Co2Data(
        date: DateTime.now(),
        temp: 0,
        co2: 0,
        location: 0,
      );
    }
    try {
      final response = await http.get(url, headers: {
        "X-API-KEY": apiKey,
      });
      final latestData = latestCo2DataFromJson(response.body);

      state = AsyncValue.data(latestData);

      return latestData;
    } catch (err) {
      state = AsyncError(err, StackTrace.current);

      rethrow;
    }
  }

  Future<Co2Data> updateLatestData() async {
    state = const AsyncValue.loading();
    final apiUrl =
        await ref.watch(initStateProvider.selectAsync((data) => data.apiUrl));
    final apiKey =
        await ref.watch(initStateProvider.selectAsync((data) => data.apiKey));
    final url = Uri.parse(
      "$apiUrl/api/co2data/1/latest",
    );
    if (apiUrl == "" || apiKey == "") {
      state = AsyncValue.data(Co2Data(
        date: DateTime.now(),
        temp: 0,
        co2: 0,
        location: 0,
      ));
      return Co2Data(
        date: DateTime.now(),
        temp: 0,
        co2: 0,
        location: 0,
      );
    }
    try {
      final response = await http.get(url, headers: {
        "X-API-KEY": apiKey,
      });
      final latestData = latestCo2DataFromJson(response.body);

      state = AsyncValue.data(latestData);

      return latestData;
    } catch (err) {
      state = AsyncError(err, StackTrace.current);

      rethrow;
    }
  }
}
