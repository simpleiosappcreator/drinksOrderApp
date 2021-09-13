//
//  ShowFullImageSheetView.swift
//  DrinksOrderApp
//
//  Created by HAHA on 3/8/2021.
//

import SwiftUI

struct ShowFullImageSheetView: View {
    @EnvironmentObject var drinkImageVM: DrinkImageViewModel
    @Binding var showFullImage: Bool
    
    @State var scale: CGFloat = 1.0
    @State var currentScale: CGFloat = 0
    @State var previousScale: CGFloat = 0
    @State var isTapped: Bool = false
    @State var pointTapped: CGPoint = CGPoint.zero
    @State var draggedSize: CGSize = CGSize.zero
    @State var previousDragged: CGSize = CGSize.zero
    
    let color = Color.theme
    
    var body: some View {
        ZStack{
            color.background.ignoresSafeArea()
            VStack{
                ZStack {
                    HStack{
                        Spacer()
                        
                        Button(action: {
                            showFullImage = false
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                                .frame(width: 10, height: 10)
                                .padding()
                                .background(Color.gray.opacity(0.5))
                                .clipShape(Circle())
                        })
                        .padding()
                    }
                }
                .zIndex(1.0)
                
                if drinkImageVM.isLoading{
                    ProgressView()
                }else if let image = drinkImageVM.image{
                    GeometryReader{ geometry in
                        Image(uiImage: image)
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .frame(maxHeight: .infinity)
                            .scaledToFit()
                            .animation(.default)
                            .offset(x: draggedSize.width, y: draggedSize.height)
                            .scaleEffect(self.scale + currentScale + previousScale)
                            .scaleEffect(self.isTapped ? 2 : 1, anchor: UnitPoint(x: pointTapped.x / geometry.frame(in: .global).maxX, y: pointTapped.y / geometry.frame(in: .global).maxY))
                            .gesture(
                                TapGesture(count: 2)
                                    .onEnded({ () in
                                        isTapped = !isTapped
                                    })
                                    .simultaneously(with: DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                                        .onChanged({ value in
                                                            pointTapped = value.startLocation
                                                            draggedSize = CGSize(width: value.translation.width + previousDragged.width, height: value.translation.height + previousDragged.height)
                                                        })
                                                        .onEnded({ value in
//                                                            let offsetWidth = (geometry.frame(in: .global).maxX * (self.scale + currentScale + previousScale) - geometry.frame(in: .global).maxX / 2)
//                                                            let newDraggedWidth = draggedSize.width * (self.scale + currentScale + previousScale)
//                                                            if newDraggedWidth > offsetWidth{
//                                                                draggedSize = CGSize(width: offsetWidth / (self.scale + currentScale + previousScale), height: value.translation.height + previousDragged.height)
//                                                            }else if newDraggedWidth < -offsetWidth{
//                                                                draggedSize = CGSize(width: -offsetWidth / (self.scale + currentScale + previousScale), height: value.translation.height + previousDragged.height)
//                                                            }else{
//                                                                draggedSize = CGSize(width: value.translation.width + previousDragged.width, height: value.translation.height + previousDragged.height)
//                                                            }
                                                            previousDragged = draggedSize
                                                        })
                                    )
                            )
                            .gesture(
                                MagnificationGesture()
                                    .onChanged({ scale in
                                        currentScale = scale - 1
                                    })
                                    .onEnded({ scaleFinal in
                                        previousScale += currentScale
                                        currentScale = 0
                                    })
                            )
                    }
                
                Spacer()
            }
        }
    }
}
}

struct ShowFullImageSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ShowFullImageSheetView(showFullImage: .constant(false))
    }
}
