import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/repo/todo_dao_repository.dart';

class DetailPageCubit extends Cubit<void> {

  DetailPageCubit() : super(0);

  var repo = TodoDaoRepository();

  Future<void> update(int todo_id, String todo_content, int todo_status) async {

    await repo.update(todo_id, todo_content, todo_status);
  }
}