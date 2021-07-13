import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class ApiData {
  fetchAdvice() async {
    var url = Uri.https('api.adviceslip.com', '/advice');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse['slip']['advice'];
    }
  }

  searchAdvice(String query) async {
    var url = Uri.https('api.adviceslip.com', '/advice/search/$query');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    }
  }
}
