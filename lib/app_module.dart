import 'package:flutter_modular/flutter_modular.dart';
import 'package:raro_pokedex/core/drivers/local_storage/local_storage.dart';
import 'package:raro_pokedex/core/drivers/local_storage/shared_pref_local_storage.dart';
import 'package:raro_pokedex/core/entites/http_response.dart';
import 'package:raro_pokedex/core/drivers/http/client_http.dart';
import 'package:raro_pokedex/core/drivers/http/dio_client_http.dart';
import 'package:raro_pokedex/modules/home/pages/home/home_module.dart';
import 'package:raro_pokedex/modules/login/login_module.dart';
import 'package:raro_pokedex/modules/app/splash_page.dart';

class FakeClientHttp2 implements ClientHttp {
  @override
  Future<HttpResponse> get(
      {required String url, Map<String, dynamic>? params}) async {
    throw Exception();
  }
}

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<ClientHttp>((i) => DioClientHttp()),
        Bind<LocalStorage>((i) => SharedPrefLocalStorage())
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => SplashPage()),
        ModuleRoute('/login', module: LoginModule()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
