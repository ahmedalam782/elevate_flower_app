// TODO: presentation CartEvents

sealed class CartEvents {}

class GetCartDataEvent extends CartEvents {
  GetCartDataEvent();
}

class AddProductToCartEvent extends CartEvents {
  final int? index;
  final String productId;

  AddProductToCartEvent({this.index, required this.productId});
}

class RemoveProductFromCartEvent extends CartEvents {
  final int index;

  RemoveProductFromCartEvent({required this.index});
}

class ClearUserCartEvent extends CartEvents {}
