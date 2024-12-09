import 'package:flutter/material.dart';
import 'package:hawker_food/src/consts/categoria.dart';
import 'package:hawker_food/src/models/bag_model.dart';
import 'package:hawker_food/src/models/cardapio.dart';
import 'package:hawker_food/src/models/hawker.dart';
import 'package:hawker_food/src/pages/bag_page.dart';
import 'package:hawker_food/src/pages/menu_page.dart';
import 'package:hawker_food/src/services/hawker_service.dart';
import 'package:provider/provider.dart';

class HawkerPage extends StatefulWidget {
  final int vendedorId;

  HawkerPage({
    super.key,
    required this.vendedorId,
  });

  @override
  State<HawkerPage> createState() => _HawkerPageState();
}

class _HawkerPageState extends State<HawkerPage> {
  final HawkerService service = HawkerService();

  late Future<Hawker> futureHawker;

  late Future<Cardapio> futureCardapio;

  late List<int> categories;

  late BagModel bagModel;

  int _index = 0;

  @override
  void initState() {
    super.initState();
    bagModel = context.read<BagModel>();
    futureHawker = service.fetchHawker(widget.vendedorId);
    futureCardapio = service.fetchCardapioByVendedor(widget.vendedorId);
  }

  @override
  void dispose() {
    bagModel.clear();
    super.dispose();
  }

  List<Categoria> obterCategorias(List<int> codigos) {
    List<Categoria> todas = Categoria.values;
    List<Categoria> categorias = [];
    categorias.add(Categoria.TODAS);
    for (var categoria in todas) {
      for (var codigo in codigos) {
        if (categoria.codigo == codigo) {
          categorias.add(categoria);
        }
      }
    }
    return categorias;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          width: 150,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        title: FutureBuilder(
          future: futureHawker,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Hawker hawker = snapshot.data!;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Image(
                    image: AssetImage('assets/hawker.png'),
                    height: 64,
                    width: 64,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(hawker.nome),
                      Text(
                        "Realiza entrega: ${hawker.realizaEntrega ? "Sim" : "Não"}",
                      ),
                      Text(
                        "Média de avaliação: ${hawker.mediaAvaliacao}",
                      ),
                    ],
                  ),
                  const Image(
                    image: AssetImage('assets/denuncia.png'),
                    height: 32,
                    width: 32,
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return const Row(
                children: [
                  Text("Erro ao carregar o perfil do vendedor"),
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      body: FutureBuilder(
        future: futureCardapio,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Cardapio cardapio = snapshot.data!;
            return <Widget>[
              MenuPage(
                foods: cardapio.comidas,
                categories: obterCategorias(cardapio.categorias),
              ),
              const Placeholder(),
              const BagPage()
            ][_index];
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CircularProgressIndicator();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: "Cardápio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Avaliação",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Sacola",
          )
        ],
      ),
    );
  }
}
