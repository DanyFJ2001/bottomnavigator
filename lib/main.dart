import 'package:bottom/screens/Ejercicio2.dart';
import 'package:bottom/screens/Ejercicio4.dart';
import 'package:flutter/material.dart';

void main(){
  runApp (Ejercicio3app());

}
class Ejercicio3app extends StatelessWidget {
  const Ejercicio3app({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Cuerpo(),
    );
  }
}

class Cuerpo extends StatefulWidget {
  const Cuerpo({super.key});

  @override
  State<Cuerpo> createState() => _CuerpoState();
}

class _CuerpoState extends State<Cuerpo> {
  int indice=0;
  List<Widget> paginas = [
  Ejercicio2(),
  Ejercicio4(),
  ];


  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text('Navegacion'),
        
      ),
      body: paginas[indice],
      

      bottomNavigationBar: BottomNavigationBar(
        
        currentIndex: indice,
        onTap: (value) {
          setState(() {
            indice = value;
          });
          
        },

        items: [
        BottomNavigationBarItem(icon: Icon(Icons.one_k), label: "Ejercicio 2"),
        BottomNavigationBarItem(icon: Icon(Icons.two_k), label: "Ejercicio 4"),
   
      ]),

    );
  
  }
}
