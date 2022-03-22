
import chess
import chess.engine
import random
import numpy
import sys
import socket

HOST = "localhost"
PORT = 6666

board = chess.Board()

def alphaBeta(board, depth, alpha, beta, player):
    if depth == 0 or board.is_game_over():
        boardAux= board.copy()
        for i in range(0,min(5,board.fullmove_number-1)):
            boardAux.pop()
        if boardAux.is_irreversible(board.peek()):
            avanza = 100*(5/board.fullmove_number)+5
        else:
            avanza = 0
        return - evaluation_2(board) + avanza
    possible_moves = board.legal_moves # lista de movimientos que se pueden hacer (en uci)
    moves_ranked = rankMoves(possible_moves)
    if player:
        best_move = -9999
        for i in moves_ranked:
            move = chess.Move.from_uci(str(i))
            board.push(move)
            best_move = max(best_move, alphaBeta(board, depth - 1, alpha, beta, not player))
            board.pop()
            alpha = max(alpha, best_move)
            if beta <= alpha:
                return best_move
        return best_move
    else:
        best_move = 9999
        for i in moves_ranked:
            move = chess.Move.from_uci(str(i))
            board.push(move)
            best_move = min(best_move, alphaBeta(board, depth - 1, alpha, beta, not player))
            beta = min(best_move, beta)
            board.pop()
            if beta <= alpha:
                return best_move
        return best_move

def alphaBetaR(board, depth, player):
    possible_moves = board.legal_moves
    best_move = -9999
    final_move = None
    moves_ranked = rankMoves(possible_moves)
    for i in moves_ranked:
        move = chess.Move.from_uci(str(i))
        board.push(move)
        value = max(best_move, alphaBeta(board, depth - 1,-10000,10000, not player))
        board.pop()
        if value > best_move:
            print("Best score: " ,str(value))
            print("Best move: ",str(move))
            best_move = value
            final_move = move
    return final_move



# -------------------------------------------------------

# def searchCaptures(board, alpha, beta):
#     value = evaluation_2(board)
#     if value >= beta:
#         return beta
#     alpha = max(alpha, value)
#     possible_moves = board.legal_moves
#     capture_moves = getCaptures(possible_moves)
#     ranked_captures = rankMoves(capture_moves)
#     for i in ranked_captures:
#         move = chess.Move.from_uci(str(i))
#         board.push(move)
#         value = - searchCaptures(board, -beta, -alpha)
#         board.pop()
#         if value >= beta:
#             return beta
#         alpha = max(value, alpha)
#     return alpha
    

def getCaptures(moves):
    list_captures = []
    for i in moves:
        if board.piece_at(chess.parse_square(str(i)[2:4])) != None:
            list_captures.append(i)
    return list_captures
    

def pieceValue_2(piece):
    value = 0
    # Peones valen 1
    if piece == 1:
        value = 10
    # Caballos y alfiles valen 3
    if piece == 2 or piece == 3:
        value = 30
    # Torres valen 5 
    if piece == 4:
        value = 50
    # Reina vale 9
    if piece == 5:
        value = 90
    # Rey vale un chingo
    if piece == 6:
        value = 900
    return value

def countMaterial_2(board, color):
    material = 0
    for i in range(1,7):
        material += len(board.pieces(i,color)) * pieceValue_2(i)
    return material

def evaluation_2(board):
    value_white = countMaterial_2(board, True)
    value_white += countAttacks_2(board, True)
    value_black = countMaterial_2(board, False)
    value_black += countAttacks_2(board, False)
    value = value_white - value_black
    if not board.turn:
        value = value * (-0.8)
    return value

# def countAttacks(board, color):
#     difference = 0
#     for i in range(64):
#         attacking = board.attacks(i)
#         attacked = board.attackers(not color, i)
#         difference += len(attacking) - len(attacked)
#     return difference

def countAttacks_2(board, color):
    difference = 0
    for i in range(64):
        if not board.is_pinned(color, i):
            attacking = board.attacks(i)
        attacked = board.attackers(not color, i)
        for j in attacked:
            if board.is_pinned(not color, j):
                difference += 1
        difference += len(attacking) - len(attacked)
    return difference

     


list_pieces = ['p', 'n', 'b', 'r', 'q', 'k']

def rankMoves(moves):
    list_moves_ranked = []
    for i in moves:
        score_guess = 0
        move_piece = board.piece_at(chess.parse_square(str(i)[0:2]))
        capture_piece = board.piece_at(chess.parse_square(str(i)[2:4]))
        if move_piece != None:
            move_piece = list_pieces.index(board.piece_at(chess.parse_square(str(i)[0:2])).symbol().lower()) + 1
            if capture_piece != None:
                capture_piece = list_pieces.index(board.piece_at(chess.parse_square(str(i)[2:4])).symbol().lower()) + 1
                score_guess = 10 * pieceValue_2(capture_piece) - pieceValue_2(move_piece)
                list_moves_ranked.append(i)
    for i in moves:
        if i not in list_moves_ranked:
            list_moves_ranked.append(i)
    return list_moves_ranked
    # if len(i) == 5:


# -------------------------------------------------


def play():
    ##############################################################################3
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    print('Socket created')

    try:
        s.bind((HOST, PORT))
    except socket.error as err:
        print('Bind failed. Error Code : ' .format(err))
    s.listen(10)
    print("Socket Listening")
    conn, addr = s.accept()
    #conn.send(bytes("0",'UTF-8'))
    
    #conn.send(bytes("1",'UTF-8'))
    #print("Message sent")
    
    ##################################################################################3
    board = chess.Board()
    cad = "" ###############
    n = 0
    
    print(board) ####################
    #conn.send(bytes(board.__str__,'UTF-8'))
    while not board.is_game_over():
        


        if n%2 == 0:
            while cad == "":
                cad = conn.recv(1024).decode()
                if cad != "":
                    move = cad
                    if move == 'x':
                        break
                    move = chess.Move.from_uci(str(move))
                    possible_moves = board.legal_moves
                    if move not in possible_moves:
                        print('Not a move.')
                        cad = ""
                        conn.send(bytes("mal",'UTF-8'))
                    else:
                        conn.send(bytes("bien",'UTF-8'))
            print(move)####
            if move == 'x':
                break
     #       move = chess.Move.from_uci(str(move))
    #        possible_moves = board.legal_moves
   #         if move not in possible_moves:
  #              print('Not a move. Last chance...')
 #               move = input("Enter move: ")
#                move = chess.Move.from_uci(str(move))
            board.push(move)
        else:
            print("My turn: ")
            move = alphaBetaR(board,3,True)
            move = chess.Move.from_uci(str(move))
            board.push(move)
            conn.send(bytes(str(move),'UTF-8'))
        print(board)############################
        cad = ""
        n += 1
    print('Game Over')

play()












