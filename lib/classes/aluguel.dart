class Aluguel {
  final String nome;
  final String produto;
  final String telefone;
  final String dataFim;
  final String dataInicio;
  final int valor;

  Aluguel(
      {
      required this.nome,
      required this.produto,
      required this.telefone,
      required this.dataFim,
      required this.dataInicio,
      required this.valor});

  Map<String, dynamic> toMap() => {
        "nome": nome,
        "produto": produto,
        'telefone': telefone,
        'dataInicio': dataInicio,
        'dataFim': dataFim,
        'valor': valor
      };
  factory Aluguel.fromMap(Map<String, dynamic> map) => Aluguel(
      nome: map['nome'],
      produto: map['produto'],
      telefone: map['telefone'],
      dataInicio: map['dataInicio'],
      dataFim: map['dataFim'],
      valor: map['valor']);
}
