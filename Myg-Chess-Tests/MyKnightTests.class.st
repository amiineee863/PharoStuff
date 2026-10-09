Class {
	#name : 'MyKnightTests',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyKnightTests >> testId [

	self assert: MyKnight new id equals: 'N'
]

{ #category : 'tests' }
MyKnightTests >> testMovesFromCenter [

	| knight board |
	board := MyChessBoard empty.
	board at: 'e4' put: (knight := MyKnight white).
	self
		assertCollection: knight targetSquares
		hasSameElements:
			(#( f6 d6 g5 c5 g3 c3 f2 d2 ) collect: [ :name | board at: name ])
]

{ #category : 'tests' }
MyKnightTests >> testMovesFromCorner [

	| knight board |
	board := MyChessBoard empty.
	board at: 'a1' put: (knight := MyKnight white).
	self
		assertCollection: knight targetSquares
		hasSameElements: (#( b3 c2 ) collect: [ :name | board at: name ])
]

{ #category : 'tests' }
MyKnightTests >> testCannotCaptureSameColor [

	| knight board |
	board := MyChessBoard empty.
	board at: 'e4' put: (knight := MyKnight white).
	board at: 'f6' put: MyPawn white.
	self deny: (knight targetSquares includes: (board at: 'f6'))
]

{ #category : 'tests' }
MyKnightTests >> testCanCaptureOpponent [

	| knight board |
	board := MyChessBoard empty.
	board at: 'e4' put: (knight := MyKnight white).
	board at: 'f6' put: MyPawn black.
	self assert: (knight targetSquares includes: (board at: 'f6'))
]
