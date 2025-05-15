import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../models/residence_model.dart';

class LocationButton extends StatefulWidget {
  final TextEditingController addressController;
  final TextEditingController neighborhoodController;
  final ResidenceModel residence;

  const LocationButton({
    super.key,
    required this.addressController,
    required this.neighborhoodController,
    required this.residence,
  });

  @override
  State<LocationButton> createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  Future<Placemark> _getLocation() async {
    bool isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) {
      throw Exception("Serviço de localização desativado.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        throw Exception("Permissão negada.");
      }
    }

    final position = await Geolocator.getCurrentPosition();
    final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemarks.first;
  }

  Future<void> _handleGetLocation() async {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        title: Text('Localização'),
        content: SizedBox(height: 80, child: Center(child: CircularProgressIndicator())),
      ),
    );

    try {
      final placemark = await _getLocation();

      if (!mounted) return;
      Navigator.of(context).pop();

      final confirm = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Localização'),
          content: Text('Endereço: ${placemark.street}, ${placemark.subThoroughfare} - ${placemark.subLocality}'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancelar')),
            TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Confirmar')),
          ],
        ),
      );

      if (confirm == true) {
        widget.addressController.text = '${placemark.street}, ${placemark.subThoroughfare}';
        widget.neighborhoodController.text = placemark.subLocality ?? '';
        widget.residence.address = widget.addressController.text;
        widget.residence.neighborhood = widget.neighborhoodController.text;
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar localização: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleGetLocation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Icon(Icons.location_on, color: Colors.redAccent, size: 18),
          SizedBox(width: 4),
          Text("Minha Localização", style: TextStyle(color: Colors.redAccent)),
        ],
      ),
    );
  }
}
