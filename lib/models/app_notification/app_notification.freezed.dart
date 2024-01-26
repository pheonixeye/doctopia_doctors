// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) {
  return _AppNotification.fromJson(json);
}

/// @nodoc
mixin _$AppNotification {
  String get id => throw _privateConstructorUsedError;
  String get title_en => throw _privateConstructorUsedError;
  String get title_ar => throw _privateConstructorUsedError;
  String get body_en => throw _privateConstructorUsedError;
  String get body_ar => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppNotificationCopyWith<AppNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppNotificationCopyWith<$Res> {
  factory $AppNotificationCopyWith(
          AppNotification value, $Res Function(AppNotification) then) =
      _$AppNotificationCopyWithImpl<$Res, AppNotification>;
  @useResult
  $Res call(
      {String id,
      String title_en,
      String title_ar,
      String body_en,
      String body_ar});
}

/// @nodoc
class _$AppNotificationCopyWithImpl<$Res, $Val extends AppNotification>
    implements $AppNotificationCopyWith<$Res> {
  _$AppNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title_en = null,
    Object? title_ar = null,
    Object? body_en = null,
    Object? body_ar = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title_en: null == title_en
          ? _value.title_en
          : title_en // ignore: cast_nullable_to_non_nullable
              as String,
      title_ar: null == title_ar
          ? _value.title_ar
          : title_ar // ignore: cast_nullable_to_non_nullable
              as String,
      body_en: null == body_en
          ? _value.body_en
          : body_en // ignore: cast_nullable_to_non_nullable
              as String,
      body_ar: null == body_ar
          ? _value.body_ar
          : body_ar // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppNotificationImplCopyWith<$Res>
    implements $AppNotificationCopyWith<$Res> {
  factory _$$AppNotificationImplCopyWith(_$AppNotificationImpl value,
          $Res Function(_$AppNotificationImpl) then) =
      __$$AppNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title_en,
      String title_ar,
      String body_en,
      String body_ar});
}

/// @nodoc
class __$$AppNotificationImplCopyWithImpl<$Res>
    extends _$AppNotificationCopyWithImpl<$Res, _$AppNotificationImpl>
    implements _$$AppNotificationImplCopyWith<$Res> {
  __$$AppNotificationImplCopyWithImpl(
      _$AppNotificationImpl _value, $Res Function(_$AppNotificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title_en = null,
    Object? title_ar = null,
    Object? body_en = null,
    Object? body_ar = null,
  }) {
    return _then(_$AppNotificationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title_en: null == title_en
          ? _value.title_en
          : title_en // ignore: cast_nullable_to_non_nullable
              as String,
      title_ar: null == title_ar
          ? _value.title_ar
          : title_ar // ignore: cast_nullable_to_non_nullable
              as String,
      body_en: null == body_en
          ? _value.body_en
          : body_en // ignore: cast_nullable_to_non_nullable
              as String,
      body_ar: null == body_ar
          ? _value.body_ar
          : body_ar // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppNotificationImpl
    with DiagnosticableTreeMixin
    implements _AppNotification {
  const _$AppNotificationImpl(
      {required this.id,
      required this.title_en,
      required this.title_ar,
      required this.body_en,
      required this.body_ar});

  factory _$AppNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppNotificationImplFromJson(json);

  @override
  final String id;
  @override
  final String title_en;
  @override
  final String title_ar;
  @override
  final String body_en;
  @override
  final String body_ar;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppNotification(id: $id, title_en: $title_en, title_ar: $title_ar, body_en: $body_en, body_ar: $body_ar)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppNotification'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title_en', title_en))
      ..add(DiagnosticsProperty('title_ar', title_ar))
      ..add(DiagnosticsProperty('body_en', body_en))
      ..add(DiagnosticsProperty('body_ar', body_ar));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title_en, title_en) ||
                other.title_en == title_en) &&
            (identical(other.title_ar, title_ar) ||
                other.title_ar == title_ar) &&
            (identical(other.body_en, body_en) || other.body_en == body_en) &&
            (identical(other.body_ar, body_ar) || other.body_ar == body_ar));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title_en, title_ar, body_en, body_ar);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppNotificationImplCopyWith<_$AppNotificationImpl> get copyWith =>
      __$$AppNotificationImplCopyWithImpl<_$AppNotificationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppNotificationImplToJson(
      this,
    );
  }
}

abstract class _AppNotification implements AppNotification {
  const factory _AppNotification(
      {required final String id,
      required final String title_en,
      required final String title_ar,
      required final String body_en,
      required final String body_ar}) = _$AppNotificationImpl;

  factory _AppNotification.fromJson(Map<String, dynamic> json) =
      _$AppNotificationImpl.fromJson;

  @override
  String get id;
  @override
  String get title_en;
  @override
  String get title_ar;
  @override
  String get body_en;
  @override
  String get body_ar;
  @override
  @JsonKey(ignore: true)
  _$$AppNotificationImplCopyWith<_$AppNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
