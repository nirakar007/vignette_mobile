import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';
import 'package:vignette__mobile/features/board/domain/repository/board_repository.dart';

class GetBoardsUseCase {
  final IBoardRepository repository;

  GetBoardsUseCase(this.repository);

  Future<List<BoardEntity>> call(String userId) async {
    return await repository.getBoards(userId);
  }
}
