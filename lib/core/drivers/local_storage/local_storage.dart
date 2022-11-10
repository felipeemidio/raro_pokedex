abstract class LocalStorage {
  Future<List<String>> getList(String key);
  Future<void> setList(String key, List<String> list);
  
}
