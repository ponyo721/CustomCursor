//
//  SubViewCommonEnum.swift
//  CustomCursor
//
//  Created by 박병호 on 5/24/24.
//

import Foundation

let DEFAULT_RING_LINE_WIDTH : CGFloat = 7
let MAX_RING_LINE_WIDTH : CGFloat = 10
let MIN_RING_LINE_WIDTH : CGFloat = 1

let DEFAULT_RING_LINE_ALPHA : CGFloat = 0.3
let MAX_RING_LINE_ALPHA : CGFloat = 1
let MIN_RING_LINE_ALPHA : CGFloat = 0.1

enum CYCLE_RING_RADIUS : CGFloat, Codable {
    case LARGE = 2
    case MIDDLE = 3
    case SMALL = 4
}

enum CYCLE_RING_ANIMATION_STATE : Codable {
    case NONE
    case START
    case STOP
}
