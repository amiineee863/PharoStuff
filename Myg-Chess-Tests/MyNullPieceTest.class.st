Class {
	#name : 'MyNullPieceTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyNullPieceTest >> testEmptySquareHasNullPiece [
	| board square |
	board := MyChessBoard empty.
	square := board at: 'e4'.
	self deny: square hasPiece.
	self assert: square contents isEmpty
]

{ #category : 'tests' }
MyNullPieceTest >> testOccupiedSquareIsNotEmpty [
	| board square |
	board := MyChessBoard empty.
	board at: 'e2' put: MyPawn white.
	square := board at: 'e2'.
	self assert: square hasPiece.
	self deny: square contents isEmpty
]
