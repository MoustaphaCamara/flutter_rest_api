import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/currency.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Currency>? _currencies;

  void _loadData() async {
    const url = "https://api.frankfurter.app/currencies";
    final response = await http.get(Uri.parse(url));
    final body = response.body;
    final json =
        jsonDecode(body); // as Map<String, dynamic>, or try handling the error
    if (json is Map<String, dynamic>) {
      setState(() {
        _currencies =
            json.entries.map((e) => Currency(e.value, e.key)).toList();
      });
    }
  }

  Widget _wBody() {
    if (_currencies == null) {
      return const Center(
          child: CircularProgressIndicator(color: Colors.purple));
    }
    return ListView.builder(
      itemCount: _currencies!.length,
      itemBuilder: (context, index) {
        final currency = _currencies![index];
        return ListTile(
          title: Text('${currency.code} - ${currency.name}'),
          // trailing: Icon(Icons.arrow_forward),
        );
      },
    );
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Api screen"),
      ),
      body: _wBody(),
    );
  }
}
