import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part "period_provider.g.dart";
part "period_provider.freezed.dart";

const String prefKey = "co2Period";

@freezed
class Period with _$Period {
  factory Period({
    required int period,
  }) = _Period;
}

@riverpod
class PeriodNotifier extends _$PeriodNotifier {
  @override
  Future<Period> build() async {
    return await getPeriod();
  }

  Future<Period> getPeriod() async {
    state = const AsyncValue.loading();
    var period = Period(period: 6);
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(prefKey)) {
      prefs.setInt(prefKey, period.period);
    } else {
      period = Period(period: prefs.getInt(prefKey)!);
    }
    state = AsyncValue.data(period);

    return period;
  }

  Future<void> setPeriod(int periodToSet) async {
    state = const AsyncValue.loading();
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(prefKey, periodToSet);
    state = AsyncValue.data(Period(period: periodToSet));
  }
}
