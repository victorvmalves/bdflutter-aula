import 'package:bdflutter/DatabaseHelper.dart';
import 'package:bdflutter/Pessoa.dart';
import 'package:sqflite/sqflite.dart';

class PessoaDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> insertPessoa(Pessoa pessoa) async {
    final db = await _dbHelper.database;
    await db.insert('pessoa', pessoa.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updatePessoa(Pessoa pessoa) async {
    final db = await _dbHelper.database;
    await db.update('pessoa', pessoa.toMap(),
        where: 'id = ?', whereArgs: [pessoa.id]);
  }

  Future<void> deletePessoa(int index) async {
    final db = await _dbHelper.database;
    await db.delete('pessoa', where: 'id = ?', whereArgs: [index]);
  }

  Future<List<Pessoa>> selectPessoas() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> tipoJSON = await db.query('pessoa');
    return List.generate(tipoJSON.length, (i) {
      return Pessoa.fromMap(tipoJSON[i]);
    });
  }
}
