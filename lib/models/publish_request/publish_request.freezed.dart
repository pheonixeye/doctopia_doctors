// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'publish_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PublishRequest _$PublishRequestFromJson(Map<String, dynamic> json) {
  return _PublishRequest.fromJson(json);
}

/// @nodoc
mixin _$PublishRequest {
  int get synd_id => throw _privateConstructorUsedError;
  String get name_en => throw _privateConstructorUsedError;
  String get name_ar => throw _privateConstructorUsedError;
  bool get published => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PublishRequestCopyWith<PublishRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PublishRequestCopyWith<$Res> {
  factory $PublishRequestCopyWith(
          PublishRequest value, $Res Function(PublishRequest) then) =
      _$PublishRequestCopyWithImpl<$Res, PublishRequest>;
  @useResult
  $Res call({int synd_id, String name_en, String name_ar, bool published});
}

/// @nodoc
class _$PublishRequestCopyWithImpl<$Res, $Val extends PublishRequest>
    implements $PublishRequestCopyWith<$Res> {
  _$PublishRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? synd_id = null,
    Object? name_en = null,
    Object? name_ar = null,
    Object? published = null,
  }) {
    return _then(_value.copyWith(
      synd_id: null == synd_id
          ? _value.synd_id
          : synd_id // ignore: cast_nullable_to_non_nullable
              as int,
      name_en: null == name_en
          ? _value.name_en
          : name_en // ignore: cast_nullable_to_non_nullable
              as String,
      name_ar: null == name_ar
          ? _value.name_ar
          : name_ar // ignore: cast_nullable_to_non_nullable
              as String,
      published: null == published
          ? _value.published
          : published // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PublishRequestImplCopyWith<$Res>
    implements $PublishRequestCopyWith<$Res> {
  factory _$$PublishRequestImplCopyWith(_$PublishRequestImpl value,
          $Res Function(_$PublishRequestImpl) then) =
      __$$PublishRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int synd_id, String name_en, String name_ar, bool published});
}

/// @nodoc
class __$$PublishRequestImplCopyWithImpl<$Res>
    extends _$PublishRequestCopyWithImpl<$Res, _$PublishRequestImpl>
    implements _$$PublishRequestImplCopyWith<$Res> {
  __$$PublishRequestImplCopyWithImpl(
      _$PublishRequestImpl _value, $Res Function(_$PublishRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? synd_id = null,
    Object? name_en = null,
    Object? name_ar = null,
    Object? published = null,
  }) {
    return _then(_$PublishRequestImpl(
      synd_id: null == synd_id
          ? _value.synd_id
          : synd_id // ignore: cast_nullable_to_non_nullable
              as int,
      name_en: null == name_en
          ? _value.name_en
          : name_en // ignore: cast_nullable_to_non_nullable
              as String,
      name_ar: null == name_ar
          ? _value.name_ar
          : name_ar // ignore: cast_nullable_to_non_nullable
              as String,
      published: null == published
          ? _value.published
          : published // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PublishRequestImpl
    with DiagnosticableTreeMixin
    implements _PublishRequest {
  const _$PublishRequestImpl(
      {required this.synd_id,
      required this.name_en,
      required this.name_ar,
      required this.published});

  factory _$PublishRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PublishRequestImplFromJson(json);

  @override
  final int synd_id;
  @override
  final String name_en;
  @override
  final String name_ar;
  @override
  final bool published;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PublishRequest(synd_id: $synd_id, name_en: $name_en, name_ar: $name_ar, published: $published)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PublishRequest'))
      ..add(DiagnosticsProperty('synd_id', synd_id))
      ..add(DiagnosticsProperty('name_en', name_en))
      ..add(DiagnosticsProperty('name_ar', name_ar))
      ..add(DiagnosticsProperty('published', published));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PublishRequestImpl &&
            (identical(other.synd_id, synd_id) || other.synd_id == synd_id) &&
            (identical(other.name_en, name_en) || other.name_en == name_en) &&
            (identical(other.name_ar, name_ar) || other.name_ar == name_ar) &&
            (identical(other.published, published) ||
                other.published == published));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, synd_id, name_en, name_ar, published);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PublishRequestImplCopyWith<_$PublishRequestImpl> get copyWith =>
      __$$PublishRequestImplCopyWithImpl<_$PublishRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PublishRequestImplToJson(
      this,
    );
  }
}

abstract class _PublishRequest implements PublishRequest {
  const factory _PublishRequest(
      {required final int synd_id,
      required final String name_en,
      required final String name_ar,
      required final bool published}) = _$PublishRequestImpl;

  factory _PublishRequest.fromJson(Map<String, dynamic> json) =
      _$PublishRequestImpl.fromJson;

  @override
  int get synd_id;
  @override
  String get name_en;
  @override
  String get name_ar;
  @override
  bool get published;
  @override
  @JsonKey(ignore: true)
  _$$PublishRequestImplCopyWith<_$PublishRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
