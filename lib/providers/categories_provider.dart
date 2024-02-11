import 'package:admin_dashboard/api/CafeApi.dart';
import 'package:admin_dashboard/models/categoria.dart';
import 'package:admin_dashboard/models/http/categories_response.dart';
import 'package:flutter/material.dart';

class CategoriesProvider extends ChangeNotifier{

  List <Categoria> categorias = [];

  getCategories() async{
    final resp = await CafeApi.httpGet('/categorias');
    final categoriesResp = CategoriesResponse.fromMap(resp);

    this.categorias = [...categoriesResp.categorias];

    print(this.categorias);

    notifyListeners();
  }

  Future newCategoria( String name) async{

    final data = {
      'nombre' : name
    };

    try{

      final json = await CafeApi.post('/categorias', data);
      final newCategoria = Categoria.fromMap(json);

      categorias.add( newCategoria);
      notifyListeners();

    }catch (e) {
      print(e);
      print(' Error al crear la categoria');
    }
  }

   Future updateCategoria(String id, String name) async{

    final data = {
      'nombre' : name
    };

    try{

      await CafeApi.put('/categorias/$id', data);

      this.categorias = this.categorias.map(
        (categoria) {
          if (categoria.id != id) return categoria;

          categoria.nombre= name;
          return categoria;
        }
      ).toList();
      notifyListeners();

    }catch (e) {
      print(e);
      print(' Error al crear la categoria');
    }
  }
}