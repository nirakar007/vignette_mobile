
import 'package:vignette__mobile/features/board/domain/repository/board_repository.dart';

class SyncBoardsUseCase {
  final IBoardRepository repository;

  SyncBoardsUseCase(this.repository);

  Future<void> call() async {
    await repository.syncBoards();
  }
}