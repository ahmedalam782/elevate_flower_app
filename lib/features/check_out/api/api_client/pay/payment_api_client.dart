import 'package:dio/dio.dart';
import 'package:elevate_flower_app/core/config/api/end_points.dart';
import 'package:elevate_flower_app/features/check_out/data/models/cash_payment_response.dart';
import 'package:elevate_flower_app/features/check_out/data/models/credit_payment_response.dart';
import 'package:elevate_flower_app/features/check_out/data/models/shipping_address_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'payment_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class PaymentApiClient {
  @factoryMethod
  factory PaymentApiClient(Dio dio) = _PaymentApiClient;

  @POST(EndPoints.cashCheckOut)
  Future<CashPaymentResponse> payWithCash(@Body() ShippingAddressModel data);

    @POST(EndPoints.creditCheckOut)
  Future<CreditPaymentResponse> payWithCredit(@Body() ShippingAddressModel data);
}
