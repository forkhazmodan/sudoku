package com.example.sudoku;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class Sudoku3x3BoardTest {

    @Test
    void isValid_expectTrue() {
        Sudoku3x3Board sudokuBoard1 = new Sudoku3x3Board("8....1....123.6......4.7...4..932.6..31874.59..86..473185743.92293..87...461.9.85");
        Sudoku3x3Board sudokuBoard2 = new Sudoku3x3Board("874251936512396847369487521457932168631874259928615473185743692293568714746129385");

        Assertions.assertTrue(sudokuBoard1.isValid());
        Assertions.assertTrue(sudokuBoard2.isValid());
    }

    @Test
    void isValid_expectFalse_whenHasDuplicateValues() {
        Sudoku3x3Board sudokuBoard1 = new Sudoku3x3Board("874251836512396847369487521457932168631874259928615473185743692293568714746129385");
        Assertions.assertFalse(sudokuBoard1.isValid());
    }
}
