import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'TambahPokemon.dart';
import 'EditPokemon.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=10'));

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
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListView.builder(
            shrinkWrap: true,
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
        ),
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