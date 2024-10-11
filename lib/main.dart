import 'package:bdflutter/Pessoa.dart';
import 'package:bdflutter/PessoaDAO.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "SQLite CRUD",
      home: Pagina1(),
    );
  }
}

class Pagina1 extends StatefulWidget {
  const Pagina1({super.key});

  @override
  State<Pagina1> createState() => _Pagina1State();
}

class _Pagina1State extends State<Pagina1> {
  final PessoaDAO _pessoaDAO = PessoaDAO();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _cartaoController = TextEditingController();

  List<Pessoa> _listaPessoas = [];
  Pessoa? _pessoaAtual;

  void _salvarOuEditar() async {
    if (_pessoaAtual == null) {
      //inserir novo

      await _pessoaDAO.insertPessoa(Pessoa(
        nome: _nomeController.text,
        cpf: _cpfController.text,
        creditcard: _cartaoController.text,
      ));

    } else {
      //atualizar existente
      _pessoaAtual!.nome = _nomeController.text;
      _pessoaAtual!.cpf = _nomeController.text;
      _pessoaAtual!.creditcard = _cartaoController.text;
      await _pessoaDAO.updatePessoa(_pessoaAtual!);
    }
    _nomeController.clear();
    _cpfController.clear();
    _cartaoController.clear();
    setState(() {
      _pessoaAtual = null;  
    });
    _loadPessoas();
  }

  @override
  void initState() {
    super.initState();
    _loadPessoas();
  }

  void _editarPessoa(Pessoa pessoa) {
    setState(() {
      _pessoaAtual = pessoa;
      _nomeController.text = pessoa.nome;
      _cpfController.text = pessoa.cpf;
      _cartaoController.text = pessoa.creditcard;
    });
  }

  void _deletePessoa(int index) async {
    await _pessoaDAO.deletePessoa(Pessoa(
      id: index,
      nome: '',
      cpf: '',
      creditcard: '',
    ));
    _loadPessoas();
  }

  void _loadPessoas() async {
    List<Pessoa> listaTemp = await _pessoaDAO.selectPessoas();
    setState(() {
      _listaPessoas = listaTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite CRUD'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _cpfController,
              decoration: const InputDecoration(labelText: 'CPF'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _cartaoController,
              decoration: const InputDecoration(labelText: 'Credit Card'),
            ),
          ),
          ElevatedButton(
            onPressed: _salvarOuEditar,
            child: Text(_pessoaAtual == null ? 'Salvar' : 'Atualizar'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _listaPessoas.length,
              itemBuilder: (context, index) {
                final Pessoa pessoa = _listaPessoas[index];
                return ListTile(
                  title: Text('Nome: ${pessoa.nome} - CPF: ${pessoa.cpf}'),
                  trailing: IconButton(
                    onPressed: () {
                      _deletePessoa(pessoa.id!);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  onTap: () {
                    _editarPessoa(pessoa);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
