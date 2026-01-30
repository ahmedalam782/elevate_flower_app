enum Gender {
  male,
  female,
}

extension GenderParsing on Gender {
  static Gender? fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      default:
        return null;
    }
  }
}