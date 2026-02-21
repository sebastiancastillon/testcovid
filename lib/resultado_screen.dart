import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ResultadoScreen extends StatelessWidget {
  final String nombre;
  final String curp;
  final bool posibleCovid;
  final List<String> sintomas;

  const ResultadoScreen({
    Key? key,
    required this.nombre,
    required this.curp,
    required this.posibleCovid,
    required this.sintomas,
  }) : super(key: key);

  String obtenerFechaActual() {
    final ahora = DateTime.now();
    return "${ahora.day}/${ahora.month}/${ahora.year}";
  }

  @override
  Widget build(BuildContext context) {
    String estado = posibleCovid
        ? "POSIBLE COVID - NO PUEDE PASAR"
        : "SIN INDICIOS GRAVES - PUEDE PASAR";

    String datosQR = """
Nombre: $nombre
CURP: $curp
Fecha: ${obtenerFechaActual()}
Síntomas: ${sintomas.join(", ")}
Estado: $estado
""";

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            const Text(
              "Resultado de Evaluación",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    estado,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: posibleCovid
                          ? Colors.redAccent
                          : const Color(0xFF22C55E),
                    ),
                  ),

                  const SizedBox(height: 15),
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 10),

                  Text("Nombre: $nombre"),
                  Text("CURP: $curp"),
                  Text("Fecha: ${obtenerFechaActual()}"),

                  const SizedBox(height: 15),

                  const Text(
                    "Síntomas seleccionados:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  Text(
                    sintomas.isEmpty ? "Ninguno" : sintomas.join(", "),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Código QR",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            QrImageView(
              data: datosQR,
              size: 220,
              backgroundColor: Colors.white,
            ),

            const SizedBox(height: 20),

            const Text(
              "Presente este código al ingresar",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
