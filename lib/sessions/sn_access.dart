import 'dart:developer';

import 'package:admin/api/auth/api_session.dart';
import 'package:admin/models/user/md_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionAccess {
  static SessionAccess instance = SessionAccess();

  Future<void> createSession(UserModel admin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', admin.id!);
    prefs.setString('name', '${admin.name}');
    prefs.setString('email', '${admin.email}');
    prefs.setString('access_token', admin.access_token!);
    prefs.setString('status', admin.status!);
    prefs.setString('phone', admin.phone!);
    prefs.setString('address', admin.address!);
    prefs.setString('created_at', admin.created_at!);
    prefs.setString('updated_at', admin.updated_at!);
    log('Session created Successfully', name: 'SESSION CREATED');
  }

  Future<UserModel> getSessionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');
    String? status = prefs.getString('status');
    String? phone = prefs.getString('phone');
    String? address = prefs.getString('address');
    String? createdAt = prefs.getString('created_at');
    String? updatedAt = prefs.getString('updated_at');

    UserModel admin = UserModel(
      id: id,
      name: name,
      email: email,
      status: status,
      phone: phone,
      address: address,
      created_at: createdAt,
      updated_at: updatedAt,
    );
    return admin;
  }

  Future<String?> getSessionToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    return token;
  }

  Future<bool> isActiveSession() async {
    var storedToken = await getSessionToken();

    if (storedToken == null) {
      return false;
    }

    var session = await SessionApi.auth.session(storedToken);

    if (session == 'Cannot connect to server') {
      return false;
    }

    if (session == 'Unauthenticated') {
      return false;
    }

    if (session == 'Session accepted') {
      return true;
    }

    return false;
  }

  void destroySession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('role');
    prefs.remove('email_verified_at');
    prefs.remove('created_at');
    prefs.remove('updated_at');
    prefs.remove('token');
  }

  Future<void> savedEmail(UserModel admin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setInt('id', admin.id!);
    // prefs.setString('name', '${admin.name}');
    // prefs.setString('email', '${admin.email}');
    // prefs.setString('role', '${admin.role}');
    // prefs.setString('status', admin.status ?? 'In Active');
    // prefs.setString('avatar', '${admin.avatar}');
    // prefs.setString('email_verified_at', '${admin.email_verified_at}');
    // prefs.setString('created_at', '${admin.created_at}');
    // prefs.setString('updated_at', '${admin.updated_at}');
    // log('Email saved Successfully', name: 'SESSION');
  }
}
