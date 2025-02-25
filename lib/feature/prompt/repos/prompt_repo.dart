import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:dio/dio.dart';

class PromptRepo {
  static Future<Uint8List?> generateImage(String prompt) async {
    try {
      const String url = 'https://api.vyro.ai/v1/imagine/api/generations';
      const Map<String, dynamic> headers = {
        'Authorization': 'Bearer vk-oe0eezFVHhnbP7i3lxTTB26jvWKz4D5zUx5Ho33RkvKPd7',
      };

      final Map<String, dynamic> payload = {
        'prompt': prompt,
        'style_id': '122',
        'aspect_ratio': '1:1',
        'cfg': '5',
        'seed': '2',
        'high_res_results': '1'
      };

      final FormData formData = FormData.fromMap(payload);
      final Dio dio = Dio();
      dio.options = BaseOptions(
        headers: headers,
        responseType: ResponseType.bytes, // Expect binary data by default
      );

      final response = await dio.post(url, data: formData);

      if (response.statusCode == 200) {
        // Check if response data is binary or Base64 encoded
        if (response.headers.value('content-type')?.contains('application/json') ?? false) {
          // If the response is JSON, it might contain an error message
          final jsonResponse = jsonDecode(utf8.decode(response.data));
          log('Error in response: ${jsonResponse.toString()}');
          return null;
        } else if (response.headers.value('content-type')?.contains('text/plain') ?? false) {
          // If the response is Base64 encoded, decode it
          String base64String = utf8.decode(response.data);
          Uint8List uint8list = base64Decode(base64String);
          return uint8list;
        } else {
          // If the response is raw binary image data
          Uint8List uint8list = Uint8List.fromList(response.data);
          return uint8list;
        }
      } else {
        log('Failed to generate image. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error generating image: $e');
      return null;
    }
  }
}
