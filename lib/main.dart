import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор площади',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _hContr = TextEditingController();
  final _wContr = TextEditingController();
  String _messageText = 'задайте параметры';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Калькулятор площади'),
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              TextFormField(
                controller: _wContr,
                decoration: InputDecoration(labelText: 'Ширина (мм):'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                maxLength: 5,
                validator: (val) => val!.isEmpty ? 'Задайте ширину' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _hContr,
                decoration: InputDecoration(labelText: 'Высота (мм):'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                maxLength: 5,
                validator: (val) => val!.isEmpty ? 'Задайте высоту' : null,
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => _submitForm(),
                child: const Text('Вычислить'),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  _messageText,
                  style: TextStyle(fontSize: 30),
                ),
              )
            ],
          )),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      int S = int.parse(_hContr.text) * int.parse(_wContr.text);
      setState(() {
        _messageText = 'S = ${_wContr.text} * ${_hContr.text} = $S (мм2)';
      });
    } else {
      setState(() {
        _messageText = 'задайте параметры';
      });
    }
  }
}
