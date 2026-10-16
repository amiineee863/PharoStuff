Class {
	#name : 'MyChessSquareRenderTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyChessSquareRenderTest >> expectedGlyphs [

	"piece class -> { white on light square. white on dark square. black on light square. black on dark square }"
	^ {
		  (MyPawn -> #( 'P' 'p' 'O' 'o' )).
		  (MyRook -> #( 'R' 'r' 'T' 't' )).
		  (MyKnight -> #( 'N' 'n' 'M' 'm' )).
		  (MyBishop -> #( 'B' 'b' 'V' 'v' )).
		  (MyQueen -> #( 'Q' 'q' 'W' 'w' )).
		  (MyKing -> #( 'K' 'k' 'L' 'l' )) }
]

{ #category : 'tests' }
MyChessSquareRenderTest >> testAllGlyphs [

	| lightSquare darkSquare |
	lightSquare := MyChessSquare white.
	darkSquare := MyChessSquare black.
	self expectedGlyphs do: [ :assoc |
		| white black |
		white := assoc key white.
		black := assoc key black.
		self assert: (white renderPieceOn: lightSquare) equals: (assoc value at: 1).
		self assert: (white renderPieceOn: darkSquare) equals: (assoc value at: 2).
		self assert: (black renderPieceOn: lightSquare) equals: (assoc value at: 3).
		self assert: (black renderPieceOn: darkSquare) equals: (assoc value at: 4) ]
]
