//
//  GeometryHelper.swift
//  FireBaseEx
//
//  Created by HAHA on 8/9/2021.
//

import SwiftUI

struct GeometryHelper{
    static func getScrollOffest(geometry: GeometryProxy) -> CGFloat{
        geometry.frame(in: .global).minY
    }
    
    static func getOffsetForHeaderImage(geometry: GeometryProxy) -> CGFloat{
        let offset = getScrollOffest(geometry: geometry)
        
        return offset > 0 ? -offset : 0
    }
    
    static func getHeightForHeaderImage(geometry: GeometryProxy) -> CGFloat{
        let offset = getScrollOffest(geometry: geometry)
        let imageHeight = geometry.size.height
        
        return offset > 0 ? (imageHeight + offset) : imageHeight
    }
}
