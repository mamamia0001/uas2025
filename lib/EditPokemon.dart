import 'package:flutter/material.dart';

class EditPokemon extends StatelessWidget {
  final String initialName;
  final TextEditingController _controller;

  EditPokemon({required this.initialName})
      : _controller = TextEditingController(text: initialName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pokémon'),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Nama Pokémon'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  Navigator.pop(context, _controller.text);
                }
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
