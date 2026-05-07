// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatState()';
}


}

/// @nodoc
class $ChatStateCopyWith<$Res>  {
$ChatStateCopyWith(ChatState _, $Res Function(ChatState) __);
}


/// Adds pattern-matching-related methods to [ChatState].
extension ChatStatePatterns on ChatState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChatStateInitial value)?  initial,TResult Function( ChatStateLoading value)?  loading,TResult Function( ChatStateLoaded value)?  loaded,TResult Function( ChatStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChatStateInitial() when initial != null:
return initial(_that);case ChatStateLoading() when loading != null:
return loading(_that);case ChatStateLoaded() when loaded != null:
return loaded(_that);case ChatStateError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChatStateInitial value)  initial,required TResult Function( ChatStateLoading value)  loading,required TResult Function( ChatStateLoaded value)  loaded,required TResult Function( ChatStateError value)  error,}){
final _that = this;
switch (_that) {
case ChatStateInitial():
return initial(_that);case ChatStateLoading():
return loading(_that);case ChatStateLoaded():
return loaded(_that);case ChatStateError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChatStateInitial value)?  initial,TResult? Function( ChatStateLoading value)?  loading,TResult? Function( ChatStateLoaded value)?  loaded,TResult? Function( ChatStateError value)?  error,}){
final _that = this;
switch (_that) {
case ChatStateInitial() when initial != null:
return initial(_that);case ChatStateLoading() when loading != null:
return loading(_that);case ChatStateLoaded() when loaded != null:
return loaded(_that);case ChatStateError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ConversationEntity conversation,  List<ChatMessageEntity> messages,  bool isSendingMessage,  bool isLoadingMore,  bool hasMoreMessages,  int pageSize)?  loaded,TResult Function( Failure failure,  ConversationEntity? conversation,  List<ChatMessageEntity> messages)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChatStateInitial() when initial != null:
return initial();case ChatStateLoading() when loading != null:
return loading();case ChatStateLoaded() when loaded != null:
return loaded(_that.conversation,_that.messages,_that.isSendingMessage,_that.isLoadingMore,_that.hasMoreMessages,_that.pageSize);case ChatStateError() when error != null:
return error(_that.failure,_that.conversation,_that.messages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ConversationEntity conversation,  List<ChatMessageEntity> messages,  bool isSendingMessage,  bool isLoadingMore,  bool hasMoreMessages,  int pageSize)  loaded,required TResult Function( Failure failure,  ConversationEntity? conversation,  List<ChatMessageEntity> messages)  error,}) {final _that = this;
switch (_that) {
case ChatStateInitial():
return initial();case ChatStateLoading():
return loading();case ChatStateLoaded():
return loaded(_that.conversation,_that.messages,_that.isSendingMessage,_that.isLoadingMore,_that.hasMoreMessages,_that.pageSize);case ChatStateError():
return error(_that.failure,_that.conversation,_that.messages);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ConversationEntity conversation,  List<ChatMessageEntity> messages,  bool isSendingMessage,  bool isLoadingMore,  bool hasMoreMessages,  int pageSize)?  loaded,TResult? Function( Failure failure,  ConversationEntity? conversation,  List<ChatMessageEntity> messages)?  error,}) {final _that = this;
switch (_that) {
case ChatStateInitial() when initial != null:
return initial();case ChatStateLoading() when loading != null:
return loading();case ChatStateLoaded() when loaded != null:
return loaded(_that.conversation,_that.messages,_that.isSendingMessage,_that.isLoadingMore,_that.hasMoreMessages,_that.pageSize);case ChatStateError() when error != null:
return error(_that.failure,_that.conversation,_that.messages);case _:
  return null;

}
}

}

/// @nodoc


class ChatStateInitial extends ChatState {
  const ChatStateInitial(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatState.initial()';
}


}




/// @nodoc


class ChatStateLoading extends ChatState {
  const ChatStateLoading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatState.loading()';
}


}




/// @nodoc


class ChatStateLoaded extends ChatState {
  const ChatStateLoaded({required this.conversation, required final  List<ChatMessageEntity> messages, this.isSendingMessage = false, this.isLoadingMore = false, this.hasMoreMessages = true, this.pageSize = 10}): _messages = messages,super._();
  

