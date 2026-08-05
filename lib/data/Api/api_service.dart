import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tastmanager/data/models/task_model.dart';

class ApiService {
  Future<List<TaskItem>> getTodos() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/todos"),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => TaskItem.fromJson(e)).toList();
    }

    throw Exception("Failed to load todos");
  }
}
