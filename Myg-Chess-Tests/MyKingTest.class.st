Class {
	#name : 'MyKingTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyKingTest >> testIsCheckByOpponentsRook [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an atacker rook on e column"
	board at: 'e1' put: MyRook black.

	self assert: king isInCheck
]

{ #category : 'tests' }
MyKingTest >> testIsNotCheckBySameColorRook [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an same color rook on e column"
	board at: 'e1' put: MyRook white.

	self deny: king isInCheck
]

{ #category : 'tests' }
MyKingTest >> testKingCanCaptureUndefendedPiece [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).
	board at: 'd4' put: MyKnight black.
	self assert: (king legalTargetSquares includes: (board at: 'd4'))
]

{ #category : 'tests' }
MyKingTest >> testKingCannotMoveOntoSquareAttackedByPawn [

	| king board |
	board := MyChessBoard empty.
	board at: 'd3' put: (king := MyKing white).
	"A black pawn on e5 attacks d4 and f4"
	board at: 'e5' put: MyPawn black.
	self deny: (king legalTargetSquares includes: (board at: 'd4')).
	self assert: (king legalTargetSquares includes: (board at: 'e4'))
]

{ #category : 'tests' }
MyKingTest >> testIsInCheckByPawn [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).
	board at: 'd5' put: MyPawn black.
	self assert: king isInCheck
]
