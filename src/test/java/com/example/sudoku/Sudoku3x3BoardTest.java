package com.example.sudoku;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

class Sudoku3x3BoardTest {
    @ParameterizedTest
    @ValueSource(strings = {
        "8....1....123.6......4.7...4..932.6..31874.59..86..473185743.92293..87...461.9.85",
        "874251936512396847369487521457932168631874259928615473185743692293568714746129385"
    })
    void isValid_expectTrue(String board) {
        Sudoku3x3Board sudokuBoard = new Sudoku3x3Board(board);
        Assertions.assertTrue(sudokuBoard.isValid());
    }

    @ParameterizedTest
    @ValueSource(strings = {
        "874251836512396847369487521457932168631874259928615473185743692293568714746129385"
    })
    void isValid_expectFalse_whenHasDuplicateValues(String board) {
        Sudoku3x3Board sudokuBoard1 = new Sudoku3x3Board(board);
        Assertions.assertFalse(sudokuBoard1.isValid());
    }
}
