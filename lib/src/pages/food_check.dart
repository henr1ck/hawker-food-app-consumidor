import 'package:flutter/material.dart';
import 'package:hawker_food/src/models/bag_model.dart';
import 'package:hawker_food/src/models/food.dart';
import 'package:provider/provider.dart';

class FoodCheck extends StatelessWidget {
  final Food food;

  const FoodCheck(this.food, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          food.nome,
          maxLines: 2,
        ),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(255, 217, 217, 217),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.9,
                child: Column(
                  children: [
                    // Image.asset(
                    //   widget.food.imagem,
                    //   height: 200,
                    //   width: 200,
                    //   fit: BoxFit.fill,
                    // ),
                    Column(
                      crossAxisAlignment: food.descricao != null
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(
                            food.descricao != null
                                ? "Descrição"
                                : "Sem descrição",
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: food.descricao != null
                                  ? FontStyle.normal
                                  : FontStyle.italic,
                              fontWeight: food.descricao != null
                                  ? FontWeight.bold
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                        food.descricao != null
                            ? Text(food.descricao!)
                            : Container()
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.1,
                child: Material(
                  color: Colors.amber,
                  elevation: 12,
                  child: Consumer<BagModel>(
                    builder: (context, bag, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              "Valor total: R\$${bag.totalValue(food.id).toStringAsFixed(2)}"),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  try {
                                    bag.removeById(food.id);
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 2),
                                        content: Text(e.toString(),
                                            textAlign: TextAlign.center),
                                      ),
                                    );
                                  }
                                },
                                icon: Icon(
                                  color: bag.sizeById(food.id) < 1
                                      ? Colors.grey
                                      : Colors.black,
                                  Icons.remove,
                                ),
                              ),
                              Text("${bag.sizeById(food.id)}"),
                              IconButton(
                                color: Colors.black,
                                onPressed: () {
                                  bag.add(food);
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
