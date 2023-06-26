package com.example.sudoku;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.Response;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

@Path("/sudoku")
public class SudokuResource {

    @GET
    @Produces("application/json")
    public Response mock() throws IOException {
        ClassLoader classLoader = getClass().getClassLoader();
        InputStream inputStream = classLoader.getResourceAsStream("mocks/mock1.json");

        if (inputStream == null) {
            throw new IllegalArgumentException("file not found! " + "mocks/mock1.json");
        }

        return Response.ok(new String(inputStream.readAllBytes(), StandardCharsets.UTF_8)).build();
    }

    @POST
    @Produces("application/json")
    public Response validate(String board) {
        Sudoku3x3Board sudokuBoard;
        try {
            sudokuBoard = new Sudoku3x3Board(board);
            sudokuBoard.validate();
        } catch (IllegalArgumentException e) {
            return Response.status(400).entity(e.getMessage()).build();
        }

        return Response.ok(board).build();
    }
}
