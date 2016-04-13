------------------------------------------------
--	TicTacToe
--	Created by Tatiana de Oliveira Magdalena (1321440) on 10/04/2016.
--	v1.0
--	This document contains 398 code lines
------------------------------------------------

function validatePlayersAmount(players)
------------------------------------------------
-- Checks if the user chose a valid amount of players (1 or 2).
-- Parameter:
--		players: the amount of players chosen.
-- Return:
--		true, if it is a valid amount.
--		false, if not.
-----------------------------------------------
	if players ~=nil and (players == 1 or players == 2) then
		return true
	else
		return false
	end
end

function createPlayers(playersAmount, player1, player2)
------------------------------------------------
-- Create both players with a name and a marker that will be
-- used by her/him on the board.
-- Parameters:
--		playersAmount: 1, if there is one real player versus the computer,
--					   2, if there are 2 real players.
--		player1: an empty table to be filled with player 1 information.
--		player2: an empty table to be filled with player 2 information.
-----------------------------------------------
	local playerName
	local playerMarker
	local validMarker
	local first

	print("\n** Player 1 **")
	print("What's your name?")
	io.write(">> ")
	playerName = io.read()

	print("Which marker do you choose? (X or O)")
	io.write(">> ")
	validMarker = false
	while not validMarker do
		playerMarker = io.read()
		validMarker = validateMarkerType(playerMarker)
		if not validMarker then
			print("Please, enter a valid marker (X or O): ")
			io.write(">> ")
		end
	end
	player1.name = playerName
	player1.marker = playerMarker

	if playersAmount == 2 then
		print("\n** Player 2 **")
		print("What's your name?")
		io.write(">> ")
		playerName = io.read()
		if player1.marker == "X" then
			playerMarker = "O"
		else
			playerMarker = "X"
		end
	else
		playerName = "Computer"
		if player1.marker == "X" then
			playerMarker = "O"
		else
			playerMarker = "X"
		end
	end
	player2.name = playerName
	player2.marker = playerMarker

	print("\n---------------------------")
	print("Sorting player for the first round...")
	first = sortFirstPlayer()

	if first == 2 then
		auxiliarName = player1.name
		auxiliarMarker = player1.marker
		player1.name = player2.name
		player1.marker = player2.marker
		player2.name = auxiliarName
		player2.marker = auxiliarMarker
	end
	
	print("First player: ")
	showPlayerInfo(player1)
	print("Second player: ")
	showPlayerInfo(player2)
end

