// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'rest_option.dart';

class RestOptionMapper extends EnumMapper<RestOption> {
  RestOptionMapper._();

  static RestOptionMapper? _instance;
  static RestOptionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RestOptionMapper._());
    }
    return _instance!;
  }

  static RestOption fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  RestOption decode(dynamic value) {
    switch (value) {
      case 'takeBreak':
        return RestOption.takeBreak;
      case 'endSession':
        return RestOption.endSession;
      case 'cancel':
        return RestOption.cancel;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(RestOption self) {
    switch (self) {
      case RestOption.takeBreak:
        return 'takeBreak';
      case RestOption.endSession:
        return 'endSession';
      case RestOption.cancel:
        return 'cancel';
    }
  }
}

extension RestOptionMapperExtension on RestOption {
  String toValue() {
    RestOptionMapper.ensureInitialized();
    return MapperContainer.globals.toValue(this) as String;
  }
}
