//
//  MyWebView.swift
//  HealthReport
//
//  Created by 劉紘任 on 2020/3/24.
//  Copyright © 2020 劉紘任. All rights reserved.
//

import WebKit

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
