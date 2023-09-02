import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<String> sendImage(File file) async {

  final request = http.MultipartRequest(
    'POST',
    Uri.parse('http://localhost:8000/predict'),
  );

  
  final fileStream = http.ByteStream(file.openRead());
  final length = await file.length();
  final multipartFile = http.MultipartFile(
    'file',
    fileStream,
    length,
    filename: 'image.jpg', 
  );

  request.files.add(multipartFile);

  
  final response = await request.send();

  if (response.statusCode == 200) {
    final responseBody = await response.stream.bytesToString();
    final parsedData = json.decode(responseBody);
    final predictedClass = parsedData['predicted_class'];
    return predictedClass;
  } else {
    throw Exception('Failed to send data. Status code: ${response.statusCode}');
  }
}