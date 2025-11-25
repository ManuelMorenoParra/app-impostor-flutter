import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Asegúrate de importar correctamente tu archivo main.dart
import 'package:impostor_futbol/main.dart'; // Cambié de 'MyApp' a 'ImpostorFutbolApp'

void main() {
  testWidgets('Smoke test: Counter increments', (WidgetTester tester) async {
    // Construir la aplicación y disparar un frame.
    await tester.pumpWidget(const ImpostorFutbolApp());

    // Verificar que el contador comience en 0.
    // Aquí, asumimos que el contador se muestra con el texto '0' inicialmente.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing); // No debería haber un 1 al principio.

    // Tocar el ícono de '+' (esto puede depender de cómo hayas definido el ícono en tu app)
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); // Esperamos que la UI se actualice después de la acción.

    // Verificar que el contador se haya incrementado a 1.
    expect(find.text('0'), findsNothing); // Ahora no debe haber un 0.
    expect(find.text('1'), findsOneWidget); // Debería haber un 1 después de la acción.
  });
}
