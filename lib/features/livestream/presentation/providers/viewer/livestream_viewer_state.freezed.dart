// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'livestream_viewer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LivestreamViewerState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivestreamViewerState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LivestreamViewerState()';
}


}

/// @nodoc
class $LivestreamViewerStateCopyWith<$Res>  {
$LivestreamViewerStateCopyWith(LivestreamViewerState _, $Res Function(LivestreamViewerState) __);
}


/// Adds pattern-matching-related methods to [LivestreamViewerState].
extension LivestreamViewerStatePatterns on LivestreamViewerState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LivestreamViewerIdle value)?  idle,TResult Function( LivestreamViewerConnecting value)?  connecting,TResult Function( LivestreamViewerWatching value)?  watching,TResult Function( LivestreamViewerError value)?  error,TResult Function( LivestreamViewerDisconnected value)?  disconnected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LivestreamViewerIdle() when idle != null:
return idle(_that);case LivestreamViewerConnecting() when connecting != null:
return connecting(_that);case LivestreamViewerWatching() when watching != null:
return watching(_that);case LivestreamViewerError() when error != null:
return error(_that);case LivestreamViewerDisconnected() when disconnected != null:
return disconnected(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LivestreamViewerIdle value)  idle,required TResult Function( LivestreamViewerConnecting value)  connecting,required TResult Function( LivestreamViewerWatching value)  watching,required TResult Function( LivestreamViewerError value)  error,required TResult Function( LivestreamViewerDisconnected value)  disconnected,}){
final _that = this;
switch (_that) {
case LivestreamViewerIdle():
return idle(_that);case LivestreamViewerConnecting():
return connecting(_that);case LivestreamViewerWatching():
return watching(_that);case LivestreamViewerError():
return error(_that);case LivestreamViewerDisconnected():
return disconnected(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LivestreamViewerIdle value)?  idle,TResult? Function( LivestreamViewerConnecting value)?  connecting,TResult? Function( LivestreamViewerWatching value)?  watching,TResult? Function( LivestreamViewerError value)?  error,TResult? Function( LivestreamViewerDisconnected value)?  disconnected,}){
final _that = this;
switch (_that) {
case LivestreamViewerIdle() when idle != null:
return idle(_that);case LivestreamViewerConnecting() when connecting != null:
return connecting(_that);case LivestreamViewerWatching() when watching != null:
return watching(_that);case LivestreamViewerError() when error != null:
return error(_that);case LivestreamViewerDisconnected() when disconnected != null:
return disconnected(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  connecting,TResult Function( String channelName,  int? remoteUid)?  watching,TResult Function( String message)?  error,TResult Function()?  disconnected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LivestreamViewerIdle() when idle != null:
return idle();case LivestreamViewerConnecting() when connecting != null:
return connecting();case LivestreamViewerWatching() when watching != null:
return watching(_that.channelName,_that.remoteUid);case LivestreamViewerError() when error != null:
return error(_that.message);case LivestreamViewerDisconnected() when disconnected != null:
return disconnected();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  connecting,required TResult Function( String channelName,  int? remoteUid)  watching,required TResult Function( String message)  error,required TResult Function()  disconnected,}) {final _that = this;
switch (_that) {
case LivestreamViewerIdle():
return idle();case LivestreamViewerConnecting():
return connecting();case LivestreamViewerWatching():
return watching(_that.channelName,_that.remoteUid);case LivestreamViewerError():
return error(_that.message);case LivestreamViewerDisconnected():
return disconnected();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  connecting,TResult? Function( String channelName,  int? remoteUid)?  watching,TResult? Function( String message)?  error,TResult? Function()?  disconnected,}) {final _that = this;
switch (_that) {
case LivestreamViewerIdle() when idle != null:
return idle();case LivestreamViewerConnecting() when connecting != null:
return connecting();case LivestreamViewerWatching() when watching != null:
return watching(_that.channelName,_that.remoteUid);case LivestreamViewerError() when error != null:
return error(_that.message);case LivestreamViewerDisconnected() when disconnected != null:
return disconnected();case _:
  return null;

}
}

}

/// @nodoc


class LivestreamViewerIdle implements LivestreamViewerState {
  const LivestreamViewerIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivestreamViewerIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LivestreamViewerState.idle()';
}


}




/// @nodoc


class LivestreamViewerConnecting implements LivestreamViewerState {
  const LivestreamViewerConnecting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivestreamViewerConnecting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LivestreamViewerState.connecting()';
}


}




/// @nodoc


class LivestreamViewerWatching implements LivestreamViewerState {
  const LivestreamViewerWatching({required this.channelName, this.remoteUid});
  

 final  String channelName;
 final  int? remoteUid;

/// Create a copy of LivestreamViewerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivestreamViewerWatchingCopyWith<LivestreamViewerWatching> get copyWith => _$LivestreamViewerWatchingCopyWithImpl<LivestreamViewerWatching>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivestreamViewerWatching&&(identical(other.channelName, channelName) || other.channelName == channelName)&&(identical(other.remoteUid, remoteUid) || other.remoteUid == remoteUid));
}


@override
int get hashCode => Object.hash(runtimeType,channelName,remoteUid);

@override
String toString() {
  return 'LivestreamViewerState.watching(channelName: $channelName, remoteUid: $remoteUid)';
}


}

/// @nodoc
abstract mixin class $LivestreamViewerWatchingCopyWith<$Res> implements $LivestreamViewerStateCopyWith<$Res> {
  factory $LivestreamViewerWatchingCopyWith(LivestreamViewerWatching value, $Res Function(LivestreamViewerWatching) _then) = _$LivestreamViewerWatchingCopyWithImpl;
@useResult
$Res call({
 String channelName, int? remoteUid
});




}
/// @nodoc
class _$LivestreamViewerWatchingCopyWithImpl<$Res>
    implements $LivestreamViewerWatchingCopyWith<$Res> {
  _$LivestreamViewerWatchingCopyWithImpl(this._self, this._then);

  final LivestreamViewerWatching _self;
  final $Res Function(LivestreamViewerWatching) _then;

/// Create a copy of LivestreamViewerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? channelName = null,Object? remoteUid = freezed,}) {
  return _then(LivestreamViewerWatching(
channelName: null == channelName ? _self.channelName : channelName // ignore: cast_nullable_to_non_nullable
as String,remoteUid: freezed == remoteUid ? _self.remoteUid : remoteUid // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class LivestreamViewerError implements LivestreamViewerState {
  const LivestreamViewerError(this.message);
  

 final  String message;

/// Create a copy of LivestreamViewerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivestreamViewerErrorCopyWith<LivestreamViewerError> get copyWith => _$LivestreamViewerErrorCopyWithImpl<LivestreamViewerError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivestreamViewerError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'LivestreamViewerState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $LivestreamViewerErrorCopyWith<$Res> implements $LivestreamViewerStateCopyWith<$Res> {
  factory $LivestreamViewerErrorCopyWith(LivestreamViewerError value, $Res Function(LivestreamViewerError) _then) = _$LivestreamViewerErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$LivestreamViewerErrorCopyWithImpl<$Res>
    implements $LivestreamViewerErrorCopyWith<$Res> {
  _$LivestreamViewerErrorCopyWithImpl(this._self, this._then);

  final LivestreamViewerError _self;
  final $Res Function(LivestreamViewerError) _then;

/// Create a copy of LivestreamViewerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(LivestreamViewerError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LivestreamViewerDisconnected implements LivestreamViewerState {
  const LivestreamViewerDisconnected();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivestreamViewerDisconnected);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LivestreamViewerState.disconnected()';
}


}




// dart format on
