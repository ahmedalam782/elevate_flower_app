AppFlavors myAppFlavor = DevelopmentFlavor();

sealed class AppFlavors {
  AppFlavors();
}

class DevelopmentFlavor extends AppFlavors {
  DevelopmentFlavor();
}

class ProductionFlavor extends AppFlavors {
  ProductionFlavor();
}
