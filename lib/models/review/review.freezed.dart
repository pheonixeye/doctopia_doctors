// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return _Review.fromJson(json);
}

/// @nodoc
mixin _$Review {
  String get username => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get doc_reply => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  int get stars => throw _privateConstructorUsedError;
  int get waiting_time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReviewCopyWith<Review> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewCopyWith<$Res> {
  factory $ReviewCopyWith(Review value, $Res Function(Review) then) =
      _$ReviewCopyWithImpl<$Res, Review>;
  @useResult
  $Res call(
      {String username,
      String phone,
      String doc_reply,
      String body,
      String date,
      int stars,
      int waiting_time});
}

/// @nodoc
class _$ReviewCopyWithImpl<$Res, $Val extends Review>
    implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? phone = null,
    Object? doc_reply = null,
    Object? body = null,
    Object? date = null,
    Object? stars = null,
    Object? waiting_time = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      doc_reply: null == doc_reply
          ? _value.doc_reply
          : doc_reply // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      stars: null == stars
          ? _value.stars
          : stars // ignore: cast_nullable_to_non_nullable
              as int,
      waiting_time: null == waiting_time
          ? _value.waiting_time
          : waiting_time // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewImplCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$$ReviewImplCopyWith(
          _$ReviewImpl value, $Res Function(_$ReviewImpl) then) =
      __$$ReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String username,
      String phone,
      String doc_reply,
      String body,
      String date,
      int stars,
      int waiting_time});
}

/// @nodoc
class __$$ReviewImplCopyWithImpl<$Res>
    extends _$ReviewCopyWithImpl<$Res, _$ReviewImpl>
    implements _$$ReviewImplCopyWith<$Res> {
  __$$ReviewImplCopyWithImpl(
      _$ReviewImpl _value, $Res Function(_$ReviewImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? phone = null,
    Object? doc_reply = null,
    Object? body = null,
    Object? date = null,
    Object? stars = null,
    Object? waiting_time = null,
  }) {
    return _then(_$ReviewImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      doc_reply: null == doc_reply
          ? _value.doc_reply
          : doc_reply // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      stars: null == stars
          ? _value.stars
          : stars // ignore: cast_nullable_to_non_nullable
              as int,
      waiting_time: null == waiting_time
          ? _value.waiting_time
          : waiting_time // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewImpl with DiagnosticableTreeMixin implements _Review {
  const _$ReviewImpl(
      {required this.username,
      required this.phone,
      required this.doc_reply,
      required this.body,
      required this.date,
      required this.stars,
      required this.waiting_time});

  factory _$ReviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewImplFromJson(json);

  @override
  final String username;
  @override
  final String phone;
  @override
  final String doc_reply;
  @override
  final String body;
  @override
  final String date;
  @override
  final int stars;
  @override
  final int waiting_time;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Review(username: $username, phone: $phone, doc_reply: $doc_reply, body: $body, date: $date, stars: $stars, waiting_time: $waiting_time)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Review'))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('doc_reply', doc_reply))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('date', date))
      ..add(DiagnosticsProperty('stars', stars))
      ..add(DiagnosticsProperty('waiting_time', waiting_time));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.doc_reply, doc_reply) ||
                other.doc_reply == doc_reply) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.stars, stars) || other.stars == stars) &&
            (identical(other.waiting_time, waiting_time) ||
                other.waiting_time == waiting_time));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, username, phone, doc_reply, body, date, stars, waiting_time);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
      __$$ReviewImplCopyWithImpl<_$ReviewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewImplToJson(
      this,
    );
  }
}

abstract class _Review implements Review {
  const factory _Review(
      {required final String username,
      required final String phone,
      required final String doc_reply,
      required final String body,
      required final String date,
      required final int stars,
      required final int waiting_time}) = _$ReviewImpl;

  factory _Review.fromJson(Map<String, dynamic> json) = _$ReviewImpl.fromJson;

  @override
  String get username;
  @override
  String get phone;
  @override
  String get doc_reply;
  @override
  String get body;
  @override
  String get date;
  @override
  int get stars;
  @override
  int get waiting_time;
  @override
  @JsonKey(ignore: true)
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
