import 'package:aurea_app/src/core/enums/gender_enum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GenderEnum', () {
    test('should have correct labels', () {
      expect(GenderEnum.male.label, 'MALE');
      expect(GenderEnum.female.label, 'FEMALE');
    });

    test('should have correct enum values', () {
      expect(GenderEnum.male, GenderEnum.male);
      expect(GenderEnum.female, GenderEnum.female);
      expect(GenderEnum.values.length, 2);
    });

    group('fromString', () {
      test('should return GenderEnum.male for "male"', () {
        expect(GenderEnum.fromString('male'), GenderEnum.male);
      });

      test('should return GenderEnum.male for "MALE"', () {
        expect(GenderEnum.fromString('MALE'), GenderEnum.male);
      });

      test('should return GenderEnum.male for "Male"', () {
        expect(GenderEnum.fromString('Male'), GenderEnum.male);
      });

      test('should return GenderEnum.female for "female"', () {
        expect(GenderEnum.fromString('female'), GenderEnum.female);
      });

      test('should return GenderEnum.female for "FEMALE"', () {
        expect(GenderEnum.fromString('FEMALE'), GenderEnum.female);
      });

      test('should return GenderEnum.female for "Female"', () {
        expect(GenderEnum.fromString('Female'), GenderEnum.female);
      });

      test('should return null for null value', () {
        expect(GenderEnum.fromString(null), isNull);
      });

      test('should return null for empty string', () {
        expect(GenderEnum.fromString(''), isNull);
      });

      test('should return null for invalid value', () {
        expect(GenderEnum.fromString('invalid'), isNull);
      });

      test('should return null for "other"', () {
        expect(GenderEnum.fromString('other'), isNull);
      });

      test('should return null for "unknown"', () {
        expect(GenderEnum.fromString('unknown'), isNull);
      });
    });

    group('toJson', () {
      test('should return "male" for GenderEnum.male', () {
        expect(GenderEnum.male.toJson(), 'male');
      });

      test('should return "female" for GenderEnum.female', () {
        expect(GenderEnum.female.toJson(), 'female');
      });

      test('should return enum name as string', () {
        expect(GenderEnum.male.toJson(), GenderEnum.male.name);
        expect(GenderEnum.female.toJson(), GenderEnum.female.name);
      });
    });

    group('enum properties', () {
      test('should have name property', () {
        expect(GenderEnum.male.name, 'male');
        expect(GenderEnum.female.name, 'female');
      });

      test('should have index property', () {
        expect(GenderEnum.male.index, 0);
        expect(GenderEnum.female.index, 1);
      });

      test('should be iterable', () {
        expect(GenderEnum.values, contains(GenderEnum.male));
        expect(GenderEnum.values, contains(GenderEnum.female));
        expect(GenderEnum.values.length, 2);
      });
    });

    group('round-trip conversion', () {
      test('should convert toJson and back with fromString', () {
        final maleJson = GenderEnum.male.toJson();
        expect(GenderEnum.fromString(maleJson), GenderEnum.male);

        final femaleJson = GenderEnum.female.toJson();
        expect(GenderEnum.fromString(femaleJson), GenderEnum.female);
      });
    });
  });
}

