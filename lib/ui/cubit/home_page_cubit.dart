import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/entity/todos.dart';
import 'package:todo_app/data/repo/todo_dao_repository.dart';

class HomePageCubit extends Cubit<List<ToDos>> {

  HomePageCubit() : super(<ToDos>[]);

  var repo = TodoDaoRepository();

  Future<void> listTodos() async {

    var list = await repo.listTodos();
    emit(list);
  }

  Future<void> search(String searchWord) async {

    var list = await repo.search(searchWord);
    emit(list);
  }

  Future<void> delete(int todo_id) async {

    await repo.delete(todo_id);
    await listTodos();
  }

  Future<void> saveTodoStatus(int todo_id, int todo_status) async {

    await repo.saveTodoStatus(todo_id, todo_status);
  }
}