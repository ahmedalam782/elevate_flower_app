sealed class TrackOrderEvents {
  final String orderId;
  TrackOrderEvents({required this.orderId});
}

class ListenToOrderStateEvent extends TrackOrderEvents {
  ListenToOrderStateEvent({required super.orderId});

}

class ListenToDriverLocationEvent extends TrackOrderEvents {
  ListenToDriverLocationEvent({required super.orderId});
}

class GetOrderDetailsEvent extends TrackOrderEvents {
  GetOrderDetailsEvent({required super.orderId});
}
