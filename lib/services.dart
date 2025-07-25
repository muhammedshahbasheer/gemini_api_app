import "dart:convert";

import "package:http/http.dart" as http;

Future<String> chats(String prompts) async {
  final response = await http.post(
      Uri.parse(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=AIzaSyD_dNLhqBvaLyc8ayn1r7RYY-N5R8CsKoM"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompts}
            ]
          }
        ]
      }));
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return json['candidates'][0]["content"]["parts"][0]["text"];
  } else {
    return "something went wrong ";
  }
}
