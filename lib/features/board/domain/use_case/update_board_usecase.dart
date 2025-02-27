import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';
import 'package:vignette__mobile/features/board/domain/repository/board_repository.dart';

class UpdateBoardUseCase {
  final IBoardRepository repository;

  UpdateBoardUseCase(this.repository);

  Future<void> call(BoardEntity board) async {
    await repository.updateBoard(board);
  }
}
