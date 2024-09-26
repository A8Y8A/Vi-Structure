import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/domain/entitieas/note.dart';
import 'package:project2/presentation/controller/notecubit/note_cubit.dart';
import 'package:project2/presentation/controller/notecubit/note_state.dart';

class Mynotes extends StatefulWidget {
  @override
  State<Mynotes> createState() => _MynotesState();
}

class _MynotesState extends State<Mynotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: NoteTable());
  }
}

class NoteTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<NoteCubit>().fetchNotes();
    return Scaffold(
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          if (state is NoteLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NoteLoaded) {
            return LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return _buildWideLayout(context, state.notes);
                } else {
                  return _buildNarrowLayout(context, state.notes);
                }
              },
            );
          } else if (state is NoteError) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return Center(child: Text('No notes available.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Fetch the notes when the button is pressed
          context.read<NoteCubit>().fetchNotes();
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.refresh),
      ),
    );
  }

  // Build layout for wide screens
  Widget _buildWideLayout(BuildContext context, List<Note> notes) {
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
              DataColumn(label: Text('Note Name')),
              DataColumn(label: Text('Document Name')),
              DataColumn(label: Text('Created At')),
              DataColumn(label: Text('Actions')),
            ],
            rows: notes.map((note) {
              return DataRow(cells: [
                DataCell(
                  Text(note.noteName),
                  onTap: () => _showNoteContentDialog(context, note),
                ),
                DataCell(Text(note.documentName ?? 'Unknown Document')),
                DataCell(Text(note.createdAt ?? 'Unknown Date')),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context.read<NoteCubit>().deleteNoteById(note.id);
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
  Widget _buildNarrowLayout(BuildContext context, List<Note> notes) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(note.noteName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Document: ${note.documentName ?? 'Unknown Document'}'),
                Text('Created At: ${note.createdAt ?? 'Unknown Date'}'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                context.read<NoteCubit>().deleteNoteById(note.id);
              },
            ),
            onTap: () => _showNoteContentDialog(context, note),
          ),
        );
      },
    );
  }

  void _showNoteContentDialog(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(note.noteName),
          content: SingleChildScrollView(
            child: Text(note.noteContent),
          ),
          actions: [
            TextButton(
              child: Text('Close', style: TextStyle(color: Colors.deepPurple)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}



// class FileTable extends StatelessWidget {
//   final List<FileData> files = List.generate(
//     20, // Generates 20 entries
//         (index) => FileData(
//       'Note ${index + 1}',
//       'Document ${index + 1}',
//       '01/${index + 1}/2024',
//     ),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Table(
//         border: TableBorder.all(color: Colors.grey),
//         children: [
//           TableRow(
//             decoration: BoxDecoration(color: Colors.deepPurple),
//             children: [
//               TableCell(
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Center(child: Text('Note Name', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
//                 ),
//               ),
//               TableCell(
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Center(child: Text('Document Name', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
//                 ),
//               ),
//               TableCell(
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Center(child: Text('Created Date', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
//                 ),
//               ),
//               TableCell(
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Center(child: Text('Action', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
//                 ),
//               ),
//             ],
//           ),
//           ...files.map((file) {
//             return TableRow(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     print('${file.noteName} container pressed');
//                   },
//                   child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Center(child: Text(file.noteName,style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),)),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Center(child: Text(file.documentName,style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold))),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Center(child: Text(file.createdDate,style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold))),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: InkWell(
//                     onTap: () {
//                       print('Delete ${file.noteName}');
//                     },
//                     child: Icon(Icons.delete, color: Colors.deepPurple),
//                   ),
//                 ),
//               ],
//             );
//           }).toList(),
//         ],
//       ),
//     );
//   }
// }

// class FileData {
//   final String noteName;
//   final String documentName;
//   final String createdDate;

//   FileData(this.noteName, this.documentName, this.createdDate);
// }
