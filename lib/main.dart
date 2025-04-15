import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TodoHomePage(),
    );
  }
}

class Todo {
  String nome;
  bool concluida;

  Todo({
    required this.nome,
    this.concluida = false,
  });
}

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<Todo> _tarefas = [];
  final TextEditingController _controller = TextEditingController();

  void _adicionarTarefa() {
    final texto = _controller.text.trim();
    if (texto.isNotEmpty) {
      setState(() {
        _tarefas.add(Todo(nome: texto));
        _controller.clear();
      });
    }
  }

  void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
  }

  void _alternarConclusao(int index) {
    setState(() {
      _tarefas[index].concluida = !_tarefas[index].concluida;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Nova Tarefa',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _adicionarTarefa,
                  child: Text('Adicionar'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: _tarefas.isEmpty
                  ? Center(child: Text('Nenhuma tarefa adicionada.'))
                  : ListView.builder(
                      itemCount: _tarefas.length,
                      itemBuilder: (context, index) {
                        final tarefa = _tarefas[index];
                        return Card(
                          child: ListTile(
                            leading: Checkbox(
                              value: tarefa.concluida,
                              onChanged: (_) => _alternarConclusao(index),
                            ),
                            title: Text(
                              tarefa.nome,
                              style: TextStyle(
                                decoration: tarefa.concluida
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: tarefa.concluida
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removerTarefa(index),
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
