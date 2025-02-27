import 'package:vignette__mobile/features/board/domain/repository/board_repository.dart';


class DeleteBoardUseCase {
  final IBoardRepository repository;

  DeleteBoardUseCase(this.repository);

  Future<void> call(String boardId) async {
    await repository.deleteBoard(boardId);
  }
}