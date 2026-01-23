// TODO: presentation CartEvents

sealed class CartEvents {}

class GetCartDataEvent extends CartEvents {
  GetCartDataEvent();
}

class AddProductToCartEvent extends CartEvents {
  final int? index;
  final String productId;
  final bool fromCartScreen;

  AddProductToCartEvent({
    this.index,
    required this.productId,
    required this.fromCartScreen,
  });
}

class RemoveProductFromCartEvent extends CartEvents {
  final String productId;

  RemoveProductFromCartEvent({required this.productId});
}

class UpdateProductInCartEvent extends CartEvents {
  final String productId;
  final int qunatity;

  UpdateProductInCartEvent({required this.productId, required this.qunatity});
}

class ClearUserCartEvent extends CartEvents {}
