// import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;
// import 'package:flutter_quill/flutter_quill.dart';
// import 'package:project2/domain/entitieas/file.dart';

// class FileView extends StatefulWidget {
//   final Filee file;

//   const FileView({Key? key, required this.file}) : super(key: key);

//   @override
//   _FileViewState createState() => _FileViewState();
// }

// class _FileViewState extends State<FileView> {
//   QuillController _controller = QuillController.basic();

//   @override
//   void initState() {
//     super.initState();
//     final doc = quill.Document()
//       ..insert(0,
//           "hhhhhhhhhhnxjcnsaaaaaaaaaaaaacnlknsiclncis\ndkkkkkkkkdkd\ndkkkkkkkkkkkkkkkkkkkkk\ndjjjjjjjjjjjjjjj");

//     // Initialize the controller with the document
//     _controller = quill.QuillController(
//       document: doc,
//       selection: const TextSelection.collapsed(offset: 0),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.file.name),
//         backgroundColor: Colors.deepPurple,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.save),
//             onPressed: () {
//               // Save logic here
//               final content = _controller.document.toPlainText();
//               print('Saved content: $content');
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//                 // color: Colors.white,
//                 // padding: const EdgeInsets.all(8.0),
//                 child: QuillProvider(
//               configurations: QuillConfigurations(
//                 controller: _controller,
//                 sharedConfigurations: const QuillSharedConfigurations(
//                   locale: Locale('de'),
//                 ),
//               ),
//               child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Wrap(
//                     children: [
//                       const QuillToolbar(),
//                       SizedBox(
//                         width: 30,
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Logic to save selected text as a note
//                           final selectedText = _controller.getPlainText();
//                           print('Add note: $selectedText');
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.deepPurple,
//                         ),
//                         child: const Text('Add Note'),
//                       ),
//                       Expanded(
//                         child: SizedBox(
//                           width: 20,
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Logic to save selected text as a note
//                           final selectedText = _controller.getPlainText();
//                           print('Selected text saved as note: $selectedText');
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.deepPurple,
//                         ),
//                         child: const Text('Save'),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 24,
//                   ),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: Center(
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.7,
//                         height: MediaQuery.of(context).size.height * 0.76,
//                         padding: EdgeInsets.all(40),
//                         decoration: BoxDecoration(
//                             color: Color.fromARGB(255, 223, 222, 222),
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(30),
//                                 topRight: Radius.circular(30))),
//                         child: QuillEditor.basic(
//                           configurations: const QuillEditorConfigurations(
//                             readOnly: false,
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:project2/domain/entitieas/file.dart';
import 'package:project2/presentation/controller/mydrivecubit/file_cubit.dart';
import 'package:project2/presentation/controller/notecubit/note_cubit.dart';

class FileView extends StatefulWidget {
  final Filee file;

  const FileView({Key? key, required this.file}) : super(key: key);

  @override
  _FileViewState createState() => _FileViewState();
}

class _FileViewState extends State<FileView> {
  QuillController _controller = QuillController.basic();
  late String formatted_string;

  @override
  void initState() {
    super.initState();
    // formatted_string =
    //     {widget.file.content}.replaceAll("{'generated_text': '", "").rstrip("'}");
    // formatted_string = "\n" + formatted_string;
    // print(formatted_string);

    // String streetName = widget.file.content.replaceAll(houseNumber, '').trim();
    // streetName = widget.file.content.replaceAll(m, '').trim();
    // print('Street name: $formatted_string');
    // Load the content from the document
    final doc = quill.Document()..insert(0, widget.file.content);

    // Initialize the controller with the document
    _controller = quill.QuillController(
      document: doc,
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _showDownloadOptions(BuildContext context, Filee file) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Download Format'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('PDF'),
                onTap: () {
                  context.read<FileCubit>().downloadFile(file, 'pdf');
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('TXT'),
                onTap: () {
                  context.read<FileCubit>().downloadFile(file, 'txt');
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _saveDocument() async {
    final content = _controller.document.toPlainText();

    // Call the Cubit method to save the document as PDF and upload it
    context.read<FileCubit>().saveFileAsTxt(widget.file.name, content);
  }

  Future<void> _addNote() async {
    final selectedText = _controller.document
        .getPlainText(_controller.selection.start, _controller.selection.end);

    if (selectedText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select some text to add as a note.')),
      );
      return;
    }

    final TextEditingController noteNameController = TextEditingController();

    // Show dialog to enter note name
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: noteNameController,
                decoration: const InputDecoration(labelText: 'Note Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final noteName = noteNameController.text;
                if (noteName.isNotEmpty) {
                  // Send the note to the server via NoteCubit
                  context.read<NoteCubit>().addNote(
                        noteName: noteName,
                        noteContent: selectedText,
                        documentId: widget.file.id,
                      );
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Note name cannot be empty.')),
                  );
                }
              },
              child: const Text('Save Note'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.file.name),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveDocument,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              // color: Colors.white,
              // padding: const EdgeInsets.all(8.0),
              child: QuillProvider(
                configurations: QuillConfigurations(
                  controller: _controller,
                  sharedConfigurations: const QuillSharedConfigurations(
                      locale: Locale('de'),
                      dialogBarrierColor: Colors.transparent,
                      dialogTheme: QuillDialogTheme()),
                ),
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        child: QuillToolbar(),
                      ),
                      ElevatedButton(
                        onPressed: _addNote,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        child: const Text('Add Note'),
                      ),
                      IconButton(
                        icon: Icon(Icons.download, color: Colors.grey),
                        onPressed: () =>
                            _showDownloadOptions(context, widget.file),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 223, 222, 222),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: QuillEditor.basic(
                          configurations: const QuillEditorConfigurations(
                        readOnly: false,
                      )),
                    ),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
