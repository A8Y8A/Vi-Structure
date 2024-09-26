// import 'package:flutter/material.dart';
// import 'package:project2/presentation/screens/HomePage/Edit_file.dart';

// class Mydrive extends StatefulWidget {
//   @override
//   State<Mydrive> createState() => _MydriveState();
// }

// class _MydriveState extends State<Mydrive> {
//   final List<FileData> files = List.generate(
//     5,
//     (index) => FileData(
//       'File ${index + 1}',
//       '01/${index + 1}/2023',
//       '02/${index + 1}/2023',
//       'Sample content for file ${index + 1}',
//     ),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 20),
//             FileTable(files: files),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FileTable extends StatelessWidget {
//   final List<FileData> files;

//   const FileTable({required this.files});

//   Future<void> _downloadFile(BuildContext context, String content) async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Choose Download Format'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 title: Text('PDF'),
//                 onTap: () {
//                   print('Downloading as PDF');
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: Text('TXT'),
//                 onTap: () {
//                   print('Downloading as TXT');
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: Text('DOCX'),
//                 onTap: () {
//                   print('Downloading as DOCX');
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(8.0),
//             color: Colors.deepPurple,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Expanded(
//                   child: Center(
//                       child: Text('File Name',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold))),
//                 ),
//                 Expanded(
//                     child: Center(
//                         child: Text('Date Created',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold)))),
//                 Expanded(
//                     child: Center(
//                         child: Text('Last Edit Date',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold)))),
//                 Expanded(
//                     child: Center(
//                         child: Text('Actions',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold)))),
//               ],
//             ),
//           ),
//           ...files.map((file) {
//             return Card(
//               margin: EdgeInsets.symmetric(vertical: 8.0),
//               elevation: 4.0,
//               child: ListTile(
//                 leading: Icon(Icons.folder, color: Colors.deepPurple),
//                 title: Row(
//                   children: [
//                     Center(
//                         child: Text(
//                       file.name,
//                       style: TextStyle(
//                           color: Colors.deepPurple,
//                           fontWeight: FontWeight.bold),
//                     )),
//                     Expanded(child: Center(child: Text('${file.dateCreated}'))),
//                     Expanded(
//                         child: Center(child: Text('${file.lastEditDate}'))),
//                   ],
//                 ),
//                 // subtitle: Text(
//                 //     'Created: ${file.dateCreated}\nLast Edited: ${file.lastEditDate}'),
//                 trailing: Expanded(
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.download, color: Colors.grey),
//                         onPressed: () => _downloadFile(context, file.content),
//                       ),
//                       SizedBox(
//                         width: 30,
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.delete, color: Colors.grey),
//                         onPressed: () {
//                           print('Delete ${file.name}');
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => FileView(file: file),
//                     ),
//                   );
//                 },
//               ),
//             );
//           }).toList(),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/domain/entitieas/file.dart';
import 'package:project2/presentation/controller/mydrivecubit/file_cubit.dart';
import 'package:project2/presentation/controller/mydrivecubit/file_state.dart';

import 'package:project2/presentation/screens/HomePage/Edit_file.dart';

class Mydrive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<FileCubit>().fetchFiles();
    return Scaffold(
      body: BlocBuilder<FileCubit, FileState>(
        builder: (context, state) {
          if (state is FileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FileLoaded) {
            return FileTable(files: state.files);
          } else if (state is FileError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No files found.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Fetch the notes when the button is pressed
          context.read<FileCubit>().fetchFiles();
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class FileTable extends StatelessWidget {
  final List<Filee> files;

  const FileTable({required this.files});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return _buildWideLayout(context, files);
        } else {
          return _buildNarrowLayout(context, files);
        }
      },
    );
  }

  // Build layout for wide screens
  Widget _buildWideLayout(BuildContext context, List<Filee> files) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width:
              MediaQuery.of(context).size.width, // Ensure it takes full width
          child: DataTable(
            columnSpacing: 16.0, // Adjust spacing between columns if needed
            columns: const [
              DataColumn(label: Text('File Name')),
              DataColumn(label: Text('Date Created')),
              DataColumn(label: Text('Last Edit Date')),
              DataColumn(label: Text('Actions')),
            ],
            rows: files.map((file) {
              return DataRow(cells: [
                DataCell(
                  Text(file.name),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FileView(file: file),
                      ),
                    );
                  },
                ),
                DataCell(Text(file.createdAt)),
                DataCell(Text(file.updatedAt)),
                DataCell(
                  Row(
                    children: [
                      // IconButton(
                      //   icon: Icon(Icons.download, color: Colors.grey),
                      //    onPressed: () =>
                      //   showDownloadOptions(context, file),
                      // ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.grey),
                        onPressed: () {
                          context.read<FileCubit>().deleteFile(file, file.id);
                        },
                      ),
                    ],
                  ),
                ),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }

  // Build layout for narrow screens
  Widget _buildNarrowLayout(BuildContext context, List<Filee> files) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: files.length,
      itemBuilder: (context, index) {
        final file = files[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(file.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Created: ${file.createdAt}'),
                Text('Last Edited: ${file.updatedAt}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.grey),
                  onPressed: () {
                    context.read<FileCubit>().deleteFile(file, file.id);
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FileView(file: file),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
