sealed class UserAddressesEvent {
  const UserAddressesEvent();

  factory UserAddressesEvent.getAllAddresses() = GetAllAddressesEvent;
  factory UserAddressesEvent.deleteAddress(String id) = DeleteAddressEvent;
  void when({
    required void Function() getAllAddresses,
    required void Function(String id) deleteAddress,
  }) {
    if (this is GetAllAddressesEvent) {
      getAllAddresses();
    } else if (this is DeleteAddressEvent) {
      deleteAddress((this as DeleteAddressEvent).id);
    }
  }
}

class GetAllAddressesEvent extends UserAddressesEvent {
  const GetAllAddressesEvent();
}

class DeleteAddressEvent extends UserAddressesEvent {
  final String id;

  const DeleteAddressEvent(this.id);
}
