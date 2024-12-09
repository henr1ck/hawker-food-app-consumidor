class Food {
  final int id;
  final String nome;
  final String? descricao;
  final double valor;
  final String? imagem;
  final int categoriaId;

  Food({
    required this.id,
    required this.nome,
    this.descricao,
    required this.valor,
    this.imagem,
    required this.categoriaId,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'nome': String nome,
        'descricao': String? descricao,
        'valor': double valor,
        'imagem': String? imagem,
        'categoriaId': int categoriaId
      } =>
        Food(
            id: id,
            nome: nome,
            descricao: descricao,
            valor: valor,
            imagem: imagem,
            categoriaId: categoriaId),
      _ => throw const FormatException('Falha ao tentar recuperar a comida!')
    };
  }
}
