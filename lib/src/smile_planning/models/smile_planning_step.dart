import 'package:freezed_annotation/freezed_annotation.dart';

enum SmilePlanningStep {
  @JsonValue('faceCenter')
  faceCenter,
  @JsonValue('faceMidline')
  faceMidline,
  @JsonValue('faceBipupillary')
  faceBipupillary,
  @JsonValue('faceHighSmileLine')
  faceHighSmileLine,
  @JsonValue('smilePhotoSelect')
  smilePhotoSelect,
  @JsonValue('smileMidline')
  smileMidline,
  @JsonValue('smileHighLine')
  smileHighLine,
  @JsonValue('smileCurve')
  smileCurve,
  @JsonValue('designShape')
  designShape,
  @JsonValue('designAdjust')
  designAdjust,
  @JsonValue('designVeneer')
  designVeneer,
  @JsonValue('designResult')
  designResult,
}

extension SmilePlanningStepRoutes on SmilePlanningStep {
  String get routePath {
    switch (this) {
      case SmilePlanningStep.faceCenter:
        return '/smile-planning/face/center';
      case SmilePlanningStep.faceMidline:
        return '/smile-planning/face/midline';
      case SmilePlanningStep.faceBipupillary:
        return '/smile-planning/face/bipupillary';
      case SmilePlanningStep.faceHighSmileLine:
        return '/smile-planning/face/high-smile-line';
      case SmilePlanningStep.smilePhotoSelect:
        return '/smile-planning/smile/photo-select';
      case SmilePlanningStep.smileMidline:
        return '/smile-planning/smile/midline';
      case SmilePlanningStep.smileHighLine:
        return '/smile-planning/smile/high-line';
      case SmilePlanningStep.smileCurve:
        return '/smile-planning/smile/curve';
      case SmilePlanningStep.designShape:
        return '/smile-planning/design/shape';
      case SmilePlanningStep.designAdjust:
        return '/smile-planning/design/adjust';
      case SmilePlanningStep.designVeneer:
        return '/smile-planning/design/veneer';
      case SmilePlanningStep.designResult:
        return '/smile-planning/design/result';
    }
  }

  String get title {
    switch (this) {
      case SmilePlanningStep.faceCenter:
        return 'Centralize o rosto do paciente';
      case SmilePlanningStep.faceMidline:
        return 'Posicione a linha média';
      case SmilePlanningStep.faceBipupillary:
        return 'Posicione a linha bipupilar';
      case SmilePlanningStep.faceHighSmileLine:
        return 'Posicione a linha alta do sorriso';
      case SmilePlanningStep.smilePhotoSelect:
        return 'Selecione a foto de referência';
      case SmilePlanningStep.smileMidline:
        return 'Posicione a linha média';
      case SmilePlanningStep.smileHighLine:
        return 'Posicione a linha alta do sorriso';
      case SmilePlanningStep.smileCurve:
        return 'Posicione a curva do sorriso';
      case SmilePlanningStep.designShape:
        return 'Selecione o formato dos dentes';
      case SmilePlanningStep.designAdjust:
        return 'Ajuste os dentes';
      case SmilePlanningStep.designVeneer:
        return 'Selecione o estilo de facetas';
      case SmilePlanningStep.designResult:
        return 'Resultado do planejamento';
    }
  }

  SmilePlanningStep? get next {
    const order = SmilePlanningStep.values;
    final index = order.indexOf(this);
    if (index < 0 || index >= order.length - 1) return null;
    return order[index + 1];
  }

  SmilePlanningStep? get previous {
    const order = SmilePlanningStep.values;
    final index = order.indexOf(this);
    if (index <= 0) return null;
    return order[index - 1];
  }

  static SmilePlanningStep? fromLocation(String location) {
    for (final step in SmilePlanningStep.values) {
      if (location == step.routePath || location.endsWith(step.routePath)) {
        return step;
      }
    }
    return null;
  }
}
