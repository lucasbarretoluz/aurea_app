import 'package:freezed_annotation/freezed_annotation.dart';
import 'normalized_point.dart';

part 'curve_data.freezed.dart';
part 'curve_data.g.dart';

@freezed
abstract class CurveData with _$CurveData {
  const factory CurveData({
    @Default([]) List<NormalizedPoint> controlPoints,
  }) = _CurveData;

  factory CurveData.fromJson(Map<String, dynamic> json) =>
      _$CurveDataFromJson(json);
}
