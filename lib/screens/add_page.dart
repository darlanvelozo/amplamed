import 'package:amplamed/classes/aluguel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController dataInicioController = TextEditingController();
  final TextEditingController dataFinalController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  String produto = "Bota";
  int diaria = 6;
  @override
  Widget build(BuildContext context) {
    var largura = MediaQuery.of(context).size.width;
    var altura = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4da5aa),
        title: const Center(child: Text("Adicionar Aluguel")),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: largura * 0.05,
                right: largura * 0.05,
                top: altura * 0.05),
            child: TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: "nome",
                hintText: "ex: Maria de Sousa",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: largura * 0.05,
                right: largura * 0.05,
                top: altura * 0.05,
                bottom: altura * 0.02),
            child: TextField(
              controller: numberController,
              decoration: const InputDecoration(
                labelText: "Numero",
                hintText: "(DDD) 9 9999-8888",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: largura * 0.05,
                right: largura * 0.05,
                top: altura * 0.05,
                bottom: altura * 0.02),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        produto = "Bota";
                      });
                    },
                    style: TextButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Colors.grey.shade300),
                    child: const Text("Bota"),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(child: Text(produto)),
                    decoration: const BoxDecoration(color: Color(0xffccaa6a)),
                  ),
                  flex: 1,
                ),
                Expanded(
                  flex: 2,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        produto = "Muleta";
                      });
                    },
                    style: TextButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Colors.grey.shade300),
                    child: const Text("Muleta"),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: largura * 0.05,
                right: largura * 0.05,
                top: altura * 0.05,
                bottom: altura * 0.02),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: dataInicioController,
                    decoration: const InputDecoration(
                      labelText: "Data Inicial",
                      hintText: "25/02/2022",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                  flex: 1,
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: dataFinalController,
                    decoration: const InputDecoration(
                      labelText: "Data Final",
                      hintText: "28/07/2022",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: certo,
        child: const Icon(Icons.save),
        backgroundColor: const Color(0xffccaa6a),
      ),
    );
  }

  void certo() {
    if (nomeController.text.isNotEmpty &&
        numberController.text.isNotEmpty &&
        dataInicioController.text.isNotEmpty &&
        dataFinalController.text.isNotEmpty) {
      Aluguel aluguel = Aluguel(
          nome: nomeController.text,
          produto: produto,
          telefone: numberController.text,
          dataFim: dataFinalController.text,
          dataInicio: dataInicioController.text,
          valor: diaria);

      FirebaseFirestore.instance
          .collection('alugueis')
          .doc(aluguel.nome)
          .set(aluguel.toMap());

      nomeController.clear();
      numberController.clear();
      dataFinalController.clear();
      dataInicioController.clear();

      Navigator.pop(context);
    } else {
      null;
    }
  }
}
