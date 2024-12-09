import 'package:flutter/material.dart';

class Categoria {
  final int codigo;
  final String descricao;
  final IconData iconData;

  const Categoria._(this.codigo, this.descricao, this.iconData);

  static const TODAS = Categoria._(-1, "Todas", Icons.select_all);
  static const ACAI = Categoria._(1, 'Açaí', Icons.icecream);
  static const ASSADOS = Categoria._(2, 'Assados', Icons.bakery_dining);
  static const BEBIDAS = Categoria._(3, 'Bebidas', Icons.local_drink);
  static const BOLOS = Categoria._(4, 'Bolos', Icons.cake);
  static const CAFES = Categoria._(5, 'Cafés', Icons.coffee);
  static const CACHORRO_QUENTE = Categoria._(6, 'Cachorro quente', Icons.fastfood);
  static const CHURROS = Categoria._(7, 'Churros', Icons.donut_small);
  static const CHURRASCO = Categoria._(8, 'Churrasco', Icons.fireplace);
  static const COMIDA_ARABE = Categoria._(9, 'Comida árabe', Icons.rice_bowl);
  static const COMIDA_ASIATICA = Categoria._(10, 'Comida asiática', Icons.soup_kitchen);
  static const COMIDA_MEXICANA = Categoria._(11, 'Comida mexicana', Icons.local_dining);
  static const CREPES = Categoria._(12, 'Crepes', Icons.flatware);
  static const DOCES = Categoria._(13, 'Doces', Icons.cookie);
  static const ESPETINHOS = Categoria._(14, 'Espetinhos', Icons.kebab_dining);
  static const FRUTAS = Categoria._(15, 'Frutas', Icons.apple);
  static const HAMBURGUERS = Categoria._(16, 'Hambúrgueres', Icons.lunch_dining);
  static const LANCHES_REGIONAIS = Categoria._(17, 'Lanches regionais', Icons.emoji_food_beverage);
  static const MASSAS = Categoria._(18, 'Massas', Icons.dining);
  static const MILKSHAKES = Categoria._(19, 'Milkshakes', Icons.icecream);
  static const PASTEL = Categoria._(20, 'Pastel', Icons.local_pizza);
  static const PETISCOS = Categoria._(21, 'Petiscos', Icons.fastfood);
  static const PICOLES = Categoria._(22, 'Picolés', Icons.ac_unit);
  static const PIZZAS = Categoria._(23, 'Pizzas', Icons.local_pizza);
  static const SALADAS = Categoria._(24, 'Saladas', Icons.eco);
  static const SALGADOS = Categoria._(25, 'Salgados', Icons.restaurant);
  static const SANDUICHES = Categoria._(26, 'Sanduíches', Icons.lunch_dining);
  static const SORVETES = Categoria._(27, 'Sorvetes', Icons.icecream);
  static const SUCOS_NATURAIS = Categoria._(28, 'Sucos naturais', Icons.local_drink);
  static const VEGANO = Categoria._(29, 'Vegano', Icons.grass);
  static const VEGETARIANO = Categoria._(30, 'Vegetariano', Icons.eco);

  static const List<Categoria> values = [
    ACAI,
    ASSADOS,
    BEBIDAS,
    BOLOS,
    CAFES,
    CACHORRO_QUENTE,
    CHURROS,
    CHURRASCO,
    COMIDA_ARABE,
    COMIDA_ASIATICA,
    COMIDA_MEXICANA,
    CREPES,
    DOCES,
    ESPETINHOS,
    FRUTAS,
    HAMBURGUERS,
    LANCHES_REGIONAIS,
    MASSAS,
    MILKSHAKES,
    PASTEL,
    PETISCOS,
    PICOLES,
    PIZZAS,
    SALADAS,
    SALGADOS,
    SANDUICHES,
    SORVETES,
    SUCOS_NATURAIS,
    VEGANO,
    VEGETARIANO,
  ];

  @override
  String toString() => 'Categoria(codigo: $codigo, descricao: $descricao, icon: $iconData)';
}
