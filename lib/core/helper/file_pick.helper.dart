import 'package:image_picker/image_picker.dart';

class FilePickHelper {
  static ImagePicker? _imagePicker;

  static ImagePicker _init() {
    if (_imagePicker == null) {
      _imagePicker = ImagePicker();
      return _imagePicker!;
    } else {
      return _imagePicker!;
    }
  }

  static Future<XFile?> pickImage() async {
    final imagePicker = _init();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    return image;
  }
}
