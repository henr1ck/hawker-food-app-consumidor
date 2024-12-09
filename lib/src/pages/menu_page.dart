import 'package:flutter/material.dart';
import 'package:hawker_food/src/consts/categoria.dart';
import 'package:hawker_food/src/models/food.dart';
import 'package:hawker_food/src/pages/food_check.dart';

class MenuPage extends StatefulWidget {
  final List<Food> foods;

  final List<Categoria> categories;

  late final List<Food> selectedFoods;

  late final Categoria selectedCategory;

  MenuPage({
    super.key,
    required this.foods,
    required this.categories,
  }) {
    selectedFoods = foods;
    selectedCategory = Categoria.TODAS;
  }

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(children: [
          SizedBox(
            height: constraints.maxHeight * 0.07,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.amber,
                  border: Border(bottom: BorderSide(width: 0.5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Categoria: ${widget.selectedCategory.descricao}"),
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor:
                            const Color.fromARGB(255, 217, 217, 217),
                        builder: (BuildContext context) {
                          return DraggableScrollableSheet(
                            expand: false,
                            snap: false,
                            builder: (_, scrollController) {
                              return ListView(
                                controller: scrollController,
                                children: [
                                  ...widget.categories.map(
                                    (category) => ListTile(
                                      leading: Icon(
                                        size: 40,
                                        color: Colors.blueGrey,
                                        IconData(category.iconData.codePoint,
                                            fontFamily: 'MaterialIcons'),
                                      ),
                                      title: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(width: 0.2),
                                          ),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              if (category.descricao !=
                                                  Categoria.TODAS.descricao) {
                                                widget.selectedFoods =
                                                    widget.foods
                                                        .where(
                                                          (food) =>
                                                              food.categoriaId ==
                                                              category.codigo,
                                                        )
                                                        .toList();
                                                widget.selectedCategory =
                                                    category;
                                              } else {
                                                widget.selectedFoods =
                                                    widget.foods;
                                                widget.selectedCategory =
                                                    Categoria.TODAS;
                                              }
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Text(
                                            category.descricao,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    child: const Text(
                      "Selecionar categoria",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.93,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: widget.selectedFoods.length,
              itemBuilder: (context, index) {
                var food = widget.selectedFoods[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 8,
                    color: const Color.fromARGB(255, 217, 217, 217),
                    child: ListTile(
                      leading: food.imagem != null
                          ? Image(
                              image: AssetImage(food.imagem!),
                            )
                          : const Icon(Icons.food_bank),
                      title: Text(
                        food.nome,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(
                        food.descricao ?? "sem descrição",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                      trailing: Column(
                        children: [
                          Text("R\$${food.valor.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return FoodCheck(food);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ]);
      },
    );
  }
}
