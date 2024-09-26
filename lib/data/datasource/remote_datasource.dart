import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:project2/core/my_error/exceptions.dart';
import 'package:project2/core/services/local_storage.dart';
import 'package:project2/core/success_message/message.dart';
import 'package:project2/core/utiles/apiconstant.dart';
import 'package:project2/data/models/file_model.dart';
import 'package:project2/data/models/note_model.dart';
import 'package:project2/domain/usecase/delete_document.dart';
import 'package:project2/domain/usecase/login_usecase.dart';
import 'package:project2/domain/usecase/save_edited_document.dart';
import 'package:project2/domain/usecase/signup_uscase.dart';
import 'package:project2/domain/usecase/store_note.dart';
import 'package:project2/domain/usecase/upload_video_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseRemotDataSource {
  Future<Message> signUp(SignUpParameters parameters);
  Future<Message> login(LoginParameters parameters);
  Future<Message> uploadVideo(VideoParameters parameters);
  Future<List<FileModel>> getMyDrive();
  Future<Message> deleteDoc(IdParameters parameters);
  Future<Message> addNote(NoteParameters parameters);
  Future<Message> saveDoc(NewFileParameters parameters);
  Future<Message> deleteNote(IdParameters parameters);
  Future<List<NoteModel>> getMyNote();
}

class RemotDataSource extends BaseRemotDataSource {
  late Dio dio;

