Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTest >> testBlackEnPassantCapture [

	| board white black |
	board := MyChessBoard empty.
	board at: 'e4' put: (black := MyPawn black).
	board at: 'd2' put: (white := MyPawn white).
	white moveTo: (board at: 'd4').
	self assert: (black legalTargetSquares includes: (board at: 'd3')).
	black moveTo: (board at: 'd3').
	self assert: (board at: 'd3') contents equals: black.
	self deny: (board at: 'd4') hasPiece
]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnMovesDown [

	| pawn board |
	board := MyChessBoard empty.
	board at: 'e7' put: (pawn := MyPawn black).
	self
		assertCollection: pawn targetSquares
		hasSameElements: (#( e6 e5 ) collect: [ :name | board at: name ])
]

{ #category : 'tests' }
MyPawnTest >> testBlockedPawnCannotMove [

	| pawn board |
	board := MyChessBoard empty.
	board at: 'e2' put: (pawn := MyPawn white).
	board at: 'e3' put: MyKnight black.
	self assert: pawn targetSquares isEmpty
]

{ #category : 'tests' }
MyPawnTest >> testCannotCaptureStraightAhead [
	| pawn squares board |
	board := MyChessBoard empty.
	board at: 'e2' put: (pawn := MyPawn white).
	board at: 'e3' put: MyPawn black.
	squares := pawn targetSquares.
	self assert: (squares includes: (board at: 'e3')) not
]

{ #category : 'tests' }
MyPawnTest >> testDiagonalCapture [
	| pawn squares board |
	board := MyChessBoard empty.
	board at: 'e4' put: (pawn := MyPawn white).
	board at: 'd5' put: MyPawn black.
	squares := pawn targetSquares.
	self assert: (squares includes: (board at: 'd5'))
]

{ #category : 'tests' }
MyPawnTest >> testDoubleStepSetsEnPassantTarget [

	| board |
	board := MyChessBoard empty.
	board at: 'd7' put: MyPawn black.
	(board at: 'd7') contents moveTo: (board at: 'd5').
	self assert: board enPassantTargetSquare equals: (board at: 'd6')
]

{ #category : 'tests' }
MyPawnTest >> testEnPassantExpiresAfterAnotherMove [

	| board white black rook |
	board := MyChessBoard empty.
	board at: 'e5' put: (white := MyPawn white).
	board at: 'd7' put: (black := MyPawn black).
	board at: 'h1' put: (rook := MyRook white).
	black moveTo: (board at: 'd5').
	rook moveTo: (board at: 'h2').
	self deny: (white legalTargetSquares includes: (board at: 'd6'))
]

{ #category : 'tests' }
MyPawnTest >> testMoveToUpdatesBoard [

	| pawn board |
	board := MyChessBoard empty.
	board at: 'e2' put: (pawn := MyPawn white).
	pawn moveTo: (board at: 'e4').
	self deny: (board at: 'e2') hasPiece.
	self assert: (board at: 'e4') contents equals: pawn
]

{ #category : 'tests' }
MyPawnTest >> testNoEnPassantAfterTwoSingleSteps [

	| board white black |
	board := MyChessBoard empty.
	board at: 'e5' put: (white := MyPawn white).
	board at: 'd7' put: (black := MyPawn black).
	black moveTo: (board at: 'd6').
	black moveTo: (board at: 'd5').
	self deny: (white legalTargetSquares includes: (board at: 'd6'))
]

{ #category : 'tests' }
MyPawnTest >> testPawnAttacksEmptyDiagonals [

	| pawn board |
	board := MyChessBoard empty.
	board at: 'e4' put: (pawn := MyPawn white).
	self
		assertCollection: pawn attackingSquares
		hasSameElements: (#( d5 f5 ) collect: [ :name | board at: name ])
]

{ #category : 'tests' }
MyPawnTest >> testPawnOffStartingRankMovesOneSquare [

	| pawn board |
	board := MyChessBoard empty.
	board at: 'e4' put: (pawn := MyPawn white).
	self
		assertCollection: pawn targetSquares
		hasSameElements: { (board at: 'e5') }
]

{ #category : 'tests' }
MyPawnTest >> testSingleStepDoesNotSetEnPassantTarget [

	| board |
	board := MyChessBoard empty.
	board at: 'd7' put: MyPawn black.
	(board at: 'd7') contents moveTo: (board at: 'd6').
	self assert: board enPassantTargetSquare isNil
]

{ #category : 'tests' }
MyPawnTest >> testStartMovesTwoSquares [
	| pawn squares board |
	board := MyChessBoard empty.
	board at: 'e2' put: (pawn := MyPawn white).
	squares := pawn targetSquares.
	self assertCollection: squares includesAll: (#(e3 e4) collect: [ :name | board at: name ])

]

{ #category : 'tests' }
MyPawnTest >> testWhiteEnPassantCapture [

	| board white black |
	board := MyChessBoard empty.
	board at: 'e5' put: (white := MyPawn white).
	board at: 'd7' put: (black := MyPawn black).
	black moveTo: (board at: 'd5').
	self assert: (white legalTargetSquares includes: (board at: 'd6')).
	white moveTo: (board at: 'd6').
	self assert: (board at: 'd6') contents equals: white.
	self deny: (board at: 'd5') hasPiece.
	self deny: (board at: 'e5') hasPiece
]
