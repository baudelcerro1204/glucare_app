import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  void _navigateToDetails(BuildContext context, String title) {
    String content;
    switch (title) {
      case 'Información sobre Diabetes tipo 1':
        content = '''
La diabetes tipo 1 es una enfermedad crónica en la que el páncreas produce poca o ninguna insulina, una hormona necesaria para permitir que el azúcar (glucosa) entre en las células para producir energía. 
La diabetes tipo 1 es una enfermedad autoinmune. El sistema inmunológico del cuerpo, que normalmente combate a los patógenos, ataca por error a las células beta productoras de insulina en el páncreas.

Posibles síntomas:
• Aumento de la sed y la micción frecuente.
• Hambre extrema.
• Pérdida de peso no intencional.
• Fatiga y debilidad.
• Visión borrosa.
• Infecciones frecuentes en la piel, la boca o la vagina.
• Irritabilidad y otros cambios de humor.

Tratamiento:
El tratamiento de la diabetes tipo 1 implica el manejo cuidadoso de los niveles de azúcar en la sangre. Las estrategias incluyen:
• Insulina: Todas las personas con diabetes tipo 1 necesitan insulina exógena para sobrevivir. La insulina se puede administrar mediante inyecciones diarias o a través de una bomba de insulina.
• Monitoreo de glucosa en sangre: Las personas con diabetes tipo 1 deben controlar regularmente sus niveles de glucosa en sangre mediante dispositivos de monitoreo.
• Dieta saludable: Seguir un plan de alimentación saludable que se ajuste a sus necesidades individuales.
        ''';        
        break;
      case 'Información sobre Diabetes tipo 2':
        content = '''
La diabetes tipo 2 es una enfermedad crónica que afecta la manera en que el cuerpo metaboliza el azúcar (glucosa), que es una fuente importante de combustible para el cuerpo. A diferencia de la diabetes tipo 1, donde el cuerpo no produce insulina, en la diabetes tipo 2 el cuerpo se vuelve resistente a la insulina o no produce suficiente insulina para mantener niveles normales de glucosa en sangre.

Posibles síntomas:
• Aumento de la sed y la micción frecuente.
• Hambre extrema.
• Pérdida de peso no intencional.
• Fatiga.
• Visión borrosa.
• Infecciones frecuentes, especialmente en las encías, la piel y la vejiga.
• Áreas oscuras en la piel, generalmente en las axilas y el cuello (acantosis nigricans).

Tratamiento:
El tratamiento de la diabetes tipo 2 implica varios enfoques para mantener los niveles de glucosa en sangre dentro de un rango saludable:
• Dieta saludable: Comer alimentos ricos en nutrientes y bajos en grasas y calorías, como frutas, verduras y granos enteros.
• Ejercicio regular: La actividad física ayuda a bajar los niveles de glucosa en sangre y aumenta la sensibilidad a la insulina.
        ''';        
        break;
      case 'Información sobre Diabetes gestacional':
        content = '''
La diabetes gestacional es un tipo de diabetes que se desarrolla durante el embarazo y generalmente desaparece después del parto. Es importante identificar y manejar adecuadamente la diabetes gestacional para evitar complicaciones tanto para la madre como para el bebé.
La diabetes gestacional ocurre cuando el cuerpo de una mujer embarazada no puede producir suficiente insulina durante el embarazo. Durante la gestación, la placenta produce hormonas que pueden causar resistencia a la insulina, haciendo que sea más difícil para el cuerpo usar la insulina de manera efectiva.

Factores de Riesgo:
Los factores que aumentan el riesgo de desarrollar diabetes gestacional incluyen:
• Obesidad: Tener un índice de masa corporal (IMC) de 30 o más.
• Antecedentes familiares: Tener un familiar cercano con diabetes tipo 2.
• Edad: Ser mayor de 25 años al quedar embarazada.
• Antecedentes personales: Haber tenido diabetes gestacional en un embarazo anterior o haber dado a luz a un bebé muy grande (más de 4Kg).
• Condiciones médicas previas: Tener síndrome de ovario poliquístico (SOP) o prediabetes.

Posibles síntomas:
• Aumento de la sed.
• Micción frecuente.
• Fatiga.
''';
        break;
      case 'Información sobre medicación':
        content = '''
El tratamiento farmacológico para la diabetes depende del tipo de diabetes y de las necesidades específicas del paciente.
Medicamentos para la Diabetes Tipo 1:
1. Insulina de acción rápida:
  • Ejemplos: Insulina lispro (Humalog), insulina aspart (NovoLog), insulina glulisina (Apidra)
  • Inicio de acción: 10-30 minutos.
  • Duración: 3-5 horas.
  • Uso: Administrada antes de las comidas para controlar el aumento rápido de glucosa en sangre.
2. Insulina de acción corta (regular):
  • Ejemplo: Humulin R, Novolin R.
  • Inicio de acción: 30-60 minutos.
  • Duración: 5-8 horas.
  • Uso: Administrada antes de las comidas.
3. Insulina de acción intermedia:
  • Ejemplo: Insulina NPH (Humulin N, Novolin N).
  • Inicio de acción: 1-3 horas.
  • Duración: 12-18 horas.
  • Uso: Administrada una o dos veces al día para el control basal.
4. Insulina de acción prolongada:
  • Ejemplos: Insulina glargina (Lantus, Toujeo), insulina detemir (Levemir), insulina degludec (Tresiba).
  • Inicio de acción: 1-2 horas.
  • Duración: Hasta 24 horas o más.
''';
        break;
      case 'Información sobre cómo manejar situaciones de hipoglucemia':
        content = '''
La hipoglucemia, o bajo nivel de glucosa en sangre, es una condición que puede ocurrir en personas con diabetes, especialmente aquellas que están en tratamiento con insulina o ciertos medicamentos antidiabéticos. Manejar adecuadamente las situaciones de hipoglucemia es crucial para evitar complicaciones graves. Aquí te proporciono una guía detallada sobre cómo manejar estas situaciones: 

Reconocer los Síntomas de Hipoglucemia:
Los síntomas de hipoglucemia pueden variar, pero los más comunes incluyen:
• Temblor o nerviosismo.
• Sudoración.
• Hambre intensa.
• Mareos o desorientación.
• Palpitaciones.
• Dolor de cabeza.
• Irritabilidad o cambios de humor.
• Confusión.
• Pérdida de coordinación.
• Somnolencia.
• En casos graves, pérdida del conocimiento o convulsiones.

Medir los Niveles de Glucosa en Sangre:
Ante la sospecha de hipoglucemia, lo primero que se debe hacer es medir los niveles de glucosa en sangre con un glucómetro. Un nivel de glucosa por debajo de 70 mg/dL (3.9 mmol/L) generalmente se considera hipoglucemia.
''';        
        break;
      case 'Información sobre cómo manejar situaciones de hiperglucemia':
        content = '''
La hiperglucemia, o niveles elevados de glucosa en sangre, es una preocupación común para las personas con diabetes. Manejar adecuadamente las situaciones de hiperglucemia es fundamental para prevenir complicaciones a corto y largo plazo. Aquí te proporciono una guía detallada sobre cómo manejar estas situaciones:

Reconocer los Síntomas de Hiperglucemia:
Los síntomas de hiperglucemia pueden variar, pero los más comunes incluyen:
• Sed excesiva.
• Micción frecuente.
• Visión borrosa.
• Fatiga.
• Sequedad de boca.
• Pérdida de peso no intencional.
• Dificultad para concentrarse.
• Dolor de cabeza.
• Náuseas y vómitos.

Medir los Niveles de Glucosa en Sangre:
Ante la sospecha de hiperglucemia, lo primero que se debe hacer es medir los niveles de glucosa en sangre con un glucómetro. Un nivel de glucosa por encima de 180 mg/dL (10 mmol/L) generalmente se considera hiperglucemia.
''';
        break;
      default:
        content = 'Información no disponible';
        break;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InformationDetailsScreen(title: title, content: content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFFC0DEF4),
      ),
      body: Container(
        color: const Color(0xFFC0DEF4), // Fondo azul claro
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.info_outline,
                  color: Color(0xFFC0DEF4),
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Información sobre la diabetes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButton<String>(
                  hint: const Text('Seleccionar una sección:'),
                  items: <String>[
                    'Información sobre Diabetes tipo 1',
                    'Información sobre Diabetes tipo 2',
                    'Información sobre Diabetes gestacional',
                    'Información sobre medicación',
                    'Información sobre cómo manejar situaciones de hipoglucemia',
                    'Información sobre cómo manejar situaciones de hiperglucemia'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      _navigateToDetails(context, value);
                    }
                  },
                  underline: Container(),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '¿Necesitas más ayuda? Recuerda contactar a tu médico de cabecera para una atención profesional.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InformationDetailsScreen extends StatelessWidget {
  final String title;
  final String content;

  const InformationDetailsScreen(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFC0DEF4),
      ),
      body: Container(
        color: const Color(0xFFC0DEF4),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF2A629A),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
