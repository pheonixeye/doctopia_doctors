// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_images.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ClinicImages _$ClinicImagesFromJson(Map<String, dynamic> json) {
  return _ClinicImages.fromJson(json);
}

/// @nodoc
mixin _$ClinicImages {
  String get clinic_id => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClinicImagesCopyWith<ClinicImages> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicImagesCopyWith<$Res> {
  factory $ClinicImagesCopyWith(
          ClinicImages value, $Res Function(ClinicImages) then) =
      _$ClinicImagesCopyWithImpl<$Res, ClinicImages>;
  @useResult
  $Res call({String clinic_id, List<String> images});
}

/// @nodoc
class _$ClinicImagesCopyWithImpl<$Res, $Val extends ClinicImages>
    implements $ClinicImagesCopyWith<$Res> {
  _$ClinicImagesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clinic_id = null,
    Object? images = null,
  }) {
    return _then(_value.copyWith(
      clinic_id: null == clinic_id
          ? _value.clinic_id
          : clinic_id // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClinicImagesImplCopyWith<$Res>
    implements $ClinicImagesCopyWith<$Res> {
  factory _$$ClinicImagesImplCopyWith(
          _$ClinicImagesImpl value, $Res Function(_$ClinicImagesImpl) then) =
      __$$ClinicImagesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String clinic_id, List<String> images});
}

/// @nodoc
class __$$ClinicImagesImplCopyWithImpl<$Res>
    extends _$ClinicImagesCopyWithImpl<$Res, _$ClinicImagesImpl>
    implements _$$ClinicImagesImplCopyWith<$Res> {
  __$$ClinicImagesImplCopyWithImpl(
      _$ClinicImagesImpl _value, $Res Function(_$ClinicImagesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clinic_id = null,
    Object? images = null,
  }) {
    return _then(_$ClinicImagesImpl(
      clinic_id: null == clinic_id
          ? _value.clinic_id
          : clinic_id // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClinicImagesImpl with DiagnosticableTreeMixin implements _ClinicImages {
  const _$ClinicImagesImpl(
      {required this.clinic_id, required final List<String> images})
      : _images = images;

  factory _$ClinicImagesImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClinicImagesImplFromJson(json);

  @override
  final String clinic_id;
  final List<String> _images;
  @override
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClinicImages(clinic_id: $clinic_id, images: $images)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ClinicImages'))
      ..add(DiagnosticsProperty('clinic_id', clinic_id))
      ..add(DiagnosticsProperty('images', images));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClinicImagesImpl &&
            (identical(other.clinic_id, clinic_id) ||
                other.clinic_id == clinic_id) &&
            const DeepCollectionEquality().equals(other._images, _images));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, clinic_id, const DeepCollectionEquality().hash(_images));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClinicImagesImplCopyWith<_$ClinicImagesImpl> get copyWith =>
      __$$ClinicImagesImplCopyWithImpl<_$ClinicImagesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClinicImagesImplToJson(
      this,
    );
  }
}

abstract class _ClinicImages implements ClinicImages {
  const factory _ClinicImages(
      {required final String clinic_id,
      required final List<String> images}) = _$ClinicImagesImpl;

  factory _ClinicImages.fromJson(Map<String, dynamic> json) =
      _$ClinicImagesImpl.fromJson;

  @override
  String get clinic_id;
  @override
  List<String> get images;
  @override
  @JsonKey(ignore: true)
  _$$ClinicImagesImplCopyWith<_$ClinicImagesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
