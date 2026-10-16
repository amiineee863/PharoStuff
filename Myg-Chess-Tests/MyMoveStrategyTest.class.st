Class {
	#name : 'MyMoveStrategyTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyMoveStrategyTest >> testCanChangeStrategy [
    | player strategy |

    player := MyPlayer new.
    strategy := MyCaptureMoveStrategy new.

    player moveStrategy: strategy.

    self assert: player moveStrategy identicalTo: strategy
]

{ #category : 'tests' }
MyMoveStrategyTest >> testCaptureStrategyPrioritizesCapture [
    | board game player pawn move |

    board := MyChessBoard empty.
    pawn := MyPawn white.

    board at: 'e4' put: pawn.
    board at: 'e1' put: MyKing white.
    board at: 'd5' put: MyPawn black.

    game := MyChessGame basicNew.
    game instVarNamed: 'board' put: board.

    player := MyPlayer new white game: game.

    move := MyCaptureMoveStrategy new
        chooseMoveFor: player.

    self assert: move first identicalTo: pawn.
    self assert: move second identicalTo: (board at: 'd5')
]

{ #category : 'tests' }
MyMoveStrategyTest >> testDefaultStrategy [
    | player |

    player := MyPlayer new.

    self assert:
        (player moveStrategy isKindOf: MyRandomMoveStrategy)
]

{ #category : 'tests' }
MyMoveStrategyTest >> testRandomStrategyChoosesLegalMove [
    | board game player pawn move |

    board := MyChessBoard empty.
    pawn := MyPawn white.
    board at: 'e2' put: pawn.
    board at: 'e1' put: MyKing white.

    game := MyChessGame basicNew.
    game instVarNamed: 'board' put: board.

    player := MyPlayer new white game: game.

    move := MyRandomMoveStrategy new
        chooseMoveFor: player.

    self assert: move first identicalTo: pawn.
    self assert: (pawn legalTargetSquares includes: move second)
]
