import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String _textInfo = "Informe seu peso e altura";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _limparCampos() {
    setState(() {
      pesoController.text = "";
      alturaController.text = "";
      _textInfo = "Informe seu peso e altura";
    });
  }

  void _calcular() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      //debugPrint("$imc");
      if (imc < 18.6)
        _textInfo = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      else if (imc >= 18.6 && imc < 24.9)
        _textInfo = "Peso ideal (${imc.toStringAsPrecision(4)})";
      else if (imc >= 24.9 && imc < 29.9)
        _textInfo = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      else if (imc >= 29.9 && imc < 34.9)
        _textInfo = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      else if (imc >= 34.9 && imc < 39.9)
        _textInfo = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      else if (imc >= 40)
        _textInfo = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Calculadora IMC"),
            centerTitle: true,
            backgroundColor: Colors.green,
            actions: [
              IconButton(onPressed: _limparCampos, icon: Icon(Icons.refresh))
            ]),
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 120,
                    color: Colors.green,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso:",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    controller: pesoController,
                    validator: (value) {
                      if (value!.isEmpty) return "Insira seu peso";
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura:",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    controller: alturaController,
                    validator: (value) {
                      if (value!.isEmpty) return "Insira sua altura";
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _calcular();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(fontSize: 25),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white)),
                      )),
                  Text(
                    _textInfo,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                  )
                ],
              ),
            )));
  }
}
