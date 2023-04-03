// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchLatestDataHash() => r'0727a374cf1c9f518e6a7a2ade23af30b611660a';

/// See also [fetchLatestData].
@ProviderFor(fetchLatestData)
final fetchLatestDataProvider = AutoDisposeFutureProvider<Co2Data>.internal(
  fetchLatestData,
  name: r'fetchLatestDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchLatestDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchLatestDataRef = AutoDisposeFutureProviderRef<Co2Data>;
String _$fetchDataHash() => r'fcf08b7e97a190dd254408e5d0ecb08e28c2fd5e';

/// See also [fetchData].
@ProviderFor(fetchData)
final fetchDataProvider = AutoDisposeFutureProvider<List<Co2Data>>.internal(
  fetchData,
  name: r'fetchDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fetchDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchDataRef = AutoDisposeFutureProviderRef<List<Co2Data>>;
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
