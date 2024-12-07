import 'package:flutter/material.dart';

class RegistrationViewModel extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> register(String email, String password, String confirmPassword) async{
    _isLoading = true;
    notifyListeners();


    // simulate a network call
    await Future.delayed(const Duration(seconds: 2));

    // perform validation and business logic
    if(password != confirmPassword){
      _isLoading = false;
      notifyListeners();
      throw Exception('Passwords do no match!');
    }

    // assume registration was successful
    _isLoading = false;
    notifyListeners();
  }

}