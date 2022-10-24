import 'package:raro_pokedex/core/entites/http_response.dart';
import 'package:raro_pokedex/core/http/client_http.dart';

class DioClienteHttp implements ClientHttp {
  @override
  Future<HttpResponse> get(
      {required String url, Map<String, dynamic>? params}) {}
}
