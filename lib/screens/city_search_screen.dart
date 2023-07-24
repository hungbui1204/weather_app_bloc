import 'package:flutter/material.dart';

class CitySearchScreen extends StatefulWidget {
  const CitySearchScreen({Key? key}) : super(key: key);

  @override
  State<CitySearchScreen> createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  final TextEditingController _cityTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter a city'),
      ),
      body: Form(
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextFormField(
                controller: _cityTextController,
                decoration: const InputDecoration(
                    labelText: 'Enter a city', hintText: 'Example: Hanoi'),
              ),
            )),
            IconButton(
                onPressed: () {
                  Navigator.pop(context, _cityTextController.text);
                },
                icon: const Icon(Icons.search))
          ],
        ),
      ),
    );
  }
}
