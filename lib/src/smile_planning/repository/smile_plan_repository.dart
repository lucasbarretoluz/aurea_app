import 'dart:convert';

import 'package:aurea_app/src/smile_planning/models/smile_plan.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class SmilePlanRepository {
  Future<SmilePlan?> loadActive(int patientId);

  Future<SmilePlan?> loadForPhoto(int patientId, String photoUrl);

  Future<void> save(SmilePlan plan);

  Future<List<SmilePlan>> listByPatient(int patientId);

  Future<void> delete(String planId);

  Future<void> deleteForPhoto(int patientId, String photoUrl);

  Future<void> deleteByPatient(int patientId);
}

class SmilePlanLocalRepository implements SmilePlanRepository {
  static const _legacyKeyPrefix = 'smile_plan_';
  static const _listKeyPrefix = 'smile_plans_';

  String _legacyKey(int patientId) => '$_legacyKeyPrefix$patientId';

  String _listKey(int patientId) => '$_listKeyPrefix$patientId';

  @override
  Future<SmilePlan?> loadActive(int patientId) async {
    final plans = await listByPatient(patientId);
    if (plans.isEmpty) return null;

    final incomplete = plans.where((plan) => plan.completedAt == null).toList();
    if (incomplete.isEmpty) return plans.last;

    incomplete.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return incomplete.first;
  }

  @override
  Future<SmilePlan?> loadForPhoto(int patientId, String photoUrl) async {
    if (photoUrl.isEmpty) return null;

    final plans = await listByPatient(patientId);
    for (final plan in plans) {
      if (plan.photoUrl == photoUrl) return plan;
    }
    return null;
  }

  @override
  Future<void> save(SmilePlan plan) async {
    final plans = await listByPatient(plan.patientId);
    final updated = [...plans];

    final byIdIndex = updated.indexWhere((item) => item.id == plan.id);
    if (byIdIndex >= 0) {
      updated[byIdIndex] = plan;
    } else {
      final byPhotoIndex = updated.indexWhere(
        (item) => item.photoUrl == plan.photoUrl && plan.photoUrl.isNotEmpty,
      );
      if (byPhotoIndex >= 0) {
        updated[byPhotoIndex] = plan;
      } else {
        updated.add(plan);
      }
    }

    await _persistPlans(plan.patientId, updated);
  }

  @override
  Future<List<SmilePlan>> listByPatient(int patientId) async {
    final prefs = await SharedPreferences.getInstance();
    final listRaw = prefs.getString(_listKey(patientId));

    if (listRaw != null && listRaw.isNotEmpty) {
      final decoded = jsonDecode(listRaw) as List<dynamic>;
      return decoded
          .map((item) => SmilePlan.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    final legacyRaw = prefs.getString(_legacyKey(patientId));
    if (legacyRaw == null || legacyRaw.isEmpty) return [];

    final legacyPlan = SmilePlan.fromJson(
      jsonDecode(legacyRaw) as Map<String, dynamic>,
    );
    await _persistPlans(patientId, [legacyPlan]);
    await prefs.remove(_legacyKey(patientId));
    return [legacyPlan];
  }

  @override
  Future<void> deleteForPhoto(int patientId, String photoUrl) async {
    if (photoUrl.isEmpty) return;

    final plans = await listByPatient(patientId);
    final filtered = plans.where((plan) => plan.photoUrl != photoUrl).toList();
    if (filtered.length == plans.length) return;

    await _persistPlans(patientId, filtered);
  }

  @override
  Future<void> deleteByPatient(int patientId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_listKey(patientId));
    await prefs.remove(_legacyKey(patientId));
  }

  @override
  Future<void> delete(String planId) async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where(
      (key) =>
          key.startsWith(_listKeyPrefix) || key.startsWith(_legacyKeyPrefix),
    );

    for (final key in keys) {
      if (key.startsWith(_listKeyPrefix)) {
        final patientId = int.tryParse(key.replaceFirst(_listKeyPrefix, ''));
        if (patientId == null) continue;

        final plans = await listByPatient(patientId);
        final filtered = plans.where((plan) => plan.id != planId).toList();
        if (filtered.length != plans.length) {
          await _persistPlans(patientId, filtered);
          return;
        }
      } else {
        final raw = prefs.getString(key);
        if (raw == null) continue;
        final plan = SmilePlan.fromJson(jsonDecode(raw) as Map<String, dynamic>);
        if (plan.id == planId) {
          await prefs.remove(key);
          return;
        }
      }
    }
  }

  Future<void> _persistPlans(int patientId, List<SmilePlan> plans) async {
    final prefs = await SharedPreferences.getInstance();
    if (plans.isEmpty) {
      await prefs.remove(_listKey(patientId));
      return;
    }

    final encoded = jsonEncode(plans.map((plan) => plan.toJson()).toList());
    await prefs.setString(_listKey(patientId), encoded);
  }
}
