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
  static BreakStateStatus _$status(BreakState v) => v.status;
  static const Field<BreakState, BreakStateStatus> _f$status =
      Field('status', _$status, opt: true, def: BreakStateStatus.idle);
  static WorkMode _$referenceMode(BreakState v) => v.referenceMode;
  static const Field<BreakState, WorkMode> _f$referenceMode =
      Field('referenceMode', _$referenceMode, opt: true, def: WorkMode.normal);

  @override
  final Map<Symbol, Field<BreakState, dynamic>> fields = const {
    #remainingTime: _f$remainingTime,
    #overbreakTime: _f$overbreakTime,
    #status: _f$status,
    #referenceMode: _f$referenceMode,
  };

  static BreakState _instantiate(DecodingData data) {
    return BreakState(
        remainingTime: data.dec(_f$remainingTime),
        overbreakTime: data.dec(_f$overbreakTime),
        status: data.dec(_f$status),
        referenceMode: data.dec(_f$referenceMode));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin BreakStateMappable {
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
      BreakStateStatus? status,
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
          BreakStateStatus? status,
          WorkMode? referenceMode}) =>
      $apply(FieldCopyWithData({
        if (remainingTime != null) #remainingTime: remainingTime,
        if (overbreakTime != null) #overbreakTime: overbreakTime,
        if (status != null) #status: status,
        if (referenceMode != null) #referenceMode: referenceMode
      }));
  @override
  BreakState $make(CopyWithData data) => BreakState(
      remainingTime: data.get(#remainingTime, or: $value.remainingTime),
      overbreakTime: data.get(#overbreakTime, or: $value.overbreakTime),
      status: data.get(#status, or: $value.status),
      referenceMode: data.get(#referenceMode, or: $value.referenceMode));

  @override
  BreakStateCopyWith<$R2, BreakState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BreakStateCopyWithImpl($value, $cast, t);
}
