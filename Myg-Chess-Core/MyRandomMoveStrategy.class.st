"
I select a random legal move for a chess player.
I am the default move selection strategy.
"
Class {
	#name : 'MyRandomMoveStrategy',
	#superclass : 'Object',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'move selection' }
MyRandomMoveStrategy >> chooseMoveFor: aPlayer [
    | pieces |

    pieces := aPlayer king isInCheck
        ifTrue: [ OrderedCollection with: aPlayer king ]
        ifFalse: [ aPlayer pieces copy asOrderedCollection ].

    [ pieces notEmpty ] whileTrue: [
        | piece legalMoves |
        piece := pieces atRandom.
        pieces remove: piece.
        legalMoves := piece legalTargetSquares.

        legalMoves ifNotEmpty: [
            ^ { piece. legalMoves atRandom } ]
    ].

    ^ nil
]

{ #category : 'playing' }
MyRandomMoveStrategy >> playFor: aPlayer [
    | move |

    move := self chooseMoveFor: aPlayer.

    move ifNil: [
        self error: 'NO MOVES AVAILABLE!' ].

    aPlayer game
        move: move first
        to: move second
]
