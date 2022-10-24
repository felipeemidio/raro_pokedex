import 'package:raro_pokedex/core/entites/http_response.dart';

abstract class ClientHttp {
  Future<HttpResponse> get({required String url, Map<String, dynamic>? params});
}
