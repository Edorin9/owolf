// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'home_cubit.dart';

class HomeStateMapper extends ClassMapperBase<HomeState> {
  HomeStateMapper._();

  static HomeStateMapper? _instance;
  static HomeStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeStateMapper._());
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'HomeState';

  static WorkMode _$mode(HomeState v) => v.mode;
  static const Field<HomeState, WorkMode> _f$mode =
      Field('mode', _$mode, opt: true, def: WorkMode.normal);
  static bool _$isRunning(HomeState v) => v.isRunning;
  static const Field<HomeState, bool> _f$isRunning =
      Field('isRunning', _$isRunning, opt: true, def: false);
  static Duration _$elapsedTime(HomeState v) => v.elapsedTime;
  static const Field<HomeState, Duration> _f$elapsedTime =
      Field('elapsedTime', _$elapsedTime, opt: true, def: Duration.zero);
  static Duration _$remainingTime(HomeState v) => v.remainingTime;
  static const Field<HomeState, Duration> _f$remainingTime =
      Field('remainingTime', _$remainingTime, opt: true, def: Duration.zero);

  @override
  final Map<Symbol, Field<HomeState, dynamic>> fields = const {
    #mode: _f$mode,
    #isRunning: _f$isRunning,
    #elapsedTime: _f$elapsedTime,
    #remainingTime: _f$remainingTime,
  };

  static HomeState _instantiate(DecodingData data) {
    return HomeState(
        mode: data.dec(_f$mode),
        isRunning: data.dec(_f$isRunning),
        elapsedTime: data.dec(_f$elapsedTime),
        remainingTime: data.dec(_f$remainingTime));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin HomeStateMappable {
  HomeStateCopyWith<HomeState, HomeState, HomeState> get copyWith =>
      _HomeStateCopyWithImpl(this as HomeState, $identity, $identity);
  @override
  String toString() {
    return HomeStateMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            HomeStateMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return HomeStateMapper._guard((c) => c.hash(this));
  }
}

extension HomeStateValueCopy<$R, $Out> on ObjectCopyWith<$R, HomeState, $Out> {
  HomeStateCopyWith<$R, HomeState, $Out> get $asHomeState =>
      $base.as((v, t, t2) => _HomeStateCopyWithImpl(v, t, t2));
}

abstract class HomeStateCopyWith<$R, $In extends HomeState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {WorkMode? mode,
      bool? isRunning,
      Duration? elapsedTime,
      Duration? remainingTime});
  HomeStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HomeStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HomeState, $Out>
    implements HomeStateCopyWith<$R, HomeState, $Out> {
  _HomeStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeState> $mapper =
      HomeStateMapper.ensureInitialized();
  @override
  $R call(
          {WorkMode? mode,
          bool? isRunning,
          Duration? elapsedTime,
          Duration? remainingTime}) =>
      $apply(FieldCopyWithData({
        if (mode != null) #mode: mode,
        if (isRunning != null) #isRunning: isRunning,
        if (elapsedTime != null) #elapsedTime: elapsedTime,
        if (remainingTime != null) #remainingTime: remainingTime
      }));
  @override
  HomeState $make(CopyWithData data) => HomeState(
      mode: data.get(#mode, or: $value.mode),
      isRunning: data.get(#isRunning, or: $value.isRunning),
      elapsedTime: data.get(#elapsedTime, or: $value.elapsedTime),
      remainingTime: data.get(#remainingTime, or: $value.remainingTime));

  @override
  HomeStateCopyWith<$R2, HomeState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _HomeStateCopyWithImpl($value, $cast, t);
}