 final  ConversationEntity conversation;
 final  List<ChatMessageEntity> _messages;
 List<ChatMessageEntity> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@JsonKey() final  bool isSendingMessage;
@JsonKey() final  bool isLoadingMore;
@JsonKey() final  bool hasMoreMessages;
@JsonKey() final  int pageSize;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatStateLoadedCopyWith<ChatStateLoaded> get copyWith => _$ChatStateLoadedCopyWithImpl<ChatStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatStateLoaded&&(identical(other.conversation, conversation) || other.conversation == conversation)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.isSendingMessage, isSendingMessage) || other.isSendingMessage == isSendingMessage)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMoreMessages, hasMoreMessages) || other.hasMoreMessages == hasMoreMessages)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}


@override
int get hashCode => Object.hash(runtimeType,conversation,const DeepCollectionEquality().hash(_messages),isSendingMessage,isLoadingMore,hasMoreMessages,pageSize);

@override
String toString() {
  return 'ChatState.loaded(conversation: $conversation, messages: $messages, isSendingMessage: $isSendingMessage, isLoadingMore: $isLoadingMore, hasMoreMessages: $hasMoreMessages, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class $ChatStateLoadedCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory $ChatStateLoadedCopyWith(ChatStateLoaded value, $Res Function(ChatStateLoaded) _then) = _$ChatStateLoadedCopyWithImpl;
@useResult
$Res call({
 ConversationEntity conversation, List<ChatMessageEntity> messages, bool isSendingMessage, bool isLoadingMore, bool hasMoreMessages, int pageSize
});




}
/// @nodoc
class _$ChatStateLoadedCopyWithImpl<$Res>
    implements $ChatStateLoadedCopyWith<$Res> {
  _$ChatStateLoadedCopyWithImpl(this._self, this._then);

  final ChatStateLoaded _self;
  final $Res Function(ChatStateLoaded) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversation = null,Object? messages = null,Object? isSendingMessage = null,Object? isLoadingMore = null,Object? hasMoreMessages = null,Object? pageSize = null,}) {
  return _then(ChatStateLoaded(
conversation: null == conversation ? _self.conversation : conversation // ignore: cast_nullable_to_non_nullable
as ConversationEntity,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessageEntity>,isSendingMessage: null == isSendingMessage ? _self.isSendingMessage : isSendingMessage // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMoreMessages: null == hasMoreMessages ? _self.hasMoreMessages : hasMoreMessages // ignore: cast_nullable_to_non_nullable
as bool,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ChatStateError extends ChatState {
  const ChatStateError({required this.failure, this.conversation, final  List<ChatMessageEntity> messages = const []}): _messages = messages,super._();
  

 final  Failure failure;
 final  ConversationEntity? conversation;
 final  List<ChatMessageEntity> _messages;
@JsonKey() List<ChatMessageEntity> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatStateErrorCopyWith<ChatStateError> get copyWith => _$ChatStateErrorCopyWithImpl<ChatStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatStateError&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.conversation, conversation) || other.conversation == conversation)&&const DeepCollectionEquality().equals(other._messages, _messages));
}


@override
int get hashCode => Object.hash(runtimeType,failure,conversation,const DeepCollectionEquality().hash(_messages));

@override
String toString() {
  return 'ChatState.error(failure: $failure, conversation: $conversation, messages: $messages)';
}


}

/// @nodoc
abstract mixin class $ChatStateErrorCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory $ChatStateErrorCopyWith(ChatStateError value, $Res Function(ChatStateError) _then) = _$ChatStateErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure, ConversationEntity? conversation, List<ChatMessageEntity> messages
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$ChatStateErrorCopyWithImpl<$Res>
    implements $ChatStateErrorCopyWith<$Res> {
  _$ChatStateErrorCopyWithImpl(this._self, this._then);

  final ChatStateError _self;
  final $Res Function(ChatStateError) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,Object? conversation = freezed,Object? messages = null,}) {
  return _then(ChatStateError(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,conversation: freezed == conversation ? _self.conversation : conversation // ignore: cast_nullable_to_non_nullable
as ConversationEntity?,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessageEntity>,
  ));
}

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
