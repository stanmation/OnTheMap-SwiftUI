//
//  ListDisplayView.swift
//  OnTheMap-SwiftUI
//
//  Created by Stanley Darmawan on 7/5/2024.
//

import SwiftUI

struct ListDisplayView: View {
  @EnvironmentObject private var viewModel: StudentLocationViewModel
    
  var body: some View {
    List {
      ForEach($viewModel.students) { $student in
        ItemRow(student: $student)
      }
    }
  }
}

struct ItemRow: View {
  @Binding var student: Student
  
  var body: some View {
    HStack {
      Image(systemName: "mappin.and.ellipse")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 30, height: 30)

      Text(student.firstName + " " + student.lastName)
    }
  }
}

#Preview {
  ListDisplayView()
}

