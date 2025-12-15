import 'package:aurea_app/src/core/enums/gender_enum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GenderEnum', () {
    test('should have correct names', () {
      expect(GenderEnum.male.name, 'male');
      expect(GenderEnum.female.name, 'female');
      expect(GenderEnum.unknown.name, 'unknown');
    });

    test('should have correct enum values', () {
      expect(GenderEnum.male, GenderEnum.male);
      expect(GenderEnum.female, GenderEnum.female);
      expect(GenderEnum.unknown, GenderEnum.unknown);
      expect(GenderEnum.values.length, 3);
    });

    group('fromString', () {
      test('should return GenderEnum.male for "MALE"', () {
        expect(GenderEnum.fromString('MALE'), GenderEnum.male);
      });

      test('should return GenderEnum.female for "FEMALE"', () {
        expect(GenderEnum.fromString('FEMALE'), GenderEnum.female);
      });

      test('should return GenderEnum.unknown for "OTHER"', () {
        expect(GenderEnum.fromString('OTHER'), GenderEnum.unknown);
      });

      test('should return GenderEnum.unknown for null value', () {
        expect(GenderEnum.fromString(null), GenderEnum.unknown);
      });

      test('should return GenderEnum.unknown for empty string', () {
        expect(GenderEnum.fromString(''), GenderEnum.unknown);
      });

      test('should return GenderEnum.unknown for invalid value', () {
        expect(GenderEnum.fromString('invalid'), GenderEnum.unknown);
      });

      test('should return GenderEnum.unknown for lowercase "male"', () {
        expect(GenderEnum.fromString('male'), GenderEnum.unknown);
      });

      test('should return GenderEnum.unknown for lowercase "female"', () {
        expect(GenderEnum.fromString('female'), GenderEnum.unknown);
      });
    });

    group('fromEnum', () {
      test('should return "MALE" for GenderEnum.male', () {
        expect(GenderEnum.fromEnum(GenderEnum.male), 'MALE');
      });

      test('should return "FEMALE" for GenderEnum.female', () {
        expect(GenderEnum.fromEnum(GenderEnum.female), 'FEMALE');
      });

      test('should return "unknown" for GenderEnum.unknown', () {
        expect(GenderEnum.fromEnum(GenderEnum.unknown), 'unknown');
      });
    });

    group('fromJson', () {
      test('should return GenderEnum.male for "MALE"', () {
        expect(GenderEnum.fromJson('MALE'), GenderEnum.male);
      });

      test('should return GenderEnum.female for "FEMALE"', () {
        expect(GenderEnum.fromJson('FEMALE'), GenderEnum.female);
      });

      test('should return GenderEnum.unknown for "OTHER"', () {
        expect(GenderEnum.fromJson('OTHER'), GenderEnum.unknown);
      });

      test('should return GenderEnum.unknown for invalid value', () {
        expect(GenderEnum.fromJson('invalid'), GenderEnum.unknown);
      });

      test('should return GenderEnum.unknown for empty string', () {
        expect(GenderEnum.fromJson(''), GenderEnum.unknown);
      });
    });

    group('toStringName', () {
      test('should return "Entrada" for GenderEnum.male', () {
        expect(GenderEnum.male.toStringName, 'Entrada');
      });

      test('should return "FEMALE" for GenderEnum.female', () {
        expect(GenderEnum.female.toStringName, 'FEMALE');
      });

      test('should return "unknown" for GenderEnum.unknown', () {
        expect(GenderEnum.unknown.toStringName, 'unknown');
      });
    });

    group('enum properties', () {
      test('should have name property', () {
        expect(GenderEnum.male.name, 'male');
        expect(GenderEnum.female.name, 'female');
        expect(GenderEnum.unknown.name, 'unknown');
      });

      test('should have index property', () {
        expect(GenderEnum.male.index, 0);
        expect(GenderEnum.female.index, 1);
        expect(GenderEnum.unknown.index, 2);
      });

      test('should be iterable', () {
        expect(GenderEnum.values, contains(GenderEnum.male));
        expect(GenderEnum.values, contains(GenderEnum.female));
        expect(GenderEnum.values, contains(GenderEnum.unknown));
        expect(GenderEnum.values.length, 3);
      });
    });

    group('round-trip conversion', () {
      test('should convert fromEnum and back with fromString', () {
        final maleJson = GenderEnum.fromEnum(GenderEnum.male);
        expect(GenderEnum.fromString(maleJson), GenderEnum.male);

        final femaleJson = GenderEnum.fromEnum(GenderEnum.female);
        expect(GenderEnum.fromString(femaleJson), GenderEnum.female);
      });
    });
  });
}

