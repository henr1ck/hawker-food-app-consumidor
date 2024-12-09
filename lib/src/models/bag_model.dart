import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hawker_food/src/err/resource_exception.dart';
import 'package:hawker_food/src/models/food.dart';

class BagModel extends ChangeNotifier {
  final List<Food> _items = [];

  UnmodifiableListView<Food> get items {
    return UnmodifiableListView(_items);
  }

  List<Food> byId(int id) {
    return _items.where((i) => i.id == id).toList();
  }

  double totalValue(int id) {
    return byId(id).fold(0.0, (previous, element) => previous + element.valor);
  }

  int sizeById(int id) {
    return byId(id).length;
  }

  add(Food food) {
    _items.add(food);
    notifyListeners();
  }

  removeById(int id) {
    try {
      _items.remove(
        _items.firstWhere((item) => item.id == id),
      );
    } catch (e) {
      throw ResourceNotFoundException("O item não está presente na sacola!");
    }

    notifyListeners();
  }
  
  void clear() {
    _items.clear();
  }
}
