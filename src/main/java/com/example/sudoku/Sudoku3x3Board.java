package com.example.sudoku;

import java.util.Collection;
import java.util.HashSet;
import java.util.stream.Collectors;

public class Sudoku3x3Board {

    private char[][] board;

    public Sudoku3x3Board(String stringBoard) {
        if (stringBoard.length() != 81) {
            throw new IllegalArgumentException("Invalid 3x3 board size.");
        }
        this.board = new char[9][9];
        for (int i = 0; i < stringBoard.toCharArray().length; i++) {
            board[i/9][i%9] = stringBoard.charAt(i);
        }
    }

    public boolean isValid() {
        try {
            this.validate();
        } catch (IllegalArgumentException e) {
            return false;
        }
        return true;
    }

    public void validate() {
        Collection<String> present = new HashSet<>();
        Collection<String> violations = new HashSet<>();
        for (int row = 0; row < 9; row++) {
            for (int col = 0; col < 9; col++) {
                char val = board[row][col];
                if ('.' == val) {
                    continue;
                };

                var rowMessage = val + " is present in row:" + (row + 1);
                var colMessage = val + " is present in column:" + (col + 1);
                var boxMessage = val + " is present in box:" + (row/3 + 1) + "-" + (col/3 + 1);

                if (present.contains(rowMessage)) {
                    violations.add(rowMessage);
                }

                if(present.contains(colMessage)) {
                    violations.add(colMessage);
                }

                if(present.contains(boxMessage)) {
                    violations.add(boxMessage);
                }

                if (violations.size() > 0) {
                    String message = violations.stream()
                        .map(Object::toString)
                        .collect(Collectors.joining(";"));
                    throw new IllegalArgumentException(message);
                }

                present.add(rowMessage);
                present.add(colMessage);
                present.add(boxMessage);
            }
        }
    }
}
