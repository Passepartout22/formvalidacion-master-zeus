import 'package:flutter/material.dart';
import 'package:formvalidacion/src/blocs/provider.dart';
import 'package:formvalidacion/src/pages/home_page.dart';
import 'package:formvalidacion/src/pages/login_page.dart';
import 'package:formvalidacion/src/pages/producto_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          'producto': (BuildContext context) => ProductoPage(),
          'pruebaCod': (BuildContext context) => HomePage(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme(
            brightness: Brightness.light, //Si es modo modo oscuro o normal[]
            primary: Colors
                .blue, //Como se menciona es el color primario que se presenta en la mayoria de las cosas
            onPrimary: Colors
                .white, //Pongamoslo así: Un boton es color amarillo, pero el color del texto dentro de éste debe resaltar por si solo, entonces le pones un color que contraste, en este caso negro

            secondary: Color.fromARGB(
                255, 255, 100, 100), //Lo mismo, será para cosas secundarias
            onSecondary: Colors.white, //Lo mismo, para resaltar del primero

            error: Colors.red, //Supongamos que no es para errores...
            onError: Colors.black, //Supongamos que no los sea.

            background: Colors.white, //El fondo
            onBackground: Colors
                .black, //El color de los objetos que contrasta lo primero. ¿Ya entiendes la relacion, verdad?

            surface: Colors
                .black, //Menciona que para targetas. Las Card, entonces, eso.
            onSurface: Colors.white, //¿Te tengo que decir para que sirve?
          ),
        ),
      ),
    );
  }
}
