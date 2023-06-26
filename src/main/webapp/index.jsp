<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Sudoku</title>
    <style>
        body {
            display: grid;
            justify-items: center;
            align-items: center;
        }

        #board {
            padding: 7px;
            background: black;

            display: grid;
            grid-template-rows: repeat(9, auto);
            grid-template-columns: repeat(9, auto);
            column-gap: 2px;
            row-gap: 2px;

            margin-bottom: 70px;
        }

        .cell {
            width: 50px;
            height: 50px;
            background: white;

            display: grid;
            justify-items: center;
            align-items: center;
        }

        .cell:hover {
            background: rgb(214, 233, 240);
        }

        .cell:focus {
            background: lightblue;
        }

        .cell:nth-child(3n):not(:nth-child(9n)) {
            margin-right: 3px;
        }

        .cell:nth-child(27n + 28),
        .cell:nth-child(27n + 29),
        .cell:nth-child(27n + 30),
        .cell:nth-child(27n + 31),
        .cell:nth-child(27n + 32),
        .cell:nth-child(27n + 33),
        .cell:nth-child(27n + 34),
        .cell:nth-child(27n + 35),
        .cell:nth-child(27n + 36) {
            margin-top: 3px;
        }

        #board::after {
            content: " ";
            position: absolute;
            top: 497px;
            height: 50px;
            width: 500px;
            left: calc(100vw / 2 - 250px);
            z-index: 5;
            background: rgba(255, 255, 255, 0.623);
        }

        .cell > label {
            position: absolute;
            top: 500px;
            width: 40px;
            height: 40px;
            font-size: 30px;
            border: 2px solid darkgreen;
            border-radius: 7px;
            display: grid;
            justify-items: center;
            align-items: center;
            visibility: hidden;
        }

        .cell:first-of-type > label {
            visibility: visible;
        }

        .cell > input[value=" "] + label {
            left: calc(100vw / 2 + 5px - 250px);
        }

        .cell > input[value="1"] + label {
            left: calc(100vw / 2 + 5px - 200px);
        }

        .cell > input[value="2"] + label {
            left: calc(100vw / 2 + 5px - 150px);
        }

        .cell > input[value="3"] + label {
            left: calc(100vw / 2 + 5px - 100px);
        }

        .cell > input[value="4"] + label {
            left: calc(100vw / 2 + 5px - 50px);
        }

        .cell > input[value="5"] + label {
            left: calc(100vw / 2 + 5px);
        }

        .cell > input[value="6"] + label {
            left: calc(100vw / 2 + 5px + 50px);
        }

        .cell > input[value="7"] + label {
            left: calc(100vw / 2 + 5px + 100px);
        }

        .cell > input[value="8"] + label {
            left: calc(100vw / 2 + 5px + 150px);
        }

        .cell > input[value="9"] + label {
            left: calc(100vw / 2 + 5px + 200px);
        }

        .cell:focus > label {
            z-index: 10;
            visibility: visible;
        }

        .cell > input {
            display: none;

        }

        .cell > input:checked {
            width: 50px;
            height: 50px;
            margin: 0;
            visibility: hidden;

            display: inline-grid;
            justify-items: center;
            align-items: center;
        }

        .cell > input::after {
            content: " ";
            font-size: 30px;
            visibility: visible;
        }

        .cell > input[value="1"]:checked::after {
            content: "1";
        }

        .cell > input[value="2"]:checked::after {
            content: "2";
        }

        .cell > input[value="3"]:checked::after {
            content: "3";
        }

        .cell > input[value="4"]:checked::after {
            content: "4";
        }

        .cell > input[value="5"]:checked::after {
            content: "5";
        }

        .cell > input[value="6"]:checked::after {
            content: "6";
        }

        .cell > input[value="7"]:checked::after {
            content: "7";
        }

        .cell > input[value="8"]:checked::after {
            content: "8";
        }

        .cell > input[value="9"]:checked::after {
            content: "9";
        }
    </style>
</head>
<body>
<div id="board"></div>
</body>
<script>
    (function() {
        document.onload = function() {
            alert("test");
        }

        const xhr = new XMLHttpRequest();
        xhr.open("GET", "http://localhost:8080/sudoku_war_exploded/api/sudoku", false);
        xhr.setRequestHeader("Accept", "application/json");
        xhr.setRequestHeader("Content-Type", "application/json");
        xhr.onreadystatechange = function () {
            if (xhr.status === 200) {
                document.querySelector("[id=board]").innerHTML = "";
                let board = xhr.response.trim();
                for (let i = 0; i < board.length; i++) {
                    let value = board[i] === "." ? "." : board[i];
                    let label = board[i] === "." ? "" : board[i];
                    if (board[i] === ".") {
                        document.querySelector("[id=board]").innerHTML += '<div class="cell editable" tabindex="0"><span></span><input type="number"></div>';
                    } else {
                        document.querySelector("[id=board]").innerHTML += '<div class="cell" style="background-color:rgba(205,205,205,0.8);" tabindex="0"><span>' + label + '</span><input type="number" value="'+value+'"></div>';
                    }
                }
            }
        }
        xhr.send()
        window.addEventListener("keydown", (event) => {
            const key = event.key
            if (event.target.className !== "cell editable") {
                return;
            }
            if (!/^[1-9]$/.test(key)) {
                alert("Invalid key, use 1-9")
                return;
            }

            const input = event.target.querySelector('input');
            const span = event.target.querySelector('span');
            input.value = key;
            span.innerHTML = key

            const data = document.querySelectorAll('input');
            let board = "";
            for (let i = 0; i < data.length; i++) {
                if (data[i].value.length === 0) {
                    board = board + ".";
                } else {
                    board = board + data[i].value
                }
            }

            let xhr = new XMLHttpRequest();
            xhr.open("POST", "http://localhost:8080/sudoku_war_exploded/api/sudoku");
            xhr.setRequestHeader("Accept", "application/json");
            xhr.setRequestHeader("Content-Type", "application/json");
            xhr.addEventListener("load", function (e) {
                if(xhr.status === 200) {
                } else if (xhr.status === 400) {
                    alert(xhr.response);
                } else {
                    console.log(xhr)
                }
            });
            xhr.send(board);
        });
    })();
</script>
</html>
