import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sn_advice/core/model/hive_model.dart';

class ApiServices {
  Future<List<HivePost>> getData() async {
    const url = 'https://api.hive.blog/';
    final header = {
      "accept": "application/json, text/plain, */*",
      "content-type": "application/json"
    };
    final body = jsonEncode({
      "id": 1,
      "jsonrpc": "2.0",
      "method": "bridge.get_ranked_posts",
      "params": {"sort": "trending", "tag": "", "observer": "hive.blog"}
    });

    try {
      final response =
          await http.post(Uri.parse(url), headers: header, body: body);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final postsData = List<Map<String, dynamic>>.from(jsonData["result"]);

        return postsData.map((e) => HivePost.fromJson(e)).toList();
      } else {
        throw Exception(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
