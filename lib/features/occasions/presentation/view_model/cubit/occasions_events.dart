sealed class OccasionsEvents {
  const OccasionsEvents();
  factory OccasionsEvents.getOccasions(int index ) = GetOccasionsEvent;
  factory OccasionsEvents.changeSelectedOccasion(String selectedOccasionId) =
      GetFlowersByOccasionsEvent;

  void when({
    required void Function(int id) getOccasions,
    required void Function(String occasionId) getFlowersByOccasions,
  }) => switch (this) {
    GetOccasionsEvent() => getOccasions((this as GetOccasionsEvent).index),
    GetFlowersByOccasionsEvent() => getFlowersByOccasions(
      (this as GetFlowersByOccasionsEvent).occasionId,
    ),
  };
}

class GetOccasionsEvent extends OccasionsEvents {
  final int index;

  GetOccasionsEvent(this.index);
}

class GetFlowersByOccasionsEvent extends OccasionsEvents {
  final String occasionId;
  const GetFlowersByOccasionsEvent(this.occasionId);
}
