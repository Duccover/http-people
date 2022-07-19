import 'dart:convert';
import 'dart:io';
import 'package:bany/models/person.dart';
import 'package:http/http.dart' as http;

class Respository {
  String url = 'https://62b585aa42c6473c4b34323a.mockapi.io/json-try';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<Person> person = it.map((e) => Person.fromJson(e)).toList();
        return person;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future createData(Person data) async {
    http.Response? response;
    try {
      response = await http.post(Uri.parse(url),
          body: jsonEncode(data.toJson()),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    } catch (e) {
      print(e.toString());
    }
    return response;
  }

  Future updateData(String id, Person person) async {
    http.Response response;
    try {
      response = await http.put(Uri.parse('$url/$id'),
          body: jsonEncode(person.toJson()),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    } catch (e) {
      return e.toString();
    }
    return response;
  }

  Future deleteData(String id) async {
    http.Response response;
    try {
      response = await http.delete(Uri.parse('$url/$id'));
    } catch (e) {
      return e.toString();
    }
    return response;
  }
}
