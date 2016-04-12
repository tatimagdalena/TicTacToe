------------------------------------------------
--	TicTacToe
--	Created by Tatiana de Oliveira Magdalena (1321440) on 10/04/2016.
--  v1.0
--  This document contains 292 code lines
------------------------------------------------

function createPlayers(playersAmount, player1, player2)

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

function showPlayerInfo(player)

	print("\tPlayer name: " .. player.name)
	print("\tPlayer marker: " .. player.marker)
end

function sortFirstPlayer()

	local randomNumber 
	math.randomseed(os.time())
	randomNumber = math.random()
	if randomNumber <= 0.5 then
		return 1;
	else
		return 2;
	end
end

function validatePlayersAmount(players)
	
	if players ~=nil and (players == 1 or players == 2) then
		return true
	else
		return false
	end
end

function validateMarkerType(marker)
	
	if marker ~=nil and (marker == "X" or marker == "O") then
		return true
	else
		return false
	end
end

function initializeEmptyBoard(board)
	
    for position=1,9 do
      board[position] = "_"
    end
end

function printBoard(board)
	
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

function printIndexedEmptyBoard(board)

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

function checkEndOfGame(board)

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

function isPositionEmpty(board, position)

	if position ~=nil and position>=1 and position<=9 and board[position] == "_" then
		return true
	else
		return false
	end
end

function fillPosition(board, marker, position)

	board[position] = marker
end

function computerMove(board)

	local chosenPosition = 0
	local validPosition = false

	math.randomseed(os.time())
	while not validPosition do
		chosenPosition = math.random(9)
		validPosition = isPositionEmpty(board, chosenPosition)
	end
	return chosenPosition
end

function playerMove(board)

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



---------------------------------------------------------
--Main program
---------------------------------------------------------

local playersAmount = 0
local validPlayersAmount = false
local player1 = {}
local player2 = {}
local board = {}
local winnerMarker = -1
local round = 0
local chosenPosition = 0

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

initializeEmptyBoard(board)
printIndexedEmptyBoard(board)

while winnerMarker == -1 do

	local roundPlayer

	if (round % 2) == 1	then
		roundPlayer = player1
	else
		roundPlayer = player2
	end

	print("---------------------------")
	round = round + 1
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

	

--Announces winner

if winnerMarker == 0 then
	print("End of game: IT'S A DRAW!!!")
elseif player1.marker == winnerMarker then
	print("End of game: " .. player1.name .. " wins!!!")
else
	print("End of game: " .. player2.name .. " wins!!!")
end




