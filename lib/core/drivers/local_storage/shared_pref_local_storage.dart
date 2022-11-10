import 'package:raro_pokedex/core/drivers/local_storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefLocalStorage implements LocalStorage{
  SharedPreferences? prefsInstance;
  

  @override
  Future<List<String>> getList(String key) async {
    prefsInstance ??= await SharedPreferences.getInstance();
    return prefsInstance!.getStringList(key) ?? []; 

  }

  @override
  Future<void> setList(String key, List<String> list) async {
    prefsInstance ??= await SharedPreferences.getInstance();
    prefsInstance!.setStringList(key, list);
  }

}
