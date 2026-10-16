"
I prioritize moves that capture an opponent's piece.
When no capture is available, I use the random strategy.
"
Class {
	#name : 'MyCaptureMoveStrategy',
	#superclass : 'MyRandomMoveStrategy',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyCaptureMoveStrategy >> chooseMoveFor: aPlayer [
    | captures |

    captures := OrderedCollection new.

    aPlayer pieces do: [ :piece |
        piece legalTargetSquares do: [ :square |
            (square hasPiece and: [
                square contents color ~= piece color ])
                ifTrue: [
                    captures add: { piece. square } ]
        ]
    ].

    captures ifNotEmpty: [
        ^ captures atRandom ].

    ^ super chooseMoveFor: aPlayer
]
