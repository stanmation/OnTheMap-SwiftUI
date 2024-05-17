//
//  MapDisplayView.swift
//  OnTheMap-SwiftUI
//
//  Created by Stanley Darmawan on 6/5/2024.
//

import SwiftUI
import MapKit

struct MapDisplayView: View {
  @EnvironmentObject private var viewModel: StudentLocationViewModel
  @State private var position: MapCameraPosition = .automatic
  @State private var selectedId: String?
  
  var body: some View {
    VStack {
      Map(position: $position, selection: $selectedId) {
        ForEach($viewModel.markerModels) { $marker in
          Marker(marker.title, coordinate: marker.location)
            .tint(.red)
        }
      }
    }
  }
}

#Preview {
  MapDisplayView()
}
