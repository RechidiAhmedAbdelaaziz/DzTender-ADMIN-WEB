import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tender/core/extensions/xfile.extension.dart';

abstract class ImageDTO extends Equatable {
  Future<MultipartFile> toMultipartFile();

  ImageProvider get imageProvider;

  bool isModified(String other);

  @override
  List<Object?> get props;
}

class LocalImageDTO extends ImageDTO {
  final XFile image;

  LocalImageDTO({
    required this.image,
  });

  @override
  Future<MultipartFile> toMultipartFile() async =>
      image.toMultipartFile();

  @override
  ImageProvider get imageProvider => Image.network(image.path).image;

  @override
  bool isModified(String other) => other != image.path;

  @override
  List<Object?> get props => [image];
}

class NetworkImageDTO extends ImageDTO {
  final String url;

  NetworkImageDTO({
    required this.url,
  });

  @override
  Future<MultipartFile> toMultipartFile() async =>
      (await toXFile()).toMultipartFile();

  @override
  ImageProvider get imageProvider => NetworkImage(url);

  Future<XFile> toXFile() async {
    final response = await Dio().get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );

    return response.data!.toXFile();
  }

  @override
  bool isModified(String other) => other != url;

  @override 
  List<Object?> get props => [url];
}
