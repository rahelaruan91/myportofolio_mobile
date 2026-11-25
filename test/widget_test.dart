import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  testWidgets('Home menampilkan menu portofolio', (tester) async {
    await tester.pumpWidget(MyApp(apiClient: ApiClient()));

    expect(find.text('Selamat datang di MyPortofolio Mobile!'), findsOneWidget);
    expect(find.text('Lihat Proyek'), findsOneWidget);
  });
}
