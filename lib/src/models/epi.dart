class Epi {
  final int id;
  final String nome;
  final String categoria;
  final String ca;
  final String imagemUrl;
  final int quantidadeDisponivel;
  final String validadeCa;

  Epi({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.ca,
    required this.imagemUrl,
    required this.quantidadeDisponivel,
    required this.validadeCa,
  });

  bool get isCaVencido {
    final dataValidade = DateTime.tryParse(validadeCa);
    return dataValidade != null && dataValidade.isBefore(DateTime.now());
  }

  factory Epi.fromJson(Map<String, dynamic> json) {
    return Epi(
      id: json['id'],
      nome: json['nome'],
      categoria: json['categoria'],
      ca: json['ca'],
      imagemUrl: json['imagemUrl'],
      quantidadeDisponivel: json['quantidadeDisponivel'] ?? 0,
      validadeCa: json['validadeCa'] ?? '',
    );
  }
}
