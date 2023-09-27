// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'break_cubit.dart';

class BreakStateMapper extends ClassMapperBase<BreakState> {
  BreakStateMapper._();

  static BreakStateMapper? _instance;
  static BreakStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BreakStateMapper._());
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'BreakState';

  static Duration _$remainingTime(BreakState v) => v.remainingTime;
  static const Field<BreakState, Duration> _f$remainingTime =
      Field('remainingTime', _$remainingTime, opt: true, def: Duration.zero);
  static Duration _$overbreakTime(BreakState v) => v.overbreakTime;
  static const Field<BreakState, Duration> _f$overbreakTime =
      Field('overbreakTime', _$overbreakTime, opt: true, def: Duration.zero);
  static bool _$isRunning(BreakState v) => v.isRunning;
  static const Field<BreakState, bool> _f$isRunning =
      Field('isRunning', _$isRunning, opt: true, def: false);
  static bool _$isFinished(BreakState v) => v.isFinished;
  static const Field<BreakState, bool> _f$isFinished =
      Field('isFinished', _$isFinished, opt: true, def: false);
  static WorkMode _$referenceMode(BreakState v) => v.referenceMode;
  static const Field<BreakState, WorkMode> _f$referenceMode =
      Field('referenceMode', _$referenceMode, opt: true, def: WorkMode.normal);

  @override
  final Map<Symbol, Field<BreakState, dynamic>> fields = const {
    #remainingTime: _f$remainingTime,
    #overbreakTime: _f$overbreakTime,
    #isRunning: _f$isRunning,
    #isFinished: _f$isFinished,
    #referenceMode: _f$referenceMode,
  };

  static BreakState _instantiate(DecodingData data) {
    return BreakState(
        remainingTime: data.dec(_f$remainingTime),
        overbreakTime: data.dec(_f$overbreakTime),
        isRunning: data.dec(_f$isRunning),
        isFinished: data.dec(_f$isFinished),
        referenceMode: data.dec(_f$referenceMode));
  }

  @override
  final Function instantiate = _instantiate;

  static BreakState fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<BreakState>(map));
  }

  static BreakState fromJson(String json) {
    return _guard((c) => c.fromJson<BreakState>(json));
  }
}

mixin BreakStateMappable {
  String toJson() {
    return BreakStateMapper._guard((c) => c.toJson(this as BreakState));
  }

  Map<String, dynamic> toMap() {
    return BreakStateMapper._guard((c) => c.toMap(this as BreakState));
  }

  BreakStateCopyWith<BreakState, BreakState, BreakState> get copyWith =>
      _BreakStateCopyWithImpl(this as BreakState, $identity, $identity);
  @override
  String toString() {
    return BreakStateMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            BreakStateMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return BreakStateMapper._guard((c) => c.hash(this));
  }
}

extension BreakStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BreakState, $Out> {
  BreakStateCopyWith<$R, BreakState, $Out> get $asBreakState =>
      $base.as((v, t, t2) => _BreakStateCopyWithImpl(v, t, t2));
}

abstract class BreakStateCopyWith<$R, $In extends BreakState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {Duration? remainingTime,
      Duration? overbreakTime,
      bool? isRunning,
      bool? isFinished,
      WorkMode? referenceMode});
  BreakStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BreakStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BreakState, $Out>
    implements BreakStateCopyWith<$R, BreakState, $Out> {
  _BreakStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BreakState> $mapper =
      BreakStateMapper.ensureInitialized();
  @override
  $R call(
          {Duration? remainingTime,
          Duration? overbreakTime,
          bool? isRunning,
          bool? isFinished,
          WorkMode? referenceMode}) =>
      $apply(FieldCopyWithData({
        if (remainingTime != null) #remainingTime: remainingTime,
        if (overbreakTime != null) #overbreakTime: overbreakTime,
        if (isRunning != null) #isRunning: isRunning,
        if (isFinished != null) #isFinished: isFinished,
        if (referenceMode != null) #referenceMode: referenceMode
      }));
  @override
  BreakState $make(CopyWithData data) => BreakState(
      remainingTime: data.get(#remainingTime, or: $value.remainingTime),
      overbreakTime: data.get(#overbreakTime, or: $value.overbreakTime),
      isRunning: data.get(#isRunning, or: $value.isRunning),
      isFinished: data.get(#isFinished, or: $value.isFinished),
      referenceMode: data.get(#referenceMode, or: $value.referenceMode));

  @override
  BreakStateCopyWith<$R2, BreakState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BreakStateCopyWithImpl($value, $cast, t);
}
