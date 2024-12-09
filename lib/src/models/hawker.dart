class Hawker {
  int id;
  String nome;
  String? imagem;
  bool realizaEntrega;
  bool status;
  double? mediaAvaliacao;

  Hawker({
    required this.id,
    required this.nome,
    this.imagem,
    required this.realizaEntrega,
    this.mediaAvaliacao,
    required this.status,
  });

  factory Hawker.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'nome': String nome,
        'imagem': String? imagem,
        'realizaEntrega': bool realizaEntrega,
        'status': bool status,
        'mediaAvaliacao': double? mediaAvaliacao,
      } =>
        Hawker(
          id: id,
          nome: nome,
          imagem: imagem,
          realizaEntrega: realizaEntrega,
          status: status,
          mediaAvaliacao: mediaAvaliacao,
        ),
      _ => throw const FormatException('Falha ao tentar buscar o vendedor'),
    };
  }
}
