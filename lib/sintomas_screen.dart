import 'package:flutter/material.dart';

class SintomasScreen extends StatefulWidget {
  final String nombre;
  final String curp;
  final Function(bool, List<String>) onDiagnosticoGenerado;

  const SintomasScreen({
    Key? key,
    required this.nombre,
    required this.curp,
    required this.onDiagnosticoGenerado,
  }) : super(key: key);

  @override
  State<SintomasScreen> createState() => _SintomasScreenState();
}

class _SintomasScreenState extends State<SintomasScreen> {
  bool fiebre = false;
  bool dolorCuerpo = false;
  bool perdidaOlfato = false;
  bool perdidaGusto = false;
  bool tos = false;
  bool none = false;

  bool get algunSintomaSeleccionado =>
      fiebre || dolorCuerpo || perdidaOlfato || perdidaGusto || tos || none;

  void generarDiagnostico() {
    List<String> sintomasSeleccionados = [];

    if (fiebre) sintomasSeleccionados.add("Fiebre");
    if (dolorCuerpo) sintomasSeleccionados.add("Dolor de cuerpo");
    if (perdidaOlfato) sintomasSeleccionados.add("Pérdida del olfato");
    if (perdidaGusto) sintomasSeleccionados.add("Pérdida del gusto");
    if (tos) sintomasSeleccionados.add("Tos");
    if (none) sintomasSeleccionados.add("Ninguno");

    bool posibleCovid = sintomasSeleccionados.length >= 2;

    widget.onDiagnosticoGenerado(posibleCovid, sintomasSeleccionados);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Text(
              "Evaluación de Síntomas",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "Paciente: ${widget.nombre}",
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CheckboxListTile(
                    activeColor: const Color(0xFF2563EB),
                    title: const Text("Fiebre"),
                    value: fiebre,
                    onChanged: (v) => setState(() => fiebre = v!),
                  ),

                  CheckboxListTile(
                    activeColor: const Color(0xFF2563EB),
                    title: const Text("Dolor de cuerpo"),
                    value: dolorCuerpo,
                    onChanged: (v) => setState(() => dolorCuerpo = v!),
                  ),

                  CheckboxListTile(
                    activeColor: const Color(0xFF2563EB),
                    title: const Text("Pérdida del olfato"),
                    value: perdidaOlfato,
                    onChanged: (v) => setState(() => perdidaOlfato = v!),
                  ),

                  CheckboxListTile(
                    activeColor: const Color(0xFF2563EB),
                    title: const Text("Pérdida del gusto"),
                    value: perdidaGusto,
                    onChanged: (v) => setState(() => perdidaGusto = v!),
                  ),

                  CheckboxListTile(
                    activeColor: const Color(0xFF2563EB),
                    title: const Text("Tos"),
                    value: tos,
                    onChanged: (v) => setState(() => tos = v!),
                  ),

                   CheckboxListTile(
                    activeColor: const Color(0xFF2563EB),
                    title: const Text("Ninguno"),
                    value: none,
                    onChanged: (v) => setState(() => none = v!),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          algunSintomaSeleccionado ? generarDiagnostico : null,
                      child: const Text("Generar Diagnóstico"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
