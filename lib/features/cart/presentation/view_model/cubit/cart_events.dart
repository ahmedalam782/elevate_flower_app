// TODO: presentation CartEvents

sealed class CartEvents {}

class GetCartDataEvent extends CartEvents {
  GetCartDataEvent();
}

class AddProductToCartEvent extends CartEvents {
  final int index;

  AddProductToCartEvent({required this.index});
}

class RemoveProductFromCartEvent extends CartEvents {
  final int index;

  RemoveProductFromCartEvent({required this.index});
}
