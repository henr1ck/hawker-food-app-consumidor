import 'package:hawker_food/src/models/food.dart';

class Cardapio {
  final int quantidade;
  final List<int> categorias;
  final List<Food> comidas;

  Cardapio({
    required this.quantidade,
    required this.categorias,
    required this.comidas,
  });

  factory Cardapio.fromJson(Map<String, dynamic> json) {
    /*return Cardapio(
      quantidade: json['quantidade'] as int,
      categorias: List.from(json['categorias']),
      comidas: (json['comidas'] as List<dynamic>)
          .map((j) => Food.fromJson(j))
          .toList(),
    );*/
    return switch (json) {
      {
        'quantidade': int quantidade,
        'categorias': List categorias,
        'comidas': List<dynamic> comidas,
      } =>
        Cardapio(
            quantidade: quantidade,
            categorias: List.from(categorias),
            comidas: comidas.map((comida) => Food.fromJson(comida)).toList()),
      _ => throw const FormatException(
          'Falha ao tentar buscar o cardápio do vendedor'),
    };
    
  }
}
