Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
MyPawn class >> glyphTable [

	^ #( #( 'P' 'p' ) #( 'O' 'o' ) )
]

{ #category : 'path commands' }
MyPawn >> attackingSquares [

	"A pawn attacks its two forward diagonals, whether they are occupied or not"
	| forward |
	forward := self forwardFrom: square.
	forward ifNil: [ ^ #(  ) ].
	^ { forward left. forward right } reject: [ :s | s isNil ]
]

{ #category : 'path commands' }
MyPawn >> backwardFrom: aSquare [

	^ self isWhite
		  ifTrue: [ aSquare down ]
		  ifFalse: [ aSquare up ]
]

{ #category : 'path commands' }
MyPawn >> forwardFrom: aSquare [

	^ self isWhite
		  ifTrue: [ aSquare up ]
		  ifFalse: [ aSquare down ]
]

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'testing' }
MyPawn >> isEnPassantTarget: aSquare [

	"True if aSquare is the square just skipped by an opponent pawn that advanced two squares"
	| passedPawn |
	aSquare = self board enPassantTargetSquare ifFalse: [ ^ false ].
	passedPawn := (self backwardFrom: aSquare) contents.
	^ passedPawn isEmpty not and: [ passedPawn color ~= color ]
]

{ #category : 'testing' }
MyPawn >> isOnStartingRank [

	^ self isWhite
		ifTrue: [ square file = $2 ]
		ifFalse: [ square file = $7 ]
]

{ #category : 'path commands' }
MyPawn >> moveTo: aSquare [

	| aBoard origin skipped isEnPassantCapture isDoubleStep |
	(self legalTargetSquares includes: aSquare) ifFalse: [ ^ self ].

	aBoard := self board.
	origin := square.
	skipped := self forwardFrom: origin.
	isEnPassantCapture := self isEnPassantTarget: aSquare.
	isDoubleStep := skipped notNil and: [
						aSquare = (self forwardFrom: skipped) ].

	"Moves the pawn and ends any previous en passant opportunity"
	super moveTo: aSquare.

	"The captured pawn is behind the destination square, not on it"
	isEnPassantCapture ifTrue: [
		(self backwardFrom: aSquare) emptyContents ].

	"A two-square advance gives the opponent one chance to capture en passant"
	isDoubleStep ifTrue: [ aBoard enPassantTargetSquare: skipped ]
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [

	| oneStep twoStep forwardSquares captureSquares |
	oneStep := self forwardFrom: square.

	forwardSquares := OrderedCollection new.
	(oneStep notNil and: [ oneStep hasPiece not ]) ifTrue: [
		forwardSquares add: oneStep.
		twoStep := self forwardFrom: oneStep.
		(self isOnStartingRank and: [
			 twoStep notNil and: [ twoStep hasPiece not ] ])
			ifTrue: [ forwardSquares add: twoStep ] ].

	captureSquares := self attackingSquares select: [ :s |
		(s hasPiece and: [ s contents color ~= color ])
			or: [ self isEnPassantTarget: s ] ].

	^ forwardSquares , captureSquares
]
