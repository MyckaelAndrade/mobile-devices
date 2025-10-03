import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //variavel controlador o flutter já gerencia a mudança de status da variavel
  TextEditingController precoOpcaoAController = TextEditingController();
  TextEditingController precoOpcaoBController = TextEditingController();
  TextEditingController coeficienteController = TextEditingController();
  String _info = "Informe os preços das Opções";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool validate = false;
  


  void _resetFields() {
    precoOpcaoAController.text = "";
    precoOpcaoBController.text = "";
    coeficienteController.text = "";
    setState(() {
      _info = "Informe os preços das Opções!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcularMelhorPreco() {
    setState(() {
      double precoOpcaoA = double.parse(precoOpcaoAController.text);
      double precoOpcaoB = double.parse(precoOpcaoBController.text);
      int coeficientePorcentagem = int.parse(coeficienteController.text);
      double coeficiente = precoOpcaoA / precoOpcaoB;
      print(coeficiente);
      _info = (coeficiente <= (coeficientePorcentagem / 100))
          ? "Opcao A é a melhor opção"
          : "Opcao B é a melhor opção";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qual Opção comprar?"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //input da Opção B
              TextFormField(
                controller: precoOpcaoBController,
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  labelText: "Opção B:",
                  labelStyle: TextStyle(color: Colors.red),
                  hintText: 'ex: 4,50',
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 20.0),
              ),
              //input da Opção A
              TextFormField(
                controller: precoOpcaoAController,
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  labelText: "Opção A:",
                  labelStyle: TextStyle(color: Colors.red),
                  hintText: 'ex:R\$\ 4,50',
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 20.0),
              ),

              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: CupertinoButton(
                    onPressed: () {
                      //recolhe o teclado ao apertar o botão
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    color: Colors.blue,
                  ),
                ),
              ),
              Text(
                _info,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
