import 'package:flutter/material.dart';
import 'datos_screen.dart';
import 'sintomas_screen.dart';
import 'resultado_screen.dart';

void main() {
  runApp(const CovidApp());
}

class CovidApp extends StatelessWidget {
  const CovidApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFF1D4ED8),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F172A),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2563EB),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1E293B),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFF2563EB),
              width: 2,
            ),
          ),
          labelStyle: const TextStyle(color: Colors.white70),
        ),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1E293B),
          selectedItemColor: Color(0xFF2563EB),
          unselectedItemColor: Colors.white54,
        ),
      ),

      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  String nombre = "";
  String curp = "";
  bool datosCompletados = false;

  bool posibleCovid = false;
  List<String> sintomasSeleccionados = [];

  void guardarDatos(String nombreIngresado, String curpIngresado) {
    setState(() {
      nombre = nombreIngresado;
      curp = curpIngresado;
      datosCompletados = true;
      _currentIndex = 1;
    });
  }

  void guardarDiagnostico(bool covid, List<String> sintomas) {
    setState(() {
      posibleCovid = covid;
      sintomasSeleccionados = sintomas;
      _currentIndex = 2;
    });
  }

  void cambiarTab(int index) {
    if (!datosCompletados && index != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Primero debes ingresar tus datos"),
        ),
      );
      return;
    }

    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      DatosScreen(onDatosCompletados: guardarDatos),

      SintomasScreen(
        nombre: nombre,
        curp: curp,
        onDiagnosticoGenerado: guardarDiagnostico,
      ),

      ResultadoScreen(
        nombre: nombre,
        curp: curp,
        posibleCovid: posibleCovid,
        sintomas: sintomasSeleccionados,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Control Sanitario Escolar"),
      ),
      body: screens[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: cambiarTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Datos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.healing),
            label: "Síntomas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: "Resultado",
          ),
        ],
      ),
    );
  }
}
