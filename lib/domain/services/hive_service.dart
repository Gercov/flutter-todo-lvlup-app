import 'dart:async';
import 'package:hive/hive.dart';

class HiveService {
  final _boxOpening = Hive.openBox('lvlupbox');

  static final instance = HiveService._();

  HiveService._();

  Future<List> getData(String keyName) async {
    final _box = await _boxOpening;
    return await _box.get(keyName) ?? [];
  }

  Future<void> saveData(String keyName, List data) async {
    final _box = await _boxOpening;
    await _box.put(keyName, data);
  }
}
