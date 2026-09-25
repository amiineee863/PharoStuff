Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'testing' }
MyPawn >> isOnStartingRank [

	^ self isWhite
		ifTrue: [ square file = $2 ]
		ifFalse: [ square file = $7 ]
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [

	| oneStep twoStep forwardSquares captureSquares |
	oneStep := self isWhite
		ifTrue: [ square up ]
		ifFalse: [ square down ].

	forwardSquares := OrderedCollection new.
	(oneStep notNil and: [ oneStep hasPiece not ]) ifTrue: [
		forwardSquares add: oneStep.
		twoStep := self isWhite
			ifTrue: [ oneStep up ]
			ifFalse: [ oneStep down ].
		(self isOnStartingRank and: [
			twoStep notNil and: [ twoStep hasPiece not ] ])
			ifTrue: [ forwardSquares add: twoStep ] ].

	captureSquares := (self isWhite
		ifTrue: [ { square up ifNotNil: #left. square up ifNotNil: #right } ]
		ifFalse: [ { square down ifNotNil: #left. square down ifNotNil: #right } ])
		select: [ :s | s notNil and: [ s hasPiece and: [ s contents color ~= color ] ] ].

	^ forwardSquares , captureSquares
]
