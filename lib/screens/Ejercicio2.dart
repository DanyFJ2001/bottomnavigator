import 'package:flutter/material.dart';

class Materia {
  String nombre;
  List<double> notas;

  Materia(this.nombre) : notas = [];

  void agregarNota(double nota) {
    notas.add(nota);
  }

  double calcularPromedio() {
    if (notas.isEmpty) return 0.0;
    double suma = 0;
    for (double nota in notas) {
      suma += nota;
    }
    return suma / notas.length;
  }
}

class Estudiante {
  String nombre;
  List<Materia> materias;

  Estudiante(this.nombre) : materias = [];

  void agregarMateria(Materia materia) {
    materias.add(materia);
  }

  double promedioGeneral() {
    if (materias.isEmpty) return 0.0;
    double sumaPromedios = 0;
    for (Materia materia in materias) {
      sumaPromedios += materia.calcularPromedio();
    }
    return sumaPromedios / materias.length;
  }
}

class Ejercicio2 extends StatefulWidget {
  const Ejercicio2({super.key});

  @override
  State<Ejercicio2> createState() => _Ejercicio2State();
}

class _Ejercicio2State extends State<Ejercicio2> {
  Estudiante estudiante = Estudiante('Dany fernandez');
  TextEditingController _materiaController = TextEditingController();
  TextEditingController _notaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    Materia matematicas = Materia('Desarrollo de Software');
    matematicas.agregarNota(8.5);
    matematicas.agregarNota(7.0);
    matematicas.agregarNota(9.0);

    Materia historia = Materia('Historia');
    historia.agregarNota(6.5);
    historia.agregarNota(8.0);
    historia.agregarNota(7.5);

    estudiante.agregarMateria(matematicas);
    estudiante.agregarMateria(historia);
  }

  void agregarMateria() {
    if (_materiaController.text.isNotEmpty) {
      setState(() {
        estudiante.agregarMateria(Materia(_materiaController.text));
        _materiaController.clear();
      });
    }
  }

  void agregarNota(int materiaIndex) {
    if (_notaController.text.isNotEmpty) {
      double nota = double.parse(_notaController.text);
      setState(() {
        estudiante.materias[materiaIndex].agregarNota(nota);
        _notaController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sistema de Notas - ${estudiante.nombre}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estudiante: ${estudiante.nombre}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Promedio General: ${estudiante.promedioGeneral().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            SizedBox(height: 20),
            
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _materiaController,
                    decoration: InputDecoration(
                      labelText: 'Nueva Materia',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: agregarMateria,
                  child: Text('Agregar'),
                ),
              ],
            ),
            SizedBox(height: 20),
            
            Expanded(
              child: ListView.builder(
                itemCount: estudiante.materias.length,
                itemBuilder: (context, index) {
                  Materia materia = estudiante.materias[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            materia.nombre,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text('Promedio: ${materia.calcularPromedio().toStringAsFixed(2)}'),
                          Text('Notas: ${materia.notas.join(', ')}'),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _notaController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Nueva Nota',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () => agregarNota(index),
                                child: Text('Agregar'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}