  RemotDataSource() {
    dio = Dio(
      BaseOptions(
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 3),
          contentType: 'application/json',
          headers: {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods":
                "POST, GET, OPTIONS, PUT, DELETE, HEAD",
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhbmEiLCJleHAiOjE3MjU4MzM0MjR9.Kr_r1HJIDQNAmRelZdfKkpL_mZkOtoiQTlTLg6MGOy0',
          }),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Log or modify the request before it is sent
        print('REQUEST[${options.method}] => PATH: ${options.path}');
        return handler.next(options); // Continue with the request
      },
      onResponse: (response, handler) {
        // Log the response
        print('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
        return handler.next(response); // Continue with the response
      },
      onError: (DioError e, handler) {
        // Log the error
        print('ERROR[${e.response?.statusCode}] => MESSAGE: ${e.message}');
        if (e.response != null) {
          print('RESPONSE DATA: ${e.response?.data}');
        }
        return handler.next(e); // Continue with the error handling
      },
    ));
  }

  @override
  Future<Message> signUp(SignUpParameters parameters) async {
    print("name -> ${parameters.name}");
    print("email -> ${parameters.email}");
    print("password -> ${parameters.password}");

    FormData formData = FormData.fromMap({
      'username': parameters.name,
      'email': parameters.email,
      'password': parameters.password
    });
    var response = await dio.request(ApiConstant.signUp,
        options: Options(
          method: 'POST',
          //headers: {'Authorization': 'Bearer $token'}
        ),
        data: formData);
    print(response.data);
    if (response.statusCode == 201) {
      var responseJson = response.data;
      if (responseJson['data'] == null) {
        throw Exception('Error: username is null');
      } else {
        var username = responseJson['data']['username'];
        print('Username: $username');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('token', responseJson['token']['access_token']);
        preferences.setString('username', responseJson['data']['username']);
        preferences.setString('email', responseJson['data']['email']);
      }
      print(json.encode(response.data));
      return MessageModel.fromJson(response.data);
    }
    throw ServerException();
    // throw UnimplementedError();
  }

  @override
  Future<Message> login(LoginParameters parameters) async {
    print("name -> ${parameters.name}");
    print("password -> ${parameters.password}");

    FormData formData = FormData.fromMap(
        {'username': parameters.name, 'password': parameters.password});
    var response = await dio.request(ApiConstant.logIn,
        options: Options(
          method: 'POST',
          //headers: {'Authorization': 'Bearer $token'}
        ),
        data: formData);
    print(response.data);
    if (response.statusCode == 201 || response.statusCode == 200) {
      var responseJson = response.data;
      if (responseJson['data'] == null) {
        throw Exception('Error: username is null');
      } else {
        var username = responseJson['data']['username'];
        print('Username: $username');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('token', responseJson['token']['access_token']);
      }
      print(json.encode(response.data));
      return MessageModel.fromJson(response.data);
    }
    if (response.statusCode == 401) {
      ScaffoldMessenger.of(parameters.context).showSnackBar(
        SnackBar(
          content: Text('Incorrect username or password'),
          backgroundColor: Colors.red,
        ),
      );
      return Future.error('Unauthorized');
    }
    throw ServerException();
    //
  }

  @override
  Future<List<FileModel>> getMyDrive() async {
    // String? token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhbmEiLCJleHAiOjE3MjU4MzM0MjR9.Kr_r1HJIDQNAmRelZdfKkpL_mZkOtoiQTlTLg6MGOy0";
    //String? token = await getToken();

    // if (token != null) {
    var response = await dio.request(
      ApiConstant.getMyDrive,
      options: Options(
          method: 'GET',
          headers: {'Authorization': 'Bearer ${ApiConstant.token}'}),
    );
    print(response.data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(json.encode(response.data));
      return List<FileModel>.from(
              (response.data["data"] as List).map((e) => FileModel.fromJson(e)))
          .toList();
    } else if (response.statusCode == 500 || response.statusCode == 422) {
      print(response.statusCode);
      // Process the response here
    } else {
      print(response.statusMessage);
    }

    throw ServerException();
  }

  @override
  Future<List<NoteModel>> getMyNote() async {
    String? token = await getToken();
    if (token != null) {
      var response = await dio.request(
        ApiConstant.getMyNote,
        options: Options(
            method: 'GET',
            headers: {'Authorization': 'Bearer ${ApiConstant.token}'}),
      );
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(json.encode(response.data));
        return List<NoteModel>.from((response.data["data"] as List)
            .map((e) => NoteModel.fromJson(e))).toList();
      } else if (response.statusCode == 500 || response.statusCode == 422) {
        print(response.statusCode);
        // Process the response here
      } else {
        print(response.statusMessage);
      }
    }
    throw ServerException();
  }

  @override
  Future<Message> addNote(NoteParameters parameters) async {
    print("note is --> ${parameters.note}");
    print("name is --> ${parameters.noteName}");
    print("id is --> ${parameters.documentId}");
    String? token = await getToken();
    if (token != null) {
      FormData formData = FormData.fromMap(
          {'name': parameters.noteName, 'content': parameters.note});
      var response = await dio.request(
          ApiConstant.addNote1 +
              "${parameters.documentId}" +
              ApiConstant.addNote2,
          options: Options(
              method: 'POST',
              headers: {'Authorization': 'Bearer ${ApiConstant.token}'}),
          data: formData);
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(json.encode(response.data));
        return MessageModel.fromJson(response.data['Message']);
      } else if (response.statusCode == 500) {
        print(response.statusCode);
        // Process the response here
      } else {
        print(response.statusMessage);
      }
      throw ServerException();
    }

    return await Message(message: "addddddddddddd");
  }

  @override
  Future<Message> deleteNote(IdParameters parameters) async {
    String? token = await getToken();
    if (token != null) {
      var response = await dio.request(
        ApiConstant.getMyNote + "/${parameters.id}" + ApiConstant.delete,
        options: Options(
            method: 'DELETE',
            headers: {'Authorization': 'Bearer ${ApiConstant.token}'}),
      );
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(json.encode(response.data));
        // Check if the response data contains 'Message'
        if (response.data is Map<String, dynamic> &&
            response.data.containsKey('Message')) {
          print(json.encode(response.data));
          return MessageModel.fromJson(response.data['Message']);
        } else {
          print('Response data does not contain "Message" key');
          throw ServerException();
        }
      } else if (response.statusCode == 500) {
        print(response.statusCode);
      } else {
        print(response.statusMessage);
      }
    }

    return await Message(message: "deleted note");
  }

  @override
  Future<Message> deleteDoc(IdParameters parameters) async {
    var response = await dio.request(
      ApiConstant.deleteDoc + "${parameters.id}",
      options: Options(
          method: 'DELETE',
          headers: {'Authorization': 'Bearer ${ApiConstant.token}'}),
    );
    print(response.data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(json.encode(response.data));
      // Check if the response data contains 'Message'
      if (response.data is Map<String, dynamic> &&
          response.data.containsKey('Message')) {
        print(json.encode(response.data));
        return MessageModel.fromJson(response.data['Message']);
      } else {
        print('Response data does not contain "Message" key');
        throw ServerException();
      }
    } else if (response.statusCode == 500) {
      print(response.statusCode);
    } else {
      print(response.statusMessage);
    }

    return await Message(message: "deleeeeeeeeeeeeeeeeeet");
  }

  @override
  Future<Message> uploadVideo(VideoParameters parameters) async {
    dio.options.connectTimeout = const Duration(seconds: 1000);
    try {
      // Convert the file to bytes since path is not available on the web
      Uint8List fileBytes = parameters.file.bytes!;
      String fileName = parameters.file.name;

      // Create a MultipartFile from the file bytes
      MultipartFile videoFile = MultipartFile.fromBytes(
        fileBytes,
        filename: fileName,
        contentType: MediaType('video', 'mp4'), // Adjust content type as needed
      );

      // Prepare FormData for the request
      FormData formData = FormData.fromMap({
        "video": videoFile,
        "param1": parameters.numberOfTopic,
      });

      // Make the request
      var response = await dio.request(
        upload(parameters.algorithm, parameters.docName, parameters.docType)!,
        data: formData,
        options: Options(
          method: 'POST',
          headers: {
            'Authorization': 'Bearer ${ApiConstant.token}',
          },
          contentType: 'multipart/form-data',
        ),
      );

      // Handle the response
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Upload successful: ${response.data}');
      } else {
        print('Failed to upload files. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred during file upload: $e');
    }

    return Message(message: "Uploaded");
  }

  @override
  Future<Message> saveDoc(NewFileParameters parameters) async {
    print("note is --> ${parameters.fileName}.txt");

    try {
      MultipartFile file = MultipartFile.fromBytes(
        parameters.pdfBytes,
        filename: "${parameters.fileName}.txt",
        contentType: MediaType('text', 'plain'),
      );

      FormData formData = FormData.fromMap({
        "video": file,
      });

      var response = await dio.request(ApiConstant.saveDoc,
          data: formData,
          options: Options(
            method: 'PUT',
            headers: {
              'Authorization': 'Bearer ${ApiConstant.token}',
            },
            contentType: 'multipart/form-data',
          ));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Upload successful: ${response.data}');
      } else {
        print('Failed to upload files. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred during file upload: $e');
    }

    return await Message(message: "saveeeeee");
  }
}
