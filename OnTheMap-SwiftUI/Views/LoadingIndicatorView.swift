//
//  LoadingIndicatorView.swift
//  OnTheMap-SwiftUI
//
//  Created by Stanley Darmawan on 27/5/2024.
//

import SwiftUI

struct LoadingIndicatorView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .scaleEffect(1.5)  // Optional: Adjust the size
            .padding()
    }
}

struct LoadingIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicatorView()
    }
}
