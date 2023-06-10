// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geolocator/geolocator.dart';

// class LocationCubit extends Cubit<String> {
//   LocationCubit() : super('Loading...') {
//     getLocation();
//   }

//   Future<void> getLocation() async {
//     try {
//       final Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);

//       final location = 'Lat: ${position.latitude}, Lon: ${position.longitude}';
//       emit(location);
//     } catch (e) {
//       emit('Location Unavailable');
//     }
//   }
// }
