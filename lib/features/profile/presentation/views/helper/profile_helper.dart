import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
final ImagePicker picker = ImagePicker();

// 1- method to fetch image from camera

Future<File?> pickCameraPhoto() async{
  final XFile? imageFile = await picker.pickImage(source: ImageSource.camera);
  if(imageFile == null) return null;
  return File(imageFile.path);
}

// 2- mehtod to upload image to supabase
Future<String> uploadImageToSupabase({
  required File imageFile,
  required String uid,
}) async {
  final supabase = Supabase.instance.client;

  final filePath = '$uid.jpg';

  await supabase.storage
      .from('avatars')
      .upload(
        filePath,
        imageFile,
        fileOptions: const FileOptions(upsert: true),
      );

  final imageUrl = supabase.storage
      .from('avatars')
      .getPublicUrl(filePath);

  return imageUrl;
}
