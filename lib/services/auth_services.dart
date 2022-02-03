import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

//adicionado firebase e tela de login / botão de logout

class AuthException implements Exception {
  String message;

  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() { //pegar o usuario atual
    usuario = _auth.currentUser;
    notifyListeners();
  }

  registrar(String email, String senha) async {
    try {
      //captura de excessões e erros
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser(); //recupera os dados do usuário atual
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já esta em uso');
      }
    }
  }

  login(String email, String senha) async {
    try {
      //captura de excessões e erros
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser(); //executa o login
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      }
    }
  }
  logout() async{ //deslogando
    await _auth.signOut();
    -_getUser();
  }
}

