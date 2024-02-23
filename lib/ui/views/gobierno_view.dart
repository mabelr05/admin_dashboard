import 'package:flutter/material.dart';

class GobiernoView extends StatelessWidget {
  const GobiernoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Acerca del Co-Gobierno Estudiantil',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Bienvenido al Co-Gobierno Estudiantil del ISTL',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.network(
                'https://scontent.fgye30-1.fna.fbcdn.net/v/t39.30808-6/331294415_1594208977770229_2178802347627194246_n.png?_nc_cat=101&ccb=1-7&_nc_sid=783fdb&_nc_ohc=tgXRt9X6ZawAX-esf8L&_nc_ht=scontent.fgye30-1.fna&oh=00_AfAng3et2NQlda0YRDnSBApvZeqFOjyQjVgBs9ydqHlKKQ&oe=65DBAF86',
                width: 1500,
                height: 500,
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Descripción del Co-Gobierno',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Ubicacion: Calle Granada, vía a Turunuma - Loja, Ecuador',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: Colors.indigo, // Color azul
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'El concepto de Co-Gobierno Estudiantil en el Instituto Superior Tecnológico Loja representa un paso significativo hacia la participación activa y la representación equitativa de los estudiantes en la toma de decisiones que afectan su entorno educativo y su comunidad en general. Al estar conformado por un estudiante que representa cada tecnología y un presidente, este sistema garantiza una voz diversa y especializada que considera las necesidades específicas de cada área de estudio dentro del instituto.',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10), // Espacio entre párrafos
                  Text(
                    'La inclusión de un representante por cada tecnología asegura que los estudiantes de diferentes áreas de estudio tengan voz y voto en los asuntos que les conciernen específicamente. Esto es crucial, ya que cada tecnología puede tener desafíos, preocupaciones y necesidades particulares que merecen atención y soluciones adaptadas a sus circunstancias únicas. Además, esta estructura fomenta la diversidad de ideas y perspectivas, enriqueciendo así el proceso de toma de decisiones y promoviendo la innovación en el ámbito académico y administrativo.',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10), // Espacio entre párrafos
                  Text(
                    'Por otro lado, la figura del presidente del Co-Gobierno Estudiantil desempeña un papel central al proporcionar liderazgo y coordinación en el funcionamiento efectivo de esta instancia. El presidente actúa como un facilitador de diálogo y colaboración entre los representantes de las diferentes tecnologías, asegurando que se escuchen todas las voces y se llegue a consensos que beneficien a toda la comunidad estudiantil. Asimismo, el presidente representa a los estudiantes ante las autoridades del instituto, abogando por sus intereses y derechos de manera efectiva y proactiva.',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10), // Espacio entre párrafos
                  Text(
                    'Además de ser un espacio para la representación estudiantil, el Co-Gobierno Estudiantil también cumple un importante rol en el fortalecimiento de la comunidad estudiantil y en la promoción de valores como la solidaridad, el respeto y la responsabilidad. A través de actividades, proyectos y campañas, el Co-Gobierno Estudiantil puede contribuir a crear un ambiente inclusivo y colaborativo donde todos los estudiantes se sientan valorados y apoyados en su desarrollo académico y personal.',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 16,
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
