import 'package:diafcon/scoped_models/combined_model.dart';
import 'package:scoped_model/scoped_model.dart';


class AppModel extends Model
    with CoreModel, UserModel, ExpensesModel, FilterModel {}
