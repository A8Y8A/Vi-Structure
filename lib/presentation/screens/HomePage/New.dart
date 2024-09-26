// import 'package:flutter/material.dart';

// class New extends StatefulWidget {
//   @override
//   _NewState createState() => _NewState();
// }

// class _NewState extends State<New> {
//   final _documentNameController = TextEditingController();
//   String _selectedOption = 'Transcription';
//   final List<String> _options = ['Transcription', 'Structuring'];

//   @override
//   Widget build(BuildContext context) {
//     final isSmallScreen = MediaQuery.of(context).size.width < 600;

//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Container(
//             width: isSmallScreen
//                 ? MediaQuery.of(context).size.width * 0.9
//                 : 500, // Adjust width based on screen size
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Document Name Field
//                 Text(
//                   'Document Name',
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.deepPurple,
//                       fontFamily: "Montserrat"),
//                 ),
//                 SizedBox(height: 8),
//                 TextField(
//                   style: TextStyle(
//                       color: Colors.deepPurple, fontWeight: FontWeight.bold),
//                   cursorColor: Colors.deepPurple,
//                   controller: _documentNameController,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(4)),
//                       borderSide: BorderSide(color: Colors.deepPurple),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(4)),
//                       borderSide:
//                           BorderSide(color: Colors.deepPurple, width: 2.0),
//                     ),
//                     hintText: 'Enter document name...',
//                     hintStyle: TextStyle(
//                       color: Colors.deepPurple.withOpacity(0.7),
//                       fontFamily: "Montserrat",
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 16),

//                 // Dropdown Field
//                 Text('Select an Option',
//                     style: TextStyle(
//                         color: Colors.deepPurple,
//                         fontFamily: "Montserrat",
//                         fontWeight: FontWeight.bold,
//                         fontSize: 17)),
//                 SizedBox(height: 8),
//                 DropdownButtonFormField<String>(
//                   icon: Icon(
//                     Icons.arrow_drop_down,
//                     color: Colors.deepPurple,
//                   ),
//                   value: _selectedOption,
//                   items: _options.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(
//                         value,
//                         style: TextStyle(
//                             color: Colors.deepPurple,
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     );
//                   }).toList(),
//                   onChanged: (newValue) {
//                     setState(() {
//                       _selectedOption = newValue!;
//                     });
//                   },
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.deepPurple),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.deepPurple),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide:
//                           BorderSide(color: Colors.deepPurple, width: 2.0),
//                     ),
//                   ),
//                   dropdownColor: Colors.white,
//                   style: TextStyle(
//                     color: Colors.deepPurple,
//                   ),
//                 ),
//                 SizedBox(height: 32),

//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                         padding: EdgeInsets.symmetric(vertical: 16),
//                         backgroundColor: Colors.deepPurple),
//                     child: Text(
//                       'Upload',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:project2/presentation/controller/uploadvideocubit/upload_video_cubit.dart';
import 'package:project2/presentation/controller/uploadvideocubit/upload_video_state.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _documentNameController = TextEditingController();
  final textcontroller = TextEditingController();
  bool isTextFieldEnabled = false;
  String _selectedOption = 'file';
  String selectedAlgo = 'kmeans';
  PlatformFile? _selectedFile;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width:
                isSmallScreen ? MediaQuery.of(context).size.width * 0.9 : 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Document Name',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontFamily: "Montserrat"),
                ),
                SizedBox(height: 8),
                TextField(
                  style: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold),
                  cursorColor: Colors.deepPurple,
                  controller: _documentNameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2.0),
                    ),
                    hintText: 'Enter document name...',
                    hintStyle: TextStyle(
                      color: Colors.deepPurple.withOpacity(0.7),
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('Select an Option',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.deepPurple,
                  ),
                  value: _selectedOption,
                  items: ['file', 'video'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedOption = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2.0),
                    ),
                  ),
                  dropdownColor: Colors.white,
                  style: TextStyle(
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.deepPurple,
                  ),
                  value: selectedAlgo,
                  items: ['kmeans', 'hdbscan', 'summary'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedAlgo = newValue!;
                      if (selectedAlgo == 'kmeans' ||
                          selectedAlgo == 'summary') {
                        isTextFieldEnabled = true;
                      } else {
                        isTextFieldEnabled = false;
                        textcontroller.clear();
                      }
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2.0),
                    ),
                  ),
                  dropdownColor: Colors.white,
                  style: TextStyle(
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: textcontroller,
                  enabled: isTextFieldEnabled,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter number of topic',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(type: FileType.media);
                    if (result != null) {
                      setState(() {
                        _selectedFile = result.files.first;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.deepPurple),
                  child: Text(
                    _selectedFile != null ? 'Change File' : 'Select File',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<UploadCubit, UploadState>(
                    builder: (context, state) {
                      if (state.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            state.errorMessage!,
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      if (state.isLoading) {
                        return CircularProgressIndicator();
                      }
                      return ElevatedButton(
                        onPressed: _selectedFile == null
                            ? null
                            : () {
                                context.read<UploadCubit>().uploadVideo(
                                      documentName:
                                          _documentNameController.text,
                                      documentType: _selectedOption,
                                      algorithm: selectedAlgo,
                                      numberOfTopic: textcontroller.text,
                                      file: _selectedFile!,
                                    );
                              },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.deepPurple),
                        child: Text(
                          'Upload',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
