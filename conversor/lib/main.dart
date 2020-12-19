import 'package:flutter/material.dart';
import 'pag2.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=b8456468";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.amber, primaryColor: Colors.white),
  ));
}

http.Response response;
Future<Map> getData() async {
  if (response == null) {
    response = await http.get(request);
  }
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar;
  double euro;
  String botao1C;
  String botao2C;
  List itens1 = ["Real", "Euro", "Dólar"];
  List itens2 = ["Real", "Euro", "Dólar"];

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  String prefix() {
    if (botao2C == 'Real') {
      return "R\$ ";
    }
    if (botao2C == 'Dólar') {
      return "US\$ ";
    } else {
      return "€ ";
    }
  }

  Function change() {
    if (botao2C == 'Real') {
      return _realChanged;
    }
    if (botao2C == 'Dólar') {
      return _dolarChanged;
    } else {
      return _euroChanged;
    }
  }

  TextEditingController controller() {
    if (botao2C == 'Real') {
      return realController;
    }
    if (botao2C == 'Dólar') {
      return dolarController;
    } else {
      return euroController;
    }
  }

  String prefix2() {
    if (botao1C == 'Real') {
      return "R\$ ";
    }
    if (botao1C == 'Dólar') {
      return "US\$ ";
    } else {
      return "€ ";
    }
  }

  Function change2() {
    if (botao1C == 'Real') {
      return _realChanged;
    }
    if (botao1C == 'Dólar') {
      return _dolarChanged;
    } else {
      return _euroChanged;
    }
  }

  TextEditingController controller2() {
    if (botao1C == 'Real') {
      return realController;
    }
    if (botao1C == 'Dólar') {
      return dolarController;
    } else {
      return euroController;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown,
        appBar: AppBar(
          title: Text("\$ Conversor \$"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                      child: Text(
                    "Carregando Dados...",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Erro ao Carregar Dados :(",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    dolar =
                        snapshot.data["results"]["currencies"]["USD"]["buy"];
                    euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                    return SingleChildScrollView(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(Icons.monetization_on,
                              size: 150.0, color: Colors.amber),
                          Center(
                            child: Text("Converter de:",
                              style: TextStyle(
                                  color: Colors.amber, fontSize: 25.0))),
                          Divider(),
                          Center(
                              child: Container(
                                  padding:
                                      EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButton(
                                      hint: Text("Real",
                                          style: TextStyle(
                                              color: Colors.amber,
                                              fontSize: 25.0)),
                                      value: botao1C,
                                      onChanged: (newValue) {
                                        setState(() {
                                          botao1C = newValue;
                                        });
                                      },
                                      items: itens1.map((valueItem) {
                                        return DropdownMenuItem(
                                          value: valueItem,
                                          child: Text(valueItem),
                                        );
                                      }).toList()))),
                          Divider(),
                          TextField(
                            controller: controller2(),
                            decoration: InputDecoration(
                                labelText: botao1C,
                                labelStyle: TextStyle(color: Colors.amber),
                                border: OutlineInputBorder(),
                                prefixText: prefix2()),
                            style:
                                TextStyle(color: Colors.amber, fontSize: 25.0),
                            onChanged: change2(),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                          ),
                          Divider(),
                          Center(
                              child: Container(
                                  padding:
                                      EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButton(
                                      value: botao2C,
                                      onChanged: (newValue) {
                                        setState(() {
                                          botao2C = newValue;
                                        });
                                      },
                                      items: itens2.map((valueItem) {
                                        return DropdownMenuItem(
                                          value: valueItem,
                                          child: Text(valueItem),
                                        );
                                      }).toList()))),
                          Divider(),
                          TextField(
                            controller: controller(),
                            decoration: InputDecoration(
                                labelText: botao2C,
                                labelStyle: TextStyle(color: Colors.amber),
                                border: OutlineInputBorder(),
                                prefixText: prefix()),
                            style:
                                TextStyle(color: Colors.amber, fontSize: 25.0),
                            onChanged: change(),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                          ),
                          Divider(),
                          RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pag(),
                                  ));
                            },
                            child: Text(
                              "Criar própria moeda",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 23.0),
                            ),
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    );
                  }
              }
            }));
  }
}

Widget buildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.amber, fontSize: 25.0),
    onChanged: f,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
  );
}
