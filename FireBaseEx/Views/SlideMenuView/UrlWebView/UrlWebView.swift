//
//  UrlWebView.swift
//  FireBaseEx
//
//  Created by HAHA on 27/8/2021.
//

import Foundation
import SwiftUI
import WebKit

struct UrlWebView: UIViewRepresentable{
    
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView{
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: urlString) else{return}
        uiView.load(URLRequest(url: url))
    }
}
