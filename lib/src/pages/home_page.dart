import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:formvalidacion/src/blocs/provider.dart';
import 'package:formvalidacion/src/models/producto_model.dart';
import 'package:formvalidacion/src/providers/productos_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context); //Recibe

    return Scaffold(
      appBar: AppBar(title: Text('Home page')),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
        future: productosProvider.cargarProductos(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductoModel>> snapshot) {
          if (snapshot.hasData) {
            final productos = snapshot.data;
            return ListView.builder(
                itemCount: productos?.length,
                itemBuilder: (context, i) =>
                    _crearItem(context, productos![i]));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _crearItem(BuildContext context, ProductoModel producto) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) {
          productosProvider.borrarProducto(producto.id!);
        },
        child: Card(
          margin: EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 7.0,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(children: <Widget>[
            (producto.fotoUrl == null)
                ? Image(
                    image: AssetImage('assets/no-image.png'),
                    width: 500.0,
                  )
                : FadeInImage(
                    placeholder: AssetImage('assets/loading.gif'),
                    image: NetworkImage(producto.fotoUrl!),
                    height: 400.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            ListTile(
                trailing: Text(
                  '${producto.valor}¢',
                  style: TextStyle(
                      color: Color.fromARGB(255, 150, 128, 2),
                      fontWeight: FontWeight.bold),
                ),
                leading: Text(
                  producto.disponible ? 'Disponible' : 'No Disponible',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: producto.disponible
                          ? Colors.blue
                          : Color.fromARGB(255, 255, 100, 100)),
                ),
                onTap: () {
                  setState(() {});
                  Navigator.pushNamed(context, 'producto', arguments: producto);
                }),
            ListTile(
                title: Text(
                  '${producto.titulo}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(producto.id.toString()),
                onTap: () {
                  setState(() {});
                  Navigator.pushNamed(context, 'producto', arguments: producto);
                }),
          ]),
        ));
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'producto'),
      backgroundColor: Colors.deepPurple,
    );
  }
}
