import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/weather.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const routeName = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _submitForm() {
    FocusScope.of(context).unfocus();
    final formState = _formKey.currentState;
    if (formState != null && formState.validate()) {
      formState.save();
      Navigator.of(context).pushNamed(Weather.routeName, arguments: _city);
    }
  }

  String? _city;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
              children: [
                TextFormField(
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'Please enter the title of product';
                    }
                    return null;
                  },
                  onSaved: (input) => _city = input,
                  decoration: const InputDecoration(
                    labelText: 'City',
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ],
            )),
          )),
    );
  }
}
