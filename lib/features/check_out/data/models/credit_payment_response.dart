import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:json_annotation/json_annotation.dart';
part 'credit_payment_response.g.dart';

@JsonSerializable()
class CreditPaymentResponse {
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'session')
  Session? session;

  CreditPaymentResponse({this.message, this.session});

  factory CreditPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$CreditPaymentResponseFromJson(json);

  static List<CreditPaymentResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(CreditPaymentResponse.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$CreditPaymentResponseToJson(this);
}

@JsonSerializable()
class Session {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'object')
  String? object;
  @JsonKey(name: 'adaptive_pricing')
  AdaptivePricing? adaptivePricing;
  @JsonKey(name: 'after_expiration')
  dynamic afterExpiration;
  @JsonKey(name: 'allow_promotion_codes')
  dynamic allowPromotionCodes;
  @JsonKey(name: 'amount_subtotal')
  int? amountSubtotal;
  @JsonKey(name: 'amount_total')
  int? amountTotal;
  @JsonKey(name: 'automatic_tax')
  AutomaticTax? automaticTax;
  @JsonKey(name: 'billing_address_collection')
  dynamic billingAddressCollection;
  @JsonKey(name: 'branding_settings')
  BrandingSettings? brandingSettings;
  @JsonKey(name: 'cancel_url')
  String? cancelUrl;
  @JsonKey(name: 'client_reference_id')
  String? clientReferenceId;
  @JsonKey(name: 'client_secret')
  dynamic clientSecret;
  @JsonKey(name: 'collected_information')
  CollectedInformation? collectedInformation;
  @JsonKey(name: 'consent')
  dynamic consent;
  @JsonKey(name: 'consent_collection')
  dynamic consentCollection;
  @JsonKey(name: 'created')
  int? created;
  @JsonKey(name: 'currency')
  String? currency;
  @JsonKey(name: 'currency_conversion')
  dynamic currencyConversion;
  @JsonKey(name: 'custom_fields')
  List<dynamic>? customFields;
  @JsonKey(name: 'custom_text')
  CustomText? customText;
  @JsonKey(name: 'customer')
  dynamic customer;
  @JsonKey(name: 'customer_account')
  dynamic customerAccount;
  @JsonKey(name: 'customer_creation')
  String? customerCreation;
  @JsonKey(name: 'customer_details')
  CustomerDetails? customerDetails;
  @JsonKey(name: 'customer_email')
  String? customerEmail;
  @JsonKey(name: 'discounts')
  List<dynamic>? discounts;
  @JsonKey(name: 'expires_at')
  int? expiresAt;
  @JsonKey(name: 'invoice')
  dynamic invoice;
  @JsonKey(name: 'invoice_creation')
  InvoiceCreation? invoiceCreation;
  @JsonKey(name: 'livemode')
  bool? livemode;
  @JsonKey(name: 'locale')
  dynamic locale;
  @JsonKey(name: 'metadata')
  Metadata1? metadata;
  @JsonKey(name: 'mode')
  String? mode;
  @JsonKey(name: 'origin_context')
  dynamic originContext;
  @JsonKey(name: 'payment_intent')
  dynamic paymentIntent;
  @JsonKey(name: 'payment_link')
  dynamic paymentLink;
  @JsonKey(name: 'payment_method_collection')
  String? paymentMethodCollection;
  @JsonKey(name: 'payment_method_configuration_details')
  PaymentMethodConfigurationDetails? paymentMethodConfigurationDetails;
  @JsonKey(name: 'payment_method_options')
  PaymentMethodOptions? paymentMethodOptions;
  @JsonKey(name: 'payment_method_types')
  List<String>? paymentMethodTypes;
  @JsonKey(name: 'payment_status')
  String? paymentStatus;
  @JsonKey(name: 'permissions')
  dynamic permissions;
  @JsonKey(name: 'phone_number_collection')
  PhoneNumberCollection? phoneNumberCollection;
  @JsonKey(name: 'recovered_from')
  dynamic recoveredFrom;
  @JsonKey(name: 'saved_payment_method_options')
  dynamic savedPaymentMethodOptions;
  @JsonKey(name: 'setup_intent')
  dynamic setupIntent;
  @JsonKey(name: 'shipping_address_collection')
  dynamic shippingAddressCollection;
  @JsonKey(name: 'shipping_cost')
  dynamic shippingCost;
  @JsonKey(name: 'shipping_details')
  dynamic shippingDetails;
  @JsonKey(name: 'shipping_options')
  List<dynamic>? shippingOptions;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'submit_type')
  dynamic submitType;
  @JsonKey(name: 'subscription')
  dynamic subscription;
  @JsonKey(name: 'success_url')
  String? successUrl;
  @JsonKey(name: 'total_details')
  TotalDetails? totalDetails;
  @JsonKey(name: 'ui_mode')
  String? uiMode;
  @JsonKey(name: 'url')
  String? url;
  @JsonKey(name: 'wallet_options')
  dynamic walletOptions;

  Session({
    this.id,
    this.object,
    this.adaptivePricing,
    this.afterExpiration,
    this.allowPromotionCodes,
    this.amountSubtotal,
    this.amountTotal,
    this.automaticTax,
    this.billingAddressCollection,
    this.brandingSettings,
    this.cancelUrl,
    this.clientReferenceId,
    this.clientSecret,
    this.collectedInformation,
    this.consent,
    this.consentCollection,
    this.created,
    this.currency,
    this.currencyConversion,
    this.customFields,
    this.customText,
    this.customer,
    this.customerAccount,
    this.customerCreation,
    this.customerDetails,
    this.customerEmail,
    this.discounts,
    this.expiresAt,
    this.invoice,
    this.invoiceCreation,
    this.livemode,
    this.locale,
    this.metadata,
    this.mode,
    this.originContext,
    this.paymentIntent,
    this.paymentLink,
    this.paymentMethodCollection,
    this.paymentMethodConfigurationDetails,
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.paymentStatus,
    this.permissions,
    this.phoneNumberCollection,
    this.recoveredFrom,
    this.savedPaymentMethodOptions,
    this.setupIntent,
    this.shippingAddressCollection,
    this.shippingCost,
    this.shippingDetails,
    this.shippingOptions,
    this.status,
    this.submitType,
    this.subscription,
    this.successUrl,
    this.totalDetails,
    this.uiMode,
    this.url,
    this.walletOptions,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  static List<Session> fromList(List<Map<String, dynamic>> list) {
    return list.map(Session.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}

@JsonSerializable()
class TotalDetails {
  @JsonKey(name: 'amount_discount')
  int? amountDiscount;
  @JsonKey(name: 'amount_shipping')
  int? amountShipping;
  @JsonKey(name: 'amount_tax')
  int? amountTax;

  TotalDetails({this.amountDiscount, this.amountShipping, this.amountTax});

  factory TotalDetails.fromJson(Map<String, dynamic> json) =>
      _$TotalDetailsFromJson(json);

  static List<TotalDetails> fromList(List<Map<String, dynamic>> list) {
    return list.map(TotalDetails.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$TotalDetailsToJson(this);
}

@JsonSerializable()
class PhoneNumberCollection {
  @JsonKey(name: 'enabled')
  bool? enabled;

  PhoneNumberCollection({this.enabled});

  factory PhoneNumberCollection.fromJson(Map<String, dynamic> json) =>
      _$PhoneNumberCollectionFromJson(json);

  static List<PhoneNumberCollection> fromList(List<Map<String, dynamic>> list) {
    return list.map(PhoneNumberCollection.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$PhoneNumberCollectionToJson(this);
}

@JsonSerializable()
class PaymentMethodOptions {
  @JsonKey(name: 'card')
  Card? card;

  PaymentMethodOptions({this.card});

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodOptionsFromJson(json);

  static List<PaymentMethodOptions> fromList(List<Map<String, dynamic>> list) {
    return list.map(PaymentMethodOptions.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$PaymentMethodOptionsToJson(this);
}

@JsonSerializable()
class Card {
  @JsonKey(name: 'request_three_d_secure')
  String? requestThreeDSecure;

  Card({this.requestThreeDSecure});

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  static List<Card> fromList(List<Map<String, dynamic>> list) {
    return list.map(Card.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$CardToJson(this);
}

@JsonSerializable()
class PaymentMethodConfigurationDetails {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'parent')
  dynamic parent;

  PaymentMethodConfigurationDetails({this.id, this.parent});

  factory PaymentMethodConfigurationDetails.fromJson(
    Map<String, dynamic> json,
  ) => _$PaymentMethodConfigurationDetailsFromJson(json);

  static List<PaymentMethodConfigurationDetails> fromList(
    List<Map<String, dynamic>> list,
  ) {
    return list.map(PaymentMethodConfigurationDetails.fromJson).toList();
  }

  Map<String, dynamic> toJson() =>
      _$PaymentMethodConfigurationDetailsToJson(this);
}

@JsonSerializable()
class Metadata1 {
  @JsonKey(name: 'city')
  String? city;
  @JsonKey(name: 'lat')
  String? lat;
  @JsonKey(name: 'long')
  String? long;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'street')
  String? street;

  Metadata1({this.city, this.lat, this.long, this.phone, this.street});

  factory Metadata1.fromJson(Map<String, dynamic> json) =>
      _$Metadata1FromJson(json);

  static List<Metadata1> fromList(List<Map<String, dynamic>> list) {
    return list.map(Metadata1.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$Metadata1ToJson(this);
}

@JsonSerializable()
class InvoiceCreation {
  @JsonKey(name: 'enabled')
  bool? enabled;
  @JsonKey(name: 'invoice_data')
  InvoiceData? invoiceData;

  InvoiceCreation({this.enabled, this.invoiceData});

  factory InvoiceCreation.fromJson(Map<String, dynamic> json) =>
      _$InvoiceCreationFromJson(json);

  static List<InvoiceCreation> fromList(List<Map<String, dynamic>> list) {
    return list.map(InvoiceCreation.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$InvoiceCreationToJson(this);
}

@JsonSerializable()
class InvoiceData {
  @JsonKey(name: 'account_tax_ids')
  dynamic accountTaxIds;
  @JsonKey(name: 'custom_fields')
  dynamic customFields;
  @JsonKey(name: 'description')
  dynamic description;
  @JsonKey(name: 'footer')
  dynamic footer;
  @JsonKey(name: 'issuer')
  dynamic issuer;
  @JsonKey(name: 'metadata')
  Metadata? metadata;
  @JsonKey(name: 'rendering_options')
  dynamic renderingOptions;

  InvoiceData({
    this.accountTaxIds,
    this.customFields,
    this.description,
    this.footer,
    this.issuer,
    this.metadata,
    this.renderingOptions,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDataFromJson(json);

  static List<InvoiceData> fromList(List<Map<String, dynamic>> list) {
    return list.map(InvoiceData.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$InvoiceDataToJson(this);
}

@JsonSerializable()
class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  static List<Metadata> fromList(List<Map<String, dynamic>> list) {
    return list.map(Metadata.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

@JsonSerializable()
class CustomerDetails {
  @JsonKey(name: 'address')
  dynamic address;
  @JsonKey(name: 'business_name')
  dynamic businessName;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'individual_name')
  dynamic individualName;
  @JsonKey(name: 'name')
  dynamic name;
  @JsonKey(name: 'phone')
  dynamic phone;
  @JsonKey(name: 'tax_exempt')
  String? taxExempt;
  @JsonKey(name: 'tax_ids')
  dynamic taxIds;

  CustomerDetails({
    this.address,
    this.businessName,
    this.email,
    this.individualName,
    this.name,
    this.phone,
    this.taxExempt,
    this.taxIds,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      _$CustomerDetailsFromJson(json);

  static List<CustomerDetails> fromList(List<Map<String, dynamic>> list) {
    return list.map(CustomerDetails.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$CustomerDetailsToJson(this);
}

@JsonSerializable()
class CustomText {
  @JsonKey(name: 'after_submit')
  dynamic afterSubmit;
  @JsonKey(name: 'shipping_address')
  dynamic shippingAddress;
  @JsonKey(name: 'submit')
  dynamic submit;
  @JsonKey(name: 'terms_of_service_acceptance')
  dynamic termsOfServiceAcceptance;

  CustomText({
    this.afterSubmit,
    this.shippingAddress,
    this.submit,
    this.termsOfServiceAcceptance,
  });

  factory CustomText.fromJson(Map<String, dynamic> json) =>
      _$CustomTextFromJson(json);

  static List<CustomText> fromList(List<Map<String, dynamic>> list) {
    return list.map(CustomText.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$CustomTextToJson(this);
}

@JsonSerializable()
class CollectedInformation {
  @JsonKey(name: 'business_name')
  dynamic businessName;
  @JsonKey(name: 'individual_name')
  dynamic individualName;
  @JsonKey(name: 'shipping_details')
  dynamic shippingDetails;

  CollectedInformation({
    this.businessName,
    this.individualName,
    this.shippingDetails,
  });

  factory CollectedInformation.fromJson(Map<String, dynamic> json) =>
      _$CollectedInformationFromJson(json);

  static List<CollectedInformation> fromList(List<Map<String, dynamic>> list) {
    return list.map(CollectedInformation.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$CollectedInformationToJson(this);
}

@JsonSerializable()
class BrandingSettings {
  @JsonKey(name: 'background_color')
  String? backgroundColor;
  @JsonKey(name: 'border_style')
  String? borderStyle;
  @JsonKey(name: 'button_color')
  String? buttonColor;
  @JsonKey(name: 'display_name')
  String? displayName;
  @JsonKey(name: 'font_family')
  String? fontFamily;
  @JsonKey(name: 'icon')
  Icon? icon;
  @JsonKey(name: 'logo')
  Logo? logo;

  BrandingSettings({
    this.backgroundColor,
    this.borderStyle,
    this.buttonColor,
    this.displayName,
    this.fontFamily,
    this.icon,
    this.logo,
  });

  factory BrandingSettings.fromJson(Map<String, dynamic> json) =>
      _$BrandingSettingsFromJson(json);

  static List<BrandingSettings> fromList(List<Map<String, dynamic>> list) {
    return list.map(BrandingSettings.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$BrandingSettingsToJson(this);
}

@JsonSerializable()
class Logo {
  @JsonKey(name: 'file')
  String? file;
  @JsonKey(name: 'type')
  String? type;

  Logo({this.file, this.type});

  factory Logo.fromJson(Map<String, dynamic> json) => _$LogoFromJson(json);

  static List<Logo> fromList(List<Map<String, dynamic>> list) {
    return list.map(Logo.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$LogoToJson(this);
}

@JsonSerializable()
class Icon {
  @JsonKey(name: 'file')
  String? file;
  @JsonKey(name: 'type')
  String? type;

  Icon({this.file, this.type, required color});

  factory Icon.fromJson(Map<String, dynamic> json) => _$IconFromJson(json);

  static List<Icon> fromList(List<Map<String, dynamic>> list) {
    return list.map(Icon.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$IconToJson(this);
}

@JsonSerializable()
class AutomaticTax {
  @JsonKey(name: 'enabled')
  bool? enabled;
  @JsonKey(name: 'liability')
  dynamic liability;
  @JsonKey(name: 'provider')
  dynamic provider;
  @JsonKey(name: 'status')
  dynamic status;

  AutomaticTax({this.enabled, this.liability, this.provider, this.status});

  factory AutomaticTax.fromJson(Map<String, dynamic> json) =>
      _$AutomaticTaxFromJson(json);

  static List<AutomaticTax> fromList(List<Map<String, dynamic>> list) {
    return list.map(AutomaticTax.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$AutomaticTaxToJson(this);
}

@JsonSerializable()
class AdaptivePricing {
  @JsonKey(name: 'enabled')
  bool? enabled;

  AdaptivePricing({this.enabled});

  factory AdaptivePricing.fromJson(Map<String, dynamic> json) =>
      _$AdaptivePricingFromJson(json);

  static List<AdaptivePricing> fromList(List<Map<String, dynamic>> list) {
    return list.map(AdaptivePricing.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$AdaptivePricingToJson(this);
}
