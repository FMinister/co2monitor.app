// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Co2Data _$$_Co2DataFromJson(Map<String, dynamic> json) => _$_Co2Data(
      date: DateTime.parse(json['date'] as String),
      temp: (json['temp'] as num).toDouble(),
      co2: json['co2'] as int,
      location: json['location'] as String,
    );

Map<String, dynamic> _$$_Co2DataToJson(_$_Co2Data instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'temp': instance.temp,
      'co2': instance.co2,
      'location': instance.location,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dataHash() => r'e2531c0041c659050660617f6b68bf92c70d6fb1';

/// See also [Data].
@ProviderFor(Data)
final dataProvider =
    AutoDisposeAsyncNotifierProvider<Data, List<Co2Data>>.internal(
  Data.new,
  name: r'dataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Data = AutoDisposeAsyncNotifier<List<Co2Data>>;
String _$latestDataHash() => r'995924f2856d36191712709e23e602571a49919c';

/// See also [LatestData].
@ProviderFor(LatestData)
final latestDataProvider =
    AutoDisposeAsyncNotifierProvider<LatestData, Co2Data>.internal(
  LatestData.new,
  name: r'latestDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$latestDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LatestData = AutoDisposeAsyncNotifier<Co2Data>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
