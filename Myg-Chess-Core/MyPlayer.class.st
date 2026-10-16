Class {
	#name : 'MyPlayer',
	#superclass : 'Object',
	#instVars : [
		'color',
		'game',
		'moveStrategy'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'constants' }
MyPlayer >> black [

	self color: Color black
]

{ #category : 'accessing' }
MyPlayer >> color [

	^ color
]

{ #category : 'accessing' }
MyPlayer >> color: anObject [

	color := anObject
]

{ #category : 'accessing' }
MyPlayer >> game [

	^ game
]

{ #category : 'accessing' }
MyPlayer >> game: anObject [

	game := anObject
]

{ #category : 'testing' }
MyPlayer >> isWhite [
	
	^ color = Color white
]

{ #category : 'accessing' }
MyPlayer >> king [
	
	^ self pieces detect: [ :p | p isKing ]
]

{ #category : 'accessing' }
MyPlayer >> moveStrategy [
    ^ moveStrategy ifNil: [
        moveStrategy := MyRandomMoveStrategy new ]
]

{ #category : 'accessing' }
MyPlayer >> moveStrategy: aStrategy [
    moveStrategy := aStrategy
]

{ #category : 'accessing' }
MyPlayer >> pieces [

	^ game pieces select: [ :p | p isEmpty not and: [ p color = self color ] ]
]

{ #category : 'playing' }
MyPlayer >> play [
    self moveStrategy playFor: self
]

{ #category : 'constants' }
MyPlayer >> white [

	self color: Color white
]
