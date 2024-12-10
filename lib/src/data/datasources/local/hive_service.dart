import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class History {
  @HiveField(0)
  String expression;

  @HiveField(1)
  String result;

  @HiveField(2)
  DateTime createAt;

  History(
      {required this.expression, required this.result, required this.createAt});
}

class HistoryAdapter extends TypeAdapter<History> {
  @override
  final int typeId = 0;

  @override
  History read(BinaryReader reader) {
    return History(
      expression: reader.readString(),
      result: reader.readString(),
      createAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
    );
  }

  @override
  void write(BinaryWriter writer, History obj) {
    writer.writeString(obj.expression);
    writer.writeString(obj.result);
    writer.writeInt(obj.createAt.millisecondsSinceEpoch);
  }
}

class HiveService {
  static const String historyBox = 'history';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HistoryAdapter());
    await Hive.openBox<History>(historyBox);
  }

  static Future<List<History>> getAllHistory() async {
    final box = Hive.box<History>(historyBox);
    return box.values.toList();
  }

  static Future<void> addHistory(History history) async {
    final box = Hive.box<History>(historyBox);
    await box.add(history);
  }

  static List<History> getRecentHistory({int limit = 10}) {
    final box = Hive.box<History>(historyBox);
    final allHistory = box.values.toList();

    allHistory.sort((a, b) => b.createAt.compareTo(a.createAt));

    return allHistory.take(limit).toList();
  }
}
