import 'package:flutter/material.dart';

class Libro {
  String titulo;
  String autor;
  int anioPublicacion;
  int cantidadDisponible;

  Libro(this.titulo, this.autor, this.anioPublicacion, this.cantidadDisponible);
}

class Biblioteca {
  List<Libro> libros;

  Biblioteca() : libros = [];

  void agregarLibro(Libro libro) {
    libros.add(libro);
  }

  List<Libro> buscarPorTitulo(String titulo) {
    return libros.where((libro) => 
      libro.titulo.toLowerCase().contains(titulo.toLowerCase())).toList();
  }

  List<Libro> obtenerTodosLosLibros() {
    return libros;
  }
}

class Ejercicio4 extends StatefulWidget {
  const Ejercicio4({super.key});

  @override
  State<Ejercicio4> createState() => _Ejercicio4State();
}

class _Ejercicio4State extends State<Ejercicio4> {
  Biblioteca biblioteca = Biblioteca();
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _autorController = TextEditingController();
  TextEditingController _anioController = TextEditingController();
  TextEditingController _cantidadController = TextEditingController();
  TextEditingController _buscarController = TextEditingController();
  List<Libro> librosMostrados = [];

  @override
  void initState() {
    super.initState();
    
   
    
    librosMostrados = biblioteca.obtenerTodosLosLibros();
  }

  void agregarLibro() {
    if (_tituloController.text.isNotEmpty && 
        _autorController.text.isNotEmpty &&
        _anioController.text.isNotEmpty &&
        _cantidadController.text.isNotEmpty) {
      
      setState(() {
        biblioteca.agregarLibro(Libro(
          _tituloController.text,
          _autorController.text,
          int.parse(_anioController.text),
          int.parse(_cantidadController.text),
        ));
        librosMostrados = biblioteca.obtenerTodosLosLibros();
        _tituloController.clear();
        _autorController.clear();
        _anioController.clear();
        _cantidadController.clear();
      });
    }
  }

  void buscarLibros() {
    setState(() {
      if (_buscarController.text.isEmpty) {
        librosMostrados = biblioteca.obtenerTodosLosLibros();
      } else {
        librosMostrados = biblioteca.buscarPorTitulo(_buscarController.text);
      }
    });
  }

  void mostrarTodos() {
    setState(() {
      librosMostrados = biblioteca.obtenerTodosLosLibros();
      _buscarController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sistema de Biblioteca'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Biblioteca Digital',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Agregar Nuevo Libro', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    TextField(
                      controller: _tituloController,
                      decoration: InputDecoration(labelText: 'Título', border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _autorController,
                      decoration: InputDecoration(labelText: 'Autor', border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _anioController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'Año', border: OutlineInputBorder()),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _cantidadController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'Cantidad', border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: agregarLibro,
                      child: Text('Agregar Libro'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _buscarController,
                    decoration: InputDecoration(
                      labelText: 'Buscar por título',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: buscarLibros,
                  child: Text('Buscar'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: mostrarTodos,
                  child: Text('Todos'),
                ),
              ],
            ),
            SizedBox(height: 20),
            
           
            
            Expanded(
              child: ListView.builder(
                itemCount: librosMostrados.length,
                itemBuilder: (context, index) {
                  Libro libro = librosMostrados[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: Icon(Icons.book, size: 40, color: Colors.blue),
                      title: Text(libro.titulo, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Autor: ${libro.autor}'),
                          Text('Año: ${libro.anioPublicacion}'),
                          Text('Disponibles: ${libro.cantidadDisponible}'),
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