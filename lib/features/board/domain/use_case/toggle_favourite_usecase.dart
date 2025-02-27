import 'package:vignette__mobile/features/board/domain/repository/board_repository.dart';


class ToggleFavoriteUseCase {
  final IBoardRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<void> call(String boardId, bool isFavorite) async {
    await repository.toggleFavorite(boardId, isFavorite);
  }
}