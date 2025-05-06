
import 'package:image_picker/image_picker.dart';

abstract class NetworkCallMethod{
  Future<dynamic> apiTypeGet({required String url,String? token});

  Future<dynamic> apiTypePost({required String url,required String? token ,required String body});

  Future<dynamic> apiTypePut({required String url,required String? token ,required String body});

  Future<dynamic> apiTypeDelete({required String url,required String? token ,required String body});

  Future<dynamic> apiTypeMultiPart(
      {required String url, required String token, required XFile file});


}