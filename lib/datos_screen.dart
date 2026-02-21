import 'package:flutter/material.dart';

class DatosScreen extends StatefulWidget {
  final Function(String, String) onDatosCompletados;

  const DatosScreen({Key? key, required this.onDatosCompletados})
      : super(key: key);

  @override
  State<DatosScreen> createState() => _DatosScreenState();
}

class _DatosScreenState extends State<DatosScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController curpController = TextEditingController();

  void enviarDatos() {
    if (_formKey.currentState!.validate()) {
      widget.onDatosCompletados(
        nombreController.text.trim(),
        curpController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),

              const Text(
                "Ingreso de Datos",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
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
                    TextFormField(
                      controller: nombreController,
                      decoration: const InputDecoration(
                        labelText: "Nombre Completo",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingresa tu nombre";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      controller: curpController,
                      decoration: const InputDecoration(
                        labelText: "CURP",
                      ),
                      maxLength: 18,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingresa tu CURP";
                        }
                        if (value.length < 18) {
                          return "La CURP debe tener 18 caracteres";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: enviarDatos,
                        child: const Text("Continuar"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
