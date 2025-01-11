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
        title: const Text('Edit Pokemon'),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Nama Pokemon Baru',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _controller.text);
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
