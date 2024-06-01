import 'package:get/get.dart';
import 'package:objectbox/objectbox.dart';

abstract class IDatabase {
  static IDatabase get instance => Get.find<IDatabase>();

  Box<T> getBox<T>();
  T? getById<T>(int id);
  List<T> getAll<T>();
  List<T> findQuery<T>(QueryBuilder<T> query);
  void save<T>(T value);
  void saveAll<T>(List<T> values);
  void delete<T>(int id);
  void deleteAll<T>();
  void deleteMany<T>(List<int> ids);
}

class Database implements IDatabase {
  Database(Store store) : _store = store;

  final Store _store;

  @override
  Box<T> getBox<T>() => _store.box<T>();

  @override
  List<T> findQuery<T>(QueryBuilder<T> queryBuilder) {
    final query = queryBuilder.build();

    final result = query.find();

    query.close();

    return result;
  }

  @override
  T? getById<T>(int id) => getBox<T>().get(id);

  @override
  List<T> getAll<T>() => getBox<T>().getAll();

  @override
  void save<T>(T value) => getBox<T>().put(value);

  @override
  void saveAll<T>(List<T> values) => getBox<T>().putMany(values);

  @override
  void delete<T>(int id) => getBox<T>().remove(id);

  @override
  void deleteAll<T>() => getBox<T>().removeAll();

  @override
  void deleteMany<T>(List<int> ids) => getBox<T>().removeMany(ids);
}
