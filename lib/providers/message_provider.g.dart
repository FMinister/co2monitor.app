// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$messageStateNotifierHash() =>
    r'01fd043e2ac80c78604ba758e4a10a041e92ff34';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$MessageStateNotifier
    extends BuildlessAutoDisposeNotifier<void> {
  late final BuildContext context;

  void build(
    BuildContext context,
  );
}

/// See also [MessageStateNotifier].
@ProviderFor(MessageStateNotifier)
const messageStateNotifierProvider = MessageStateNotifierFamily();

/// See also [MessageStateNotifier].
class MessageStateNotifierFamily extends Family<void> {
  /// See also [MessageStateNotifier].
  const MessageStateNotifierFamily();

  /// See also [MessageStateNotifier].
  MessageStateNotifierProvider call(
    BuildContext context,
  ) {
    return MessageStateNotifierProvider(
      context,
    );
  }

  @override
  MessageStateNotifierProvider getProviderOverride(
    covariant MessageStateNotifierProvider provider,
  ) {
    return call(
      provider.context,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'messageStateNotifierProvider';
}

/// See also [MessageStateNotifier].
class MessageStateNotifierProvider
    extends AutoDisposeNotifierProviderImpl<MessageStateNotifier, void> {
  /// See also [MessageStateNotifier].
  MessageStateNotifierProvider(
    this.context,
  ) : super.internal(
          () => MessageStateNotifier()..context = context,
          from: messageStateNotifierProvider,
          name: r'messageStateNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$messageStateNotifierHash,
          dependencies: MessageStateNotifierFamily._dependencies,
          allTransitiveDependencies:
              MessageStateNotifierFamily._allTransitiveDependencies,
        );

  final BuildContext context;

  @override
  bool operator ==(Object other) {
    return other is MessageStateNotifierProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  void runNotifierBuild(
    covariant MessageStateNotifier notifier,
  ) {
    return notifier.build(
      context,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
