import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> currencies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rest API call"),
      ),
      body: ListView.builder(
          itemCount: currencies.length, itemBuilder: (context, index) {}),
      floatingActionButton: const FloatingActionButton(
        onPressed: fetchCurrencies,
      ),
    );
  }

  static Future<dynamic> fetchCurrencies() async {
    const endpoint = 'https://api.frankfurter.app';
    final responseCurrencies =
        await http.get(Uri.parse('$endpoint/currencies'));
    final currencies = jsonDecode(responseCurrencies.body);
    print(currencies);
    print(responseCurrencies.body);
    return [];
  }

/*
void fetchUsers() async {
  const endpoint = 'https://api.frankfurter.app';
  const url = '$endpoint/currencies';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  final json = response.body;
  print(json);
  setState(() {
    currencies = json;
    print("fetchUsers completed");
  });
}
   */
}
