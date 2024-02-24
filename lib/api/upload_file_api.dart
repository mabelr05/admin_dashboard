import 'dart:convert';
import 'dart:typed_data';
import 'package:admin_dashboard/api/config.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // Import the http_parser package

Future<String> uploadFile(Uint8List fileBytes) async {
  // URL of the API

  var apiUrl = Uri.parse('${AppConfig.urlServer}/api/uploads');

  // Create an HTTP request
  var request = http.MultipartRequest('POST', apiUrl);

  // Add the file to the form
  request.files.add(
    http.MultipartFile.fromBytes(
      'archivo', // Field name in the form
      fileBytes,
      filename: 'filename.jpg', // Name of the file to be sent
      contentType: MediaType('image', 'jpeg'), // Content type of the file
    ),
  );

  // Send the request
  var response = await request.send();

  // Read the response as a string
  String responseString = await response.stream.bytesToString();

  // Parse the JSON response
  var jsonResponse = jsonDecode(responseString);

  // Print the received file name from the response
  print('Uploaded file name: ${jsonResponse['nombre']}');
  return jsonResponse['nombre'];
}
