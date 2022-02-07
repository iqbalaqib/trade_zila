import 'dart:async';

import 'package:trade_zila/common/http/api_provider.dart';
import 'package:meta/meta.dart';

class HomeApiProvider {
  HomeApiProvider({@required this.baseUrl, @required this.apiProvider})
      : assert(apiProvider != null);

  final ApiProvider apiProvider;

  final String baseUrl;

  Future<Map<String, dynamic>> fetchBooks() {
    return apiProvider.get('$baseUrl/books');
  }
}
