// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Co2Data _$Co2DataFromJson(Map<String, dynamic> json) {
  return _Co2Data.fromJson(json);
}

/// @nodoc
mixin _$Co2Data {
  DateTime get date => throw _privateConstructorUsedError;
  double get temp => throw _privateConstructorUsedError;
  int get co2 => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $Co2DataCopyWith<Co2Data> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Co2DataCopyWith<$Res> {
  factory $Co2DataCopyWith(Co2Data value, $Res Function(Co2Data) then) =
      _$Co2DataCopyWithImpl<$Res, Co2Data>;
  @useResult
  $Res call({DateTime date, double temp, int co2, String location});
}

/// @nodoc
class _$Co2DataCopyWithImpl<$Res, $Val extends Co2Data>
    implements $Co2DataCopyWith<$Res> {
  _$Co2DataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? temp = null,
    Object? co2 = null,
    Object? location = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as double,
      co2: null == co2
          ? _value.co2
          : co2 // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_Co2DataCopyWith<$Res> implements $Co2DataCopyWith<$Res> {
  factory _$$_Co2DataCopyWith(
          _$_Co2Data value, $Res Function(_$_Co2Data) then) =
      __$$_Co2DataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime date, double temp, int co2, String location});
}

/// @nodoc
class __$$_Co2DataCopyWithImpl<$Res>
    extends _$Co2DataCopyWithImpl<$Res, _$_Co2Data>
    implements _$$_Co2DataCopyWith<$Res> {
  __$$_Co2DataCopyWithImpl(_$_Co2Data _value, $Res Function(_$_Co2Data) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? temp = null,
    Object? co2 = null,
    Object? location = null,
  }) {
    return _then(_$_Co2Data(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as double,
      co2: null == co2
          ? _value.co2
          : co2 // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Co2Data implements _Co2Data {
  _$_Co2Data(
      {required this.date,
      required this.temp,
      required this.co2,
      required this.location});

  factory _$_Co2Data.fromJson(Map<String, dynamic> json) =>
      _$$_Co2DataFromJson(json);

  @override
  final DateTime date;
  @override
  final double temp;
  @override
  final int co2;
  @override
  final String location;

  @override
  String toString() {
    return 'Co2Data(date: $date, temp: $temp, co2: $co2, location: $location)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Co2Data &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.temp, temp) || other.temp == temp) &&
            (identical(other.co2, co2) || other.co2 == co2) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, temp, co2, location);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_Co2DataCopyWith<_$_Co2Data> get copyWith =>
      __$$_Co2DataCopyWithImpl<_$_Co2Data>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_Co2DataToJson(
      this,
    );
  }
}

abstract class _Co2Data implements Co2Data {
  factory _Co2Data(
      {required final DateTime date,
      required final double temp,
      required final int co2,
      required final String location}) = _$_Co2Data;

  factory _Co2Data.fromJson(Map<String, dynamic> json) = _$_Co2Data.fromJson;

  @override
  DateTime get date;
  @override
  double get temp;
  @override
  int get co2;
  @override
  String get location;
  @override
  @JsonKey(ignore: true)
  _$$_Co2DataCopyWith<_$_Co2Data> get copyWith =>
      throw _privateConstructorUsedError;
}
