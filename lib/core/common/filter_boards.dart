import 'package:flutter/material.dart';

class FilterBoards extends StatefulWidget {
  final Function(String) onApply;
  final VoidCallback onReset;

  const FilterBoards({
    super.key,
    required this.onApply,
    required this.onReset,
  });

  @override
  _FilterBoardsState createState() => _FilterBoardsState();
}

class _FilterBoardsState extends State<FilterBoards> {
  String selectedSortOption = 'Date';
  bool isDateChecked = true;
  bool isFavoritesChecked = false;

  void _resetFilters() {
    setState(() {
      isDateChecked = true;
      isFavoritesChecked = false;
      selectedSortOption = 'Date';
    });
    widget.onReset();
  }

  void _applyFilters() {
    widget.onApply(selectedSortOption);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter Boards',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.tune, color: Colors.black),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: isDateChecked,
                onChanged: (value) {
                  setState(() {
                    isDateChecked = value!;
                    isFavoritesChecked = !value;
                    selectedSortOption = 'Date';
                  });
                },
              ),
              const Text('Date'),
              const Spacer(),
              const Text(
                '10 | 12 | 2023 — 10 | 12 | 2023',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: isFavoritesChecked,
                onChanged: (value) {
                  setState(() {
                    isFavoritesChecked = value!;
                    isDateChecked = !value;
                    selectedSortOption = 'Favourites';
                  });
                },
              ),
              const Text('Favourites'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Apply'),
              ),
              TextButton(
                onPressed: _resetFilters,
                child: const Text(
                  'Reset',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
