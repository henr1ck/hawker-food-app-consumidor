import 'package:flutter/material.dart';
import 'package:hawker_food/src/models/bag_model.dart';
import 'package:provider/provider.dart';

class BagPage extends StatefulWidget {
  
  const BagPage({super.key});

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  @override
  Widget build(BuildContext context) {
    var foods = context.watch<BagModel>().items;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: foods.length,
      itemBuilder: (context, index) {
        var food = foods[index];
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
                  : null,
              title: Text(
                food.nome,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                food.descricao ?? "Sem descrição",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
              trailing: Column(
                children: [
                  Text("R\$${food.valor.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
              onTap: () {},
            ),
          ),
        );
      },
    );
  }
}
