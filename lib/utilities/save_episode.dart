import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

String podcastPath = 'storage/emulated/0/Cop Belgium/Podcasts';
Future<String?> savePodcastEpisode({
  required String fileName,
  required String direcotryFolder,
  required String url,
  required String fileExtension,
}) async {
  final response = await http.get(Uri.parse(url));
  final status = await Permission.storage.request();

  if (status == PermissionStatus.granted) {
    Directory? directory = await _createDirectory(folder: direcotryFolder);

    if (directory != null) {
      if (await directory.exists()) {
        File podcastEpisode = File('${directory.path}/$fileName$fileExtension');
        final file = podcastEpisode.openSync(mode: FileMode.write);
        file.writeFromSync(response.bodyBytes);
        file.close();

        return file.path;
      }
    }
  }
  return null;
}

// Directory getEpisodePath({required String path}) async {
//   final x = await path_provider.getExternalStorageDirectory();
// }

Future<Directory?> _createDirectory({required String folder}) async {
  Directory? directory = await path_provider.getExternalStorageDirectory();
  String path = directory!.path;

  //Create new Direcotry in android storage
  // E.g. Cop Belgium/Images

  String storagePath = _getAndroidStoragePath(directoryPath: path);
  final newPath = storagePath + 'Cop Belgium/$folder';

  directory = Directory(newPath);

  if (!await directory.exists()) {
    await directory.create(recursive: true);
    return directory;
  }

  return null;
}

String _getAndroidStoragePath({required String directoryPath}) {
  List<String> foldersNames = directoryPath.split('/');
  // ' /storage/emulated/0/Android/data/com.apkeroo.copBelgium/files/audio35.mp3'

  String newPath = '';
  // loop starts at one because the the first index is empty
  for (var i = 1; i < foldersNames.length; i++) {
    // loop throught the foldersNames until the Android folder name.
    if (foldersNames[i] != 'Android') {
      newPath += '${foldersNames[i]}/';
    } else {
      break;
    }
  }

  return newPath;
}

//TODO: Was getting the file back from storage.
Future<Directory?> getDirectory({
  required String folder,
}) async {
  Directory? directory = await path_provider.getExternalStorageDirectory();
  if (directory != null) {
    final path = _getAndroidStoragePath(directoryPath: directory.path);

    final newPath = path + 'Cop Belgium/$folder';
    print(newPath);
  }
}
