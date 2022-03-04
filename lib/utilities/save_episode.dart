import 'dart:io';
import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

//TODO: Configure for iOS

class MyPathProvider {
// Create and return the Cop Belgium Path.
  Future<String> _getCopPath() async {
    try {
      // Get the storage directory
      Directory? directory = await path_provider.getExternalStorageDirectory();

      List<String> foldersNames = directory!.path.split('/');
      // ' /storage/emulated/0/Android/data/com.apkeroo.copBelgium/files'

      String path = '';
      // loop starts at one because the the first index is empty
      for (var i = 1; i < foldersNames.length; i++) {
        // loop throught the foldersNames until the Android folder name.
        if (foldersNames[i] != 'Android') {
          path += '${foldersNames[i]}/';
        } else {
          break;
        }
      }

      // path: storage/emulated/0/
      // newPath: storage/emulated/0/CopBelgium/

      String newPath = path + 'Cop Belgium/';

      return newPath;
    } catch (e) {
      rethrow;
    }
  }

// Save the podcast on the Device.
  Future<bool> savePodcastEpisode({
    required String fileName,
    required String direcotryFolder,
    required String url,
    required String fileExtension,
  }) async {
    try {
      bool hasConnection = await ConnectionChecker().checkConnection();

      if (hasConnection) {
        // Check the storage perimission first.
        final status = await Permission.storage.request();

        // Storage permission is granted.
        if (status == PermissionStatus.granted) {
          // Get the audio from internet.
          final response = await http.get(Uri.parse(url));

          //Create Folder after Cop Belgium.
          Directory? directory =
              await _createDirectory(folder: direcotryFolder);

          // Write to the file if the folder exists.
          if (directory != null && await directory.exists()) {
            File file = File('${directory.path}/$fileName$fileExtension');
            final randFile = file.openSync(mode: FileMode.write);
            randFile.writeFromSync(response.bodyBytes);
            randFile.close();

            return true;
          }
        }
      } else {
        throw ConnectionChecker.connectionException;
      }

      // return null if the permission is not granted.
      return false;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  // Create a folder after 'Cep Belgium' path.
  Future<Directory?> _createDirectory({required String folder}) async {
    // Create a direcotry (Folder) in th Cop Belgium Folder.
    Directory? directory;

    // Get the cop path.
    String copPath = await _getCopPath();

    // Add the folder after the 'Cop Belgium/' path
    final newPath = copPath + folder;
    // newPath: storage/emulated/0/Cop Belgium/folder

    directory = Directory(newPath);

    // Create the folder if it does not exists.
    if (!await directory.exists()) {
      await directory.create(recursive: true);
      return directory;
    }

    return null;
  }

  Future<File?> getFile({
    required String path,
  }) async {
    // Get the Cop Belgium Path
    final copPath = await _getCopPath();

    final newPath = copPath + path;
    // e.g.: storage/emulated/0/Cop Belgium/ + Podcasts/Deep Thruths/Deception.mp3

    File file = File(newPath);

    // Return the file if the file exists.
    final exists = await file.exists();
    if (exists) {
      return file;
    }

    return null;
  }
}