function validateMarkerType(marker)
------------------------------------------------
-- Checks if the user chose a valid marker type ("X" or "O).
-- Parameter:
--		marker: the marker chosen.
-- Return:
--		true, if it is a valid marker.
--		false, if not.
-----------------------------------------------	
	if marker ~=nil and (marker == "X" or marker == "O") then
		return true
	else
		return false
	end
end

function sortFirstPlayer()
------------------------------------------------
-- Sorts which player will be the first to play.
-- Return:
--		1, if it should be the first player.
--		2, if it should be the second player.
-----------------------------------------------
	local randomNumber 
	math.randomseed(os.time())
	randomNumber = math.random()
	if randomNumber <= 0.5 then
		return 1;
	else
		return 2;
	end
end

function showPlayerInfo(player)
------------------------------------------------
-- Displays a player's info on the console.
-- Parameters:
--		player: the player to be displayed.
-----------------------------------------------
	print("\tPlayer name: " .. player.name)
	print("\tPlayer marker: " .. player.marker)
end

function playGame(board, player1, player2)
------------------------------------------------
-- Makes the plays of the game, alterning between player1 and player2.
-- Parameter:
--		board: an empty table, in which the game will be played.
--		player1: the player for the first round.
--		player2: the player for the second round.
-- Return:
--		"X", if the player with marker "X" won (there is a line of "X" through the board),
--		"O", if the player with marker "O" won (there is a line of "O" through the board),
--		0  , if there was a draw (no empty spaces and nobody won),
--		-1 , if the game isn't over yet.
-----------------------------------------------

	local round = 0
	local chosenPosition = 0
	local winnerMarker = -1

	initializeEmptyBoard(board)

	while winnerMarker == -1 do

		local roundPlayer

		round = round + 1

		if (round % 2) == 1	then
			roundPlayer = player1
		else
			roundPlayer = player2
		end

		print("---------------------------")
		print("-------- Round " .. round .. " ---------")
		print(roundPlayer.name .. "'s turn.")

		

		if roundPlayer.name ~= "Computer" then
			chosenPosition = playerMove(board)
		else
			chosenPosition = computerMove(board)
		end

		fillPosition(board, roundPlayer.marker, chosenPosition)
		printBoard(board)

		winnerMarker = checkEndOfGame(board)
	end

	return winnerMarker
end

function initializeEmptyBoard(board)
------------------------------------------------
-- Creates an empty board represented by an array from 1 to 9,
-- with "_" representing the empty spaces.
-- Parameter:
--		board: an empty table
-----------------------------------------------
    for position=1,9 do
      board[position] = "_"
    end

    --The positions are printed in order to show the player how to choose.
    print("-------")
	for position = 1,9 do
		io.write("|")
		io.write(position)
		if position%3 == 0 then
			io.write("|\n")
		end
	end
	print("-------")
end

function playerMove(board)
------------------------------------------------
-- Gets a play for a real player, between the empty positions on the board.
-- Parameter:
--		board: the board been used by the game.
-- Return:
--		chosenPosition: the position chosen by a real player
-----------------------------------------------
	local validPosition
	local chosenPosition

	print("\nChoose a position (1-9):")
	io.write(">> ")
	validPosition = false
	while not validPosition do
	chosenPosition = tonumber(io.read())
	validPosition = isPositionEmpty(board, chosenPosition)
		if not validPosition then
			print("Please, enter the index of an empty space (from 1 to 9)")
			io.write(">> ")
		end
	end

	return chosenPosition
end

function computerMove(board)
------------------------------------------------
-- Creates a random play for a computer player, between the empty positions on the board.
-- Parameter:
--		board: the board been used by the game.
-- Return:
--		chosenPosition: the position chosen randomly by a computer player
-----------------------------------------------
	local chosenPosition = 0
	local validPosition = false

	math.randomseed(os.time())
	while not validPosition do
		chosenPosition = math.random(9)
		validPosition = isPositionEmpty(board, chosenPosition)
	end
	return chosenPosition
end

function isPositionEmpty(board, position)
------------------------------------------------
-- Checks if a board position is empty.
-- Parameter:
--		board: the board been used by the game.
--		position: the position to be analized.
-- Return:
--		true, if the position is empty (which is represented by "_")
--		false, if not.
-----------------------------------------------
	if position ~=nil and position>=1 and position<=9 and board[position] == "_" then
		return true
	else
		return false
	end
end

function fillPosition(board, marker, position)
------------------------------------------------
-- Puts a marker into a chosen board position.
-- Parameter:
--		board: the board been used by the game.
--		marker: the marker to be writen.
--		position: the position in which to write the marker.
-----------------------------------------------

	board[position] = marker
end


function printBoard(board)
------------------------------------------------
-- Displays the game board on the console.
-- Parameters:
--		board: the board been used by the game.
-----------------------------------------------
	print("-------")
	for position = 1,9 do
		io.write("|")
		io.write(board[position])
		if position%3 == 0 then
			io.write("|\n")
		end
	end
	print("-------")
end

function checkEndOfGame(board)
------------------------------------------------
-- Checks if the game is over.
-- Parameter:
--		board: the board been used by the game.
-- Return:
--		"X", if the player with marker "X" won (there is a line of "X" through the board),
--		"O", if the player with marker "O" won (there is a line of "O" through the board),
--		0  , if there was a draw (no empty spaces and nobody won),
--		-1 , if the game isn't over yet.
-----------------------------------------------
	if board[1]~="_" and (board[1] == board[2]) and (board[2] == board[3]) then
		return board[1]
	elseif board[1]~="_" and (board[1] == board[4]) and (board[4] == board[7]) then
		return board[1]
	elseif board[3]~="_" and (board[3] == board[6]) and (board[6] == board[9]) then
		return board[3]
	elseif board[7]~="_" and (board[7] == board[8]) and (board[8] == board[9]) then
		return board[7]
	elseif board[1]~="_" and (board[1] == board[5]) and (board[5] == board[9]) then
		return board[1]
	elseif board[3]~="_" and (board[3] == board[5]) and (board[5] == board[7]) then
		return board[3]
	elseif board[1]~="_" and board[2]~="_" and board[3]~="_" and board[4]~="_" and board[5]~="_" and board[6]~="_" and board[7]~="_" and board[8]~="_" and board[9]~="_" then 
		return 0
	else
		return -1
	end
end

function showTheWinner(player1, player2, winnerMarker)
------------------------------------------------
-- Displays the name of the winner.
-- Parameters:
--		board: the board been used by the game.
--		player1: the player for the first round.
--		player2: the player for the second round.
-----------------------------------------------

	if winnerMarker == 0 then
	print("End of game: IT'S A DRAW!!!")
	elseif player1.marker == winnerMarker then
		print("End of game: " .. player1.name .. " wins!!!")
	else
		print("End of game: " .. player2.name .. " wins!!!")
	end

end



---------------------------------------------------------
---------------------------------------------------------
--Main program
---------------------------------------------------------
---------------------------------------------------------

local playersAmount = 0
local validPlayersAmount = false
local player1 = {}
local player2 = {}
local board = {}
local winnerMarker = -1

print("------------------------------------------------")
print("------------------------------------------------")
print("\n** WELCOME TO THE TIC-TAC-TOE CLASSIC GAME! **\n")

--Players register

print("How many players? (1 or 2)")
io.write(">> ")
while not validPlayersAmount do
	playersAmount = tonumber(io.read())
	validPlayersAmount = validatePlayersAmount(playersAmount)
	if not validPlayersAmount then
		print("Please, enter a valid number (1 or 2): ")
		io.write(">> ")
	end
end

createPlayers(playersAmount, player1, player2)

--Starts game

winnerMarker = playGame(board, player1, player2)

--Announces winner

showTheWinner(player1, player2, winnerMarker)