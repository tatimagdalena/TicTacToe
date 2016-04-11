------------------------------------------------
--	TicTacToe
--	Created by Tatiana de Oliveira Magdalena (1321440) on 10/04/2016.
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

	-- !!!!!!!!!!!!!!!! DUVIDA: qual seria o problema de usar playerMarker e playerName para construir tanto player1 quanto player2? !!!!!!!!!!!!!

	print("\n---------------------------")
	print("Sorting player for the first round...")
	first = sortFirstPlayer()
	if first == 1 then
		player1.turn = 1
		player2.turn = 2
		print("First player: ")
		showPlayerInfo(player1)
		print("Second player: ")
		showPlayerInfo(player2)
	else
		player1.turn = 2
		player2.turn = 1
		print("First player: ")
		showPlayerInfo(player2)
		print("Second player: ")
		showPlayerInfo(player1)
	end
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
	
    for line=1,3 do
      board[line] = {}     -- create a new row
      for column=1,3 do
        board[line][column] = "_"
      end
    end
end

function printBoard(board)
	
	print("---------------------------")
	print("-------")
	for line=1,3 do
		for column=1,3 do
			io.write("|")
			io.write(board[line][column])
		end
		io.write("|\n")
	end
	print("-------")
	print("---------------------------")
end

function checkEndOfGame(board)
	-- body
end

function fillPosition(board, marker, position)
	-- body
end

function isPositionEmpty(board, position)
	-- body
end

function computerMove(board)
	-- body
end

--Main program
local playersAmount
local validPlayersAmount
local filledXPositions
local filledOPositions
local player1 = {}
local player2 = {}
local board = {}

print("------------------------------------------------")
print("------------------------------------------------")
print("\n** WELCOME TO THE TIC-TAC-TOE CLASSIC GAME! **\n")

print("How many players? (1 or 2)")
io.write(">> ")
validPlayersAmount = false
while not validPlayersAmount do
	playersAmount = tonumber(io.read())
	validPlayersAmount = validatePlayersAmount(playersAmount)
	if not validPlayersAmount then
		print("Please, enter a valid number (1 or 2): ")
		io.write(">> ")
	end
end

createPlayers(playersAmount, player1, player2)
initializeEmptyBoard(board)

--Starts game



printBoard(board)