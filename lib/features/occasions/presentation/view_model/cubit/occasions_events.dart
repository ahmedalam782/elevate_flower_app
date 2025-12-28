sealed class OccasionsEvents {
  const OccasionsEvents();
  factory OccasionsEvents.getOccasions() = GetOccasionsEvent;
  factory OccasionsEvents.changeSelectedOccasion(String selectedOccasionId) =
      GetFlowersByOccasionsEvent;

  void when({
    required void Function() getOccasions,
    required void Function(String occasionId) getFlowersByOccasions,
  }) => switch (this) {
    GetOccasionsEvent() => getOccasions(),
    GetFlowersByOccasionsEvent() => getFlowersByOccasions(
      (this as GetFlowersByOccasionsEvent).occasionId,
    ),
  };
}

class GetOccasionsEvent extends OccasionsEvents {}

class GetFlowersByOccasionsEvent extends OccasionsEvents {
  final String occasionId;
  const GetFlowersByOccasionsEvent(this.occasionId);
}
