// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dataHash() => r'e9d55ae3980aa3ce2e9a45f87d8d0ac1c14e34ec';

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
String _$latestDataHash() => r'55c086ad1697142a800d68a518057a4068293b02';

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
