Class {
	#name : 'MyQueenTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyQueenTest >> testBlockedBySameColorPiece [

	| queen board |
	board := MyChessBoard empty.
	board at: 'd4' put: (queen := MyQueen white).
	board at: 'd6' put: MyPawn white.
	self assert: (queen legalTargetSquares includes: (board at: 'd5')).
	self deny: (queen legalTargetSquares includes: (board at: 'd6')).
	self deny: (queen legalTargetSquares includes: (board at: 'd7'))
]

{ #category : 'tests' }
MyQueenTest >> testMovesFromCenterOfEmptyBoard [

	| queen board |
	board := MyChessBoard empty.
	board at: 'd4' put: (queen := MyQueen white).
	self assert: queen targetSquares size equals: 27
]
