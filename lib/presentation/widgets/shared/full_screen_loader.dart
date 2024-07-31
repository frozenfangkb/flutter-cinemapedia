import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      "Cargando películas",
      "Comprando palomitas",
      "Cargando películas populares",
      "Intentando poner la película que más me gusta",
      "Esto está tardando más de lo esperado...",
      "Un mago no llega pronto ni tarde, llega justo cuando se lo propone... O eso dice Gandalf",
    ];

    return Stream.periodic(const Duration(milliseconds: 2000), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            strokeWidth: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: StreamBuilder(
                stream: getLoadingMessages(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text('Cargando');

                  return Text(
                    snapshot.data!,
                    textAlign: TextAlign.center,
                  );
                }),
          )
        ],
      ),
    );
  }
}
