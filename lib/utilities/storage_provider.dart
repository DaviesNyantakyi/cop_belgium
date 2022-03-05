import 'dart:io';
import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

//TODO: Configure for iOS

String podcastDir = '/Podcasts';

class StorageProvider {
  // Create a new directory in the appdocdirectory.
  Future<String> _getCopDir() async {
    try {
      // Get the app  directory
      // Print: /data/user/0/com.apkeroo.copBelgium/app_flutter
      Directory? appDocDir =
          await path_provider.getApplicationDocumentsDirectory();

      // Set new directory.
      // Print: /data/user/0/com.apkeroo.copBelgium/app_flutter/Cop Belgium
      Directory copDir = Directory(appDocDir.path + '/Cop Belgium');

      // create the directory if it does not exists.
      if (!await copDir.exists()) {
        await copDir.create();
      }

      // return the Cop Belgium directory.
      return copDir.path;
    } catch (e) {
      rethrow;
    }
  }

// Save the podcast on the Device.
  Future<bool> savePodcastEpisode({
    required String fileName,
    required String newDir,
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

          // Create directory after Cop Belgium.
          // Console:  /data/user/0/com.apkeroo.copBelgium/app_flutter/Cop Belgium/Podcasts
          Directory? directory = await createNewDirectory(dir: newDir);

          // Write file if directory exists.
          if (directory != null && await directory.exists()) {
            File file = File('${directory.path}/$fileName$fileExtension');
            // Console: /data/user/0/com.apkeroo.copBelgium/app_flutter/Cop Belgium/Podcasts/Deep thruths/Davies.davies
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

  Future<Directory?> createNewDirectory({required String dir}) async {
    Directory? directory;

    // Get the Cop Belgium directory.
    // Console: /data/user/0/com.apkeroo.copBelgium/app_flutter/Cop Belgium
    String copPath = await _getCopDir();

    // Set new direcotry path.
    // Console: /data/user/0/com.apkeroo.copBelgium/app_flutter/Cop Belgium/Podcasts
    final newDirPath = copPath + '/$dir';
    directory = Directory(newDirPath);

    // Create and return directory if it does not exists.
    if (!await directory.exists()) {
      await directory.create(recursive: true);
      return directory;
    }

    // return directory
    if (await directory.exists()) {
      return directory;
    }

    return null;
  }

  Future<File?> getFile({required String path}) async {
    // Get the Cop Belgium directory.
    // Console: /data/user/0/com.apkeroo.copBelgium/app_flutter/Cop Belgium
    final copPath = await _getCopDir();

    // Set the file path
    final newPath = copPath + '/$path';
    File file = File(newPath);

    // Return the file if it exists.
    if (await file.exists()) {
      return file;
    }

    // return null if the file does not exists.
    return null;
  }

  Future<Directory?> getDirectory({required String dir}) async {
    // Get the Cop Belgium directory.
    // Console: /data/user/0/com.apkeroo.copBelgium/app_flutter/Cop Belgium
    final copPath = await _getCopDir();
    Directory directory = Directory(copPath + '/$dir');
    if (await directory.exists()) {
      return directory;
    }
    return null;
  }
}
