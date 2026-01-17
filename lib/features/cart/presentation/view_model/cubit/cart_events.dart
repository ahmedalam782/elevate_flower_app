// TODO: presentation CartEvents

sealed class CartEvents {}

class GetCartData extends CartEvents {
  GetCartData();
}

class AddProductToCart extends CartEvents {
  final int index;

  AddProductToCart({required this.index});
}
