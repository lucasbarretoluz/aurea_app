import 'package:freezed_annotation/freezed_annotation.dart';

enum GenderEnum {
  @JsonValue('MALE')
  male,
  @JsonValue('FEMALE')
  female,
  @JsonValue('OTHER')
  unknown;

  static GenderEnum fromString(String? value) {
    if (value == null) {
      return GenderEnum.unknown;
    }
    switch (value) {
      case 'MALE':
        return GenderEnum.male;
      case 'FEMALE':
        return GenderEnum.female;
      case 'OTHER':
        return GenderEnum.unknown;
      default:
        return GenderEnum.unknown;
    }
  }

  String get toStringName {
    switch (this) {
      case GenderEnum.male:
        return "Entrada";
      case GenderEnum.female:
        return "FEMALE";
      case GenderEnum.unknown:
        return "unknown";
    }
  }

  //from json
  static GenderEnum fromJson(String value) {
    switch (value) {
      case 'MALE':
        return GenderEnum.male;
      case 'FEMALE':
        return GenderEnum.female;
      case 'OTHER':
        return GenderEnum.unknown;
      default:
        return GenderEnum.unknown;
    }
  }

  //from enum
  static String fromEnum(GenderEnum value) {
    switch (value) {
      case GenderEnum.male:
        return 'MALE';
      case GenderEnum.female:
        return 'FEMALE';
      case GenderEnum.unknown:
        return 'unknown';
    }
  }
}



