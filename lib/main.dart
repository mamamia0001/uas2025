import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'TambahPokemon.dart';
import 'EditPokemon.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Flutter',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: PokemonListPage(),
    );
  }
}

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  List<dynamic> _pokemonList = [];

  @override
  void initState() {
    super.initState();
    fetchPokemonList();
  }

  Future<void> fetchPokemonList() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _pokemonList = data['results'];
      });
    } else {
      throw Exception('Gagal memuat Pokemon');
    }
  }

  void addPokemon(String name) {
    setState(() {
      _pokemonList.add({'name': name});
    });
  }

  void editPokemon(int index, String newName) {
    setState(() {
      _pokemonList[index]['name'] = newName;
    });
  }

  void deletePokemon(int index) {
    setState(() {
      _pokemonList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon List'),
        backgroundColor: Colors.grey,
      ),
      body: ListView.builder(
        itemCount: _pokemonList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_pokemonList[index]['name']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPokemon(
                          initialName: _pokemonList[index]['name'],
                        ),
                      ),
                    );
                    if (result != null) {
                      editPokemon(index, result);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => deletePokemon(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahPokemon()),
          );
          if (result != null) {
            addPokemon(result);
          }
        },
      ),
    );
  }
}

