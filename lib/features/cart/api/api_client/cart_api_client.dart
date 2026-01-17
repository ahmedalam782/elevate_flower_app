// TODO: api CartApiClient

import 'package:dio/dio.dart';
import 'package:elevate_flower_app/core/config/api/end_points.dart';
import 'package:elevate_flower_app/features/cart/data/models/cart_response.dart';
import 'package:elevate_flower_app/features/cart/data/models/post/cart_product_post_data.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'cart_api_client.g.dart';

@injectable
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class CartApiClient {
  @factoryMethod
  factory CartApiClient(Dio dio) = _CartApiClient;

  @GET(EndPoints.cartEndPoint)
  Future<CartResponse> getCartData();
  @POST(EndPoints.cartEndPoint)
  Future<void> addItemToCart(@Body() CartProductPostData data);
  @DELETE("${EndPoints.cartEndPoint}/{id}")
  Future<void> removeItemFromCart(@Path() String id);
}
