// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:admin_dashboard/api/CafeApi.dart';
import 'package:admin_dashboard/models/file.dart';
import 'package:admin_dashboard/models/usuario.dart';
import 'package:flutter/material.dart';

class FileUploadProvider extends ChangeNotifier{

  

    Future<File> uploadImage(String path, Uint8List bytes) async {

      try{

        final resp = await CafeApi.uploadFile(path, bytes);
        print(resp);
        
        notifyListeners();

        return resp;

      }catch (e){
        print(e);
        throw 'Error en user from provider';

      }
    }
}