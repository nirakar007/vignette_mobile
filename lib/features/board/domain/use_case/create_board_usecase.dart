import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';
import 'package:vignette__mobile/features/board/domain/repository/board_repository.dart';


class CreateBoardUseCase {
  final IBoardRepository repository;

  CreateBoardUseCase(this.repository);

  Future<void> call(BoardEntity board) async {
    await repository.createBoard(board);
  }
}