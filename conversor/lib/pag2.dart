import 'package:flutter/material.dart';

class Pag extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Pag> {
  final convController = TextEditingController();
  final realController = TextEditingController();
  final moedaController = TextEditingController();

  double conv;
  String convR;
  String convM;

  void _clearAll() {
    realController.text = "";
    moedaController.text = "";
  }

  void realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    convR = text;
    double real = double.parse(text);
    moedaController.text = (real / conv).toStringAsFixed(2);
  }

  void moedaChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    convM = text;
    double real = double.parse(text);
    realController.text = (real * conv).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Crie sua própria moeda"),
          centerTitle: true,
          backgroundColor: Colors.amber,
        ),
        backgroundColor: Colors.brown,
        body: Container(
            child: Center(
                child: SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Qual o valor de 1 R\$ na sua moeda?",
                            style:
                                TextStyle(color: Colors.amber, fontSize: 22.0)),
                        Divider(),
                        TextFormField(
                          controller: convController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Valor \$: ",
                              labelStyle: TextStyle(color: Colors.amber),
                              border: OutlineInputBorder()),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.amber, fontSize: 21.0),
                          onChanged: (text) {
                            conv = double.parse(text);
                            moedaChanged(convM);
                            moedaChanged(convR);
                          },
                        ),
                        Divider(),
                        Text("Conversão:",
                            style:
                                TextStyle(fontSize: 21.0, color: Colors.amber)),
                        Divider(),
                        TextFormField(
                            controller: moedaController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Sua moeda \$: ",
                                labelStyle: TextStyle(color: Colors.amber),
                                border: OutlineInputBorder()),
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.amber, fontSize: 21.0),
                            onChanged: moedaChanged),
                        Divider(),
                        TextFormField(
                            controller: realController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "R\$: ",
                                labelStyle: TextStyle(color: Colors.amber),
                                border: OutlineInputBorder()),
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.amber, fontSize: 21.0),
                            onChanged: realChanged),
                      ],
                    )))));
  }
}
