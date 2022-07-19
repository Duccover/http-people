import 'package:bany/models/person.dart';
import 'package:flutter/material.dart';
import '../models/respository.dart';
import 'package:http/http.dart' as http;
import '../bloc/create_Logic.dart';

class BlocEven extends ChangeNotifier {
  Respository respository = Respository();
  List<Person> _listP = [];
  List<Person>_searchP =[];

  get listP => _listP;
  get searchP => _searchP;
  bool loading = false;
  bool isBack = false;

  Future<void> getPostData() async {
    loading = true;
    _listP = await respository.getData();
    loading = false;
    notifyListeners();
  }

  Future<void> reloadData() async {
    _listP = await respository.getData();
    notifyListeners();
  }

  Future<void> createData(Person person) async {
    http.Response response = await respository.createData(person);
    if (response.statusCode == 201) {
      isBack = true;
    }
    notifyListeners();
  }

  Future<void> updateData(String id, Person person) async {
    http.Response response = await respository.updateData(id, person);
    if(response.statusCode == 200){
      isBack = true;
    }
    notifyListeners();
  }

  Future deleteData(String id) async {
    http.Response response = await respository.deleteData(id);
    if (response == 200) {
      return true;
    }
    notifyListeners();
  }

   Future searchData(String text)async{
    _searchP.clear();
    if (text.isEmpty) {
      loading = true;
      return;
    }
    notifyListeners();
   _listP.forEach((element) {
     if (element.findName!.contains(text))
       _searchP.add(element);
   });
    loading = true;
   notifyListeners();
  }
  }
