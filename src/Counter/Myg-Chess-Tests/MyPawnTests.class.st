Class {
	#name : 'MyPawnTests',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTests >> testCannotCaptureStraightAhead [
	| pawn squares board |
	board := MyChessBoard empty.
	board at: 'e2' put: (pawn := MyPawn white).
	board at: 'e3' put: MyPawn black.
	squares := pawn targetSquares.
	self assert: (squares includes: (board at: 'e3')) not
]

{ #category : 'tests' }
MyPawnTests >> testDiagonalCapture [
	| pawn squares board |
	board := MyChessBoard empty.
	board at: 'e4' put: (pawn := MyPawn white).
	board at: 'd5' put: MyPawn black.
	squares := pawn targetSquares.
	self assert: (squares includes: (board at: 'd5'))
]

{ #category : 'tests' }
MyPawnTests >> testStartMovesTwoSquares [
	| pawn squares board |
	board := MyChessBoard empty.
	board at: 'e2' put: (pawn := MyPawn white).
	squares := pawn targetSquares.
	self assertCollection: squares includesAll: (#(e3 e4) collect: [ :name | board at: name ])

]
