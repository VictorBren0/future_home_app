import 'package:flutter/material.dart';
import 'package:future_home_app/models/residence_model.dart';
import 'package:future_home_app/services/database_helper.dart';

class ResidenceProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<ResidenceModel> _residences = [];

  List<ResidenceModel> get residences => _residences;

  // Carregar todas as residências
  Future<void> getResidences() async {
    notifyListeners();

    _residences = await _dbHelper.getResidences();

    notifyListeners();
  }

  // Inserir nova residência e atualizar a lista
  Future<void> postResidence(ResidenceModel residence) async {
    await _dbHelper.insertResidence(residence);
    await getResidences();
  }

  // Atualizar residência e atualizar a lista
  Future<void> putResidence(ResidenceModel residence) async {
    await _dbHelper.updateResidence(residence);
    await getResidences();
  }

  // Deletar residência e atualizar a lista
  Future<void> deleteResidence(String id) async {
    await _dbHelper.deleteResidence(id);
    await getResidences();
  }

  // Obter residência por ID
  Future<ResidenceModel?> getResidenceId(String id) async {
    return await _dbHelper.getResidenceById(id);
  }

}
