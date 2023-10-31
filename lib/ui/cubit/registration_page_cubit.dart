import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/repo/todo_dao_repository.dart';

class RegistrationPageCubit extends Cubit<void> {

  RegistrationPageCubit() : super(0);

  var repo = TodoDaoRepository();

  Future<void> save(String todo_content, int todo_status) async {

    await repo.save(todo_content, todo_status);
  }
}