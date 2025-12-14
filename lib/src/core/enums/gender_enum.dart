enum GenderEnum {
  male('MALE'),
  female('FEMALE');

  final String label;

  const GenderEnum(this.label);

  static GenderEnum? fromString(String? value) {
    if (value == null) return null;
    
    switch (value.toLowerCase()) {
      case 'male':
        return GenderEnum.male;
      case 'female':
        return GenderEnum.female;
      default:
        return null;
    }
  }

  String toJson() {
    return name;
  }
}

