import 'package:freezed_annotation/freezed_annotation.dart';

part 'veneer_style.freezed.dart';
part 'veneer_style.g.dart';

@freezed
abstract class VeneerStyle with _$VeneerStyle {
  const factory VeneerStyle({
    required String id,
    required String name,
    String? assetPath,
    String? url,
  }) = _VeneerStyle;

  factory VeneerStyle.fromJson(Map<String, dynamic> json) =>
      _$VeneerStyleFromJson(json);
}
