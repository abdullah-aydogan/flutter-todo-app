import 'package:todo_app/data/entity/todos.dart';
import 'package:todo_app/sqlite/database_helper.dart';

class TodoDaoRepository {

  Future<void> save(String todo_content, int todo_status) async {

    var db = await DatabaseHelper.databaseAccess();
    var newTodo = Map<String, dynamic>();

    newTodo["todo_content"] = todo_content;
    newTodo["todo_status"] = 0;

    await db.insert("todos", newTodo);
  }

  Future<void> update(int todo_id, String todo_content, int todo_status) async {

    var db = await DatabaseHelper.databaseAccess();
    var updatedTodo = Map<String, dynamic>();

    updatedTodo["todo_content"] = todo_content;
    updatedTodo["todo_status"] = todo_status;

    await db.update("todos", updatedTodo, where: "todo_id = ?", whereArgs: [todo_id]);
  }

  Future<void> delete(int todo_id) async {

    var db = await DatabaseHelper.databaseAccess();

    await db.delete("todos", where: "todo_id = ?", whereArgs: [todo_id]);
  }

  Future<List<ToDos>> listTodos() async {

    var db = await DatabaseHelper.databaseAccess();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM todos");

    return List.generate(maps.length, (index) {

      var todo = maps[index];

      return ToDos(todo_id: todo["todo_id"], todo_content: todo["todo_content"], todo_status: todo["todo_status"]);
    });
  }

  Future<List<ToDos>> search(String searchWord) async {

    var db = await DatabaseHelper.databaseAccess();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM todos WHERE todo_content LIKE '%$searchWord%'");

    return List.generate(maps.length, (i) {

      var todo = maps[i];

      return ToDos(todo_id: todo["todo_id"], todo_content: todo["todo_content"], todo_status: todo["todo_status"]);
    });
  }

  Future<void> saveTodoStatus(int todo_id, int todo_status) async {

    var db = await DatabaseHelper.databaseAccess();
    var updatedTodo = Map<String, dynamic>();

    updatedTodo["todo_status"] = todo_status;

    await db.update("todos", updatedTodo, where: "todo_id = ?", whereArgs: [todo_id]);
  }
}