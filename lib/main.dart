import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  List<Map<String, String>> notes = [];

  void _addNote(String title, String content) {
    setState(() {
      notes.add({'title': title, 'content': content});
    });
  }

  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(),
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black87)),
      ),
      home: Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.list, color: Colors.grey),
                  selectedIcon: Icon(Icons.list_alt, color: Colors.blue),
                  label: Text('Notas'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.add, color: Colors.grey),
                  selectedIcon: Icon(Icons.note_add, color: Colors.blue),
                  label: Text('Nueva Nota'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person, color: Colors.grey),
                  selectedIcon: Icon(Icons.person_outline, color: Colors.blue),
                  label: Text('Usuario'),
                ),
              ],
            ),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  NotesScreen(notes: notes, deleteNote: _deleteNote),
                  NewNoteScreen(addNote: _addNote),
                  UserInfoScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotesScreen extends StatelessWidget {
  final List<Map<String, String>> notes;
  final Function(int) deleteNote;

  NotesScreen({required this.notes, required this.deleteNote});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Lista de Notas', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(notes[index]['title']!, style: TextStyle(color: Colors.black)),
                      subtitle: Text(notes[index]['content']!, style: TextStyle(color: Colors.black54)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteNote(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewNoteScreen extends StatefulWidget {
  final Function(String, String) addNote;

  NewNoteScreen({required this.addNote});

  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título', filled: true, fillColor: Colors.white),
              style: TextStyle(color: Colors.black),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Contenido', filled: true, fillColor: Colors.white),
              style: TextStyle(color: Colors.black),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.addNote(_titleController.text, _contentController.text);
                _titleController.clear();
                _contentController.clear();
              },
              child: Text('Guardar Nota'),
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.5sT0vQBc_DZI2E8l3JiKeAHaHa?rs=1&pid=ImgDetMain'),
          ),
          SizedBox(height: 10),
          Text('Nombre: Victor Raúl Alcántara Sánchez', style: TextStyle(fontSize: 18, color: Colors.black)),
          Text('Email: victor06112003@gmail.com', style: TextStyle(fontSize: 16, color: Colors.black54)),
        ],
      ),
    );
  }
}
