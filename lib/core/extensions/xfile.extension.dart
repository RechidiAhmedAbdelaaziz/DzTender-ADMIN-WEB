import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

extension XFileExtension on XFile {
  Future<MultipartFile> toMultipartFile() async =>
      MultipartFile.fromBytes(
        await readAsBytes(),
        filename: name,
        contentType: MediaType('image', 'jpeg'),
      );
}

extension XFileListExtension on List<XFile> {
  List<Future<MultipartFile>> toMultipartFileList() =>
      map((image) => image.toMultipartFile()).toList();
}
