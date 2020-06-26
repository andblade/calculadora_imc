import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados';

  void _resetField(){
    pesoController.text = '';
    alturaController.text = '';
    setState(() {
      _infoText = 'Informe seus dados';
      _formKey = GlobalKey<FormState>(); //limpar mensagem de erro junto dos valores
    });
  }

  void _calcular(){
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade grau I (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 40){
        _infoText = "Obesidade grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.refresh),
            onPressed: (){
              _resetField();
            }
          )
        ],
      ),

      backgroundColor: Colors.white,
      body: SingleChildScrollView( //Faz com que a tela role verticalmente
        padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, //Alarga tudo o que estiver dentro da coluna, w-100
            children: <Widget>[
              
              Icon(Icons.person_outline, size: 120.0, color: Colors.green, ),
              
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Peso (kg)", labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center, style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: pesoController,
                validator: (value){
                  if (value.isEmpty) {
                    return "Insira seu peso";
                  }
                },
              ),
              
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Altura (cm)", labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center, style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: alturaController,
                validator: (value){
                  if (value.isEmpty) {
                    return "Insira sua altura";
                  }
                },
              ),

              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 20),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: (){
                      if (_formKey.currentState.validate()) {
                        _calcular();
                      }
                    },
                    child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25),),
                    color: Colors.green,
                  )
                ),
              ),

              Text(_infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              )

            ],
          ),
        )
      )
    );
  }
}
