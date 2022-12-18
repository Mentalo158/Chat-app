import 'package:firebase_storage/firebase_storage.dart';

// ImageLoader fetches the file Url or multiple Url`s from Firestorage
class ImageLoader {
  static Future getImage(String path) async {
    final ref = FirebaseStorage.instance.ref(path);

    return await ref.getDownloadURL();
  }

  static Future<List<String>> getImages(String paths) async {
    final ref = await FirebaseStorage.instance.ref(paths).listAll();
    List<String> urls = await Future.wait(ref.items.map((ref) async {
      return await ref.getDownloadURL();
    }));
    return urls;
  }
}
