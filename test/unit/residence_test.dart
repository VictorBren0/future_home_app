import 'package:flutter_test/flutter_test.dart';
import 'package:future_home_app/models/residence_model.dart';
import 'package:future_home_app/providers/residence_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('ResidenceProvider', () {
    late ResidenceProvider residenceProvider;

    setUp(() async {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;

      residenceProvider = ResidenceProvider();
      await residenceProvider.getResidences();
    });

    test('Deve iniciar com lista de residências vazia', () {
      expect(residenceProvider.residences, isEmpty);
    });

    test('Deve adicionar residência corretamente', () async {
      final residence = ResidenceModel.fromMap({
        'id': 'res123',
        'type_residence': 'Casa',
        'address': 'Rua das Flores, 123',
        'neighborhood': 'Centro',
        'rt_address': 4,
        'nr_rooms': '3',
        'nr_bathrooms': '2',
        'nr_garages': '1',
        'fl_pool': 'Sim',
        'rt_details_residence': 5,
        'nm_seller': 'João da Silva',
        'phone_seller': '(11) 98765-4321',
        'price': 450000.00,
        'rt_seller': 4,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': null,
      });

      await residenceProvider.postResidence(residence);
      await residenceProvider.getResidences();

      expect(residenceProvider.residences.length, 1);
    });
    test('Deve atualizar residência corretamente', () async {
      final residence = ResidenceModel.fromMap({
        'id': 'res123',
        'type_residence': 'Casa',
        'address': 'Rua das Flores, 123',
        'neighborhood': 'Centro',
        'rt_address': 4,
        'nr_rooms': '3',
        'nr_bathrooms': '2',
        'nr_garages': '1',
        'fl_pool': 'Sim',
        'rt_details_residence': 5,
        'nm_seller': 'João da Silva',
        'phone_seller': '(11) 98765-4321',
        'price': 450000.00,
        'rt_seller': 4,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': null,
      });

      await residenceProvider.postResidence(residence);
      residence.address = "Rua das Flores, 456";
      await residenceProvider.putResidence(residence);
      await residenceProvider.getResidences();

      expect(residenceProvider.residences[0].address, "Rua das Flores, 456");
    });
    test('Deve excluir residência corretamente', () async {
      final residence = ResidenceModel.fromMap({
        'id': 'res123',
        'type_residence': 'Casa',
        'address': 'Rua das Flores, 123',
        'neighborhood': 'Centro',
        'rt_address': 4,
        'nr_rooms': '3',
        'nr_bathrooms': '2',
        'nr_garages': '1',
        'fl_pool': 'Sim',
        'rt_details_residence': 5,
        'nm_seller': 'João da Silva',
        'phone_seller': '(11) 98765-4321',
        'price': 450000.00,
        'rt_seller': 4,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': null,
      });

      await residenceProvider.postResidence(residence);
      await residenceProvider.deleteResidence(residence.id!);
      await residenceProvider.getResidences();

      expect(residenceProvider.residences, isEmpty);
    });
    test('Deve encontrar a residência pelo ID', () async {
      final residence = ResidenceModel.fromMap({
        'id': 'res123',
        'type_residence': 'Casa',
        'address': 'Rua das Flores, 123',
        'neighborhood': 'Centro',
        'rt_address': 4,
        'nr_rooms': '3',
        'nr_bathrooms': '2',
        'nr_garages': '1',
        'fl_pool': 'Sim',
        'rt_details_residence': 5,
        'nm_seller': 'João da Silva',
        'phone_seller': '(11) 98765-4321',
        'price': 450000.00,
        'rt_seller': 4,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': null,
      });

      await residenceProvider.postResidence(residence);
      final foundResidence = await residenceProvider.getResidenceId(residence.id);

      expect(foundResidence, isNotNull);
      expect(foundResidence!.id, residence.id);
    });
    test('Deve retornar null ao buscar residência inexistente', () async {
      final foundResidence = await residenceProvider.getResidenceId('inexistente');
      expect(foundResidence, isNull);
    });
  });
}
