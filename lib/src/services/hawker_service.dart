import 'dart:convert';
import 'dart:io';

import 'package:hawker_food/src/consts/consts.dart';
import 'package:hawker_food/src/err/resource_exception.dart';
import 'package:hawker_food/src/models/cardapio.dart';
import 'package:hawker_food/src/models/hawker.dart';
import 'package:hawker_food/src/models/user_credential.dart';
import 'package:http/http.dart' as http;

class HawkerService {
  
  String urlBase = Consts().urlBase;

  Future<Hawker> fetchHawker(int id) async {
    String? token = await UserCredentialModel().readToken();
    print(token);
    var response = await http.get(Uri.parse("$urlBase/vendedor/$id"), headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    if(response.statusCode == 200){
      return Hawker.fromJson(jsonDecode(utf8.decode(response.body.codeUnits)) as Map<String, dynamic>);

    } else if (response.statusCode == 401) {
      throw Exception("Erro de autenticação!");

    } else {
      throw ResourceNotFoundException("Não foi possível buscar informações do vendedor!");

    }
  }

  Future<Cardapio> fetchCardapioByVendedor(int vendedorId) async {
    String? token = await UserCredentialModel().readToken();
    print(token);
    var response = await http.get(Uri.parse("$urlBase/vendedor/$vendedorId/cardapio"), headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    if(response.statusCode == 200){
      return Cardapio.fromJson(jsonDecode(utf8.decode(response.body.codeUnits)) as Map<String, dynamic>);

    } else if (response.statusCode == 401) {
      throw Exception("Erro de autenticação!");

    } else {
      throw ResourceNotFoundException("Não foi possível buscar informações do cardápio do vendedor!");

    }
  }
 
}