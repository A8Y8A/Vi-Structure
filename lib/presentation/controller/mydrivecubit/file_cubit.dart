import 'dart:convert';
import 'dart:html' as html if (dart.library.io) 'dart:io';
import 'dart:io';
import 'dart:typed_data';

import 'package:docx_template/docx_template.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path/path.dart' as path;
import 'package:project2/core/usecase/base_usecase.dart';
import 'package:project2/domain/entitieas/file.dart';
import 'package:project2/domain/usecase/delete_document.dart';
import 'package:project2/domain/usecase/get_my_drive_usecase.dart';
import 'package:project2/domain/usecase/save_edited_document.dart';
import 'package:project2/presentation/controller/mydrivecubit/file_state.dart';

class FileCubit extends Cubit<FileState> {
  final GetMyDriveUseCase _getMyDriveUseCase;
  final DeleteDocumentUseCase _deleteDocumentUseCase;
  final SaveDocumentUseCase _saveDocumentUseCase;

  FileCubit(this._getMyDriveUseCase,this._deleteDocumentUseCase,this._saveDocumentUseCase) : super(FileInitial());

  // Future<void> saveFileAsPdf(String fileName, String content) async {
  //   emit(FileLoading());
  //   try {
      

  //     final pdfBytes =_createPdf(fileName,content);
  //     final result=
  //     await _saveDocumentUseCase(NewFileParameters(fileName, pdfBytes));

  //     // Send the PDF to the server using the repository
  //    // await repository.uploadFile(fileName: fileName, fileBytes: pdfBytes);

  //     emit(FileSaved());
  //   } catch (e) {
  //     emit(FileError(e.toString()));
  //   }
  // }
  
  Future<void> saveFileAsTxt(String fileName, String content) async {
    emit(FileLoading());
    try {
      

      final pdfBytes =_createTxt(fileName,content);
      print('ffffffffffff$fileName.txt');
      final result=
      await _saveDocumentUseCase(NewFileParameters(fileName, pdfBytes));

      emit(FileSaved());
    } catch (e) {
      emit(FileError(e.toString()));
    }
  }
  void fetchFiles() async {
    emit(FileLoading());
    try {
      print("ttttttttttttt");
      final result=await _getMyDriveUseCase(NoParameters());
      print("resultis $result");
      // final files = List.generate(
      //     5,
      //     (index) => Filee(
      //         id: 1,
      //         name: "namettt",
      //         createdAt: "createdAt",
      //         updatedAt: "updatedAt",
      //         content: "content"));
      
      emit(FileLoaded(result));
    } catch (e) {
      emit(FileError("Failed to fetch files"));
    }
  }

  void deleteFile(Filee file,int id) async{
    final result = await _deleteDocumentUseCase(IdParameters(id));
    if (state is FileLoaded) {
      final updatedFiles = (state as FileLoaded)
          .files
          .where((f) => f.name != file.name)
          .toList();
      emit(FileLoaded(updatedFiles));
    }
  }

  Future<void> downloadFile(Filee file, String format) async {
    try {
      String fileName = '${file.name}.$format';
      String filePath;
      List<int> fileBytes;

      switch (format) {
        case 'pdf':
          fileBytes = await _createPdf(fileName, file.content);
          break;
        case 'txt':
          fileBytes = _createTxt(fileName, file.content);
          break;
        case 'docx':
          fileBytes =await _createDocx(fileName, file.content);
          break;
        default:
          throw Exception("Unsupported format");
      }

      if (kIsWeb) {
        _downloadFileWeb(fileBytes, fileName);
      } else {
        //filePath = await _saveFileLocally(fileBytes, fileName);
        // Optionally open the file or notify the user that the download is complete.
      }

      emit(FileDownloadSuccess(fileName));
    } catch (e) {
      emit(FileError("Failed to download file"));
    }
  }

  Future<List<int>> _createPdf(String fileName, String content) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text(content),
        ),
      ),
    );
    return pdf.save();
  }

  List<int> _createTxt(String fileName, String content) {
    return utf8.encode(content);
  }
  Future<List<int>> _createtxt(String fileName, String content)async {
    return await utf8.encode(content);
  }
Future<List<int>> _createDocx(String fileName, String content) async {
//   final docx = await DocxTemplate.fromBytes(Uint8List.fromList([]));

//   Content c = Content();
//   c.add(TextContent("", content));

//   final docxBytes = await docx.generate(c);

//  return docxBytes!;
  ByteData data = await rootBundle.load('assets/files/Doc1.docx');
  Uint8List bytes = data.buffer.asUint8List();

  // Initialize the DOCX template with the loaded bytes
  final docx = await DocxTemplate.fromBytes(bytes);

  // Prepare the content to be inserted into the DOCX file
  Content c = Content();
  c.add(TextContent("placeholder_key", content)); // Use a key matching the placeholder in your template

  // Generate the DOCX file
  final docxBytes = await docx.generate(c);

  return docxBytes!;

  }
}
  void _downloadFileWeb(List<int> fileBytes, String fileName) {
    final blob = html.Blob([fileBytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }



