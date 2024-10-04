class Pessoa {
  int? id;
  String nome;
  String cpf;
  String creditcard;

  Pessoa(
      {this.id,
      required this.nome,
      required this.cpf,
      required this.creditcard});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'creditcard': creditcard,
    };
  }

  factory Pessoa.fromMap(Map<String, dynamic> map) {
    return Pessoa(
      nome: map['nome'],
      cpf: map['cpf'],
      creditcard: map['creditcard'],
    );
  }
}
