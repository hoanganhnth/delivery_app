// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_sale_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Lấy danh sách các campaign đang active

@ProviderFor(activeCampaigns)
final activeCampaignsProvider = ActiveCampaignsProvider._();

/// Lấy danh sách các campaign đang active

final class ActiveCampaignsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FlashSaleCampaignEntity>>,
          List<FlashSaleCampaignEntity>,
          FutureOr<List<FlashSaleCampaignEntity>>
        >
    with
        $FutureModifier<List<FlashSaleCampaignEntity>>,
        $FutureProvider<List<FlashSaleCampaignEntity>> {
  /// Lấy danh sách các campaign đang active
  ActiveCampaignsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeCampaignsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeCampaignsHash();

  @$internal
  @override
  $FutureProviderElement<List<FlashSaleCampaignEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FlashSaleCampaignEntity>> create(Ref ref) {
    return activeCampaigns(ref);
  }
}

String _$activeCampaignsHash() => r'0dc0bc2d372bfde6673013a2198acdaf12d6f454';

/// Lấy danh sách các món ăn trong 1 campaign

@ProviderFor(campaignItems)
final campaignItemsProvider = CampaignItemsFamily._();

/// Lấy danh sách các món ăn trong 1 campaign

final class CampaignItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FlashSaleItemEntity>>,
          List<FlashSaleItemEntity>,
          FutureOr<List<FlashSaleItemEntity>>
        >
    with
        $FutureModifier<List<FlashSaleItemEntity>>,
        $FutureProvider<List<FlashSaleItemEntity>> {
  /// Lấy danh sách các món ăn trong 1 campaign
  CampaignItemsProvider._({
    required CampaignItemsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'campaignItemsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$campaignItemsHash();

  @override
  String toString() {
    return r'campaignItemsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<FlashSaleItemEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FlashSaleItemEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return campaignItems(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CampaignItemsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$campaignItemsHash() => r'22bb29dc214b31055c3be055bccf4cc115998737';

/// Lấy danh sách các món ăn trong 1 campaign

final class CampaignItemsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<FlashSaleItemEntity>>, int> {
  CampaignItemsFamily._()
    : super(
        retry: null,
        name: r'campaignItemsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Lấy danh sách các món ăn trong 1 campaign

  CampaignItemsProvider call(int campaignId) =>
      CampaignItemsProvider._(argument: campaignId, from: this);

  @override
  String toString() => r'campaignItemsProvider';
}
