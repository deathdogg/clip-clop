//
//  CustomTempo.swift
//  clip-clop
//
//  Created by Ricardo Herrera on 2/2/24.
//

import SwiftUI

struct CustomTempo: View {
	@AppStorage("ts", store: .standard) private var ts: TimeSignatures?
	@State private var top = 4
	@State private var bottom = 4
	var body: some View {
		HStack {
			Picker("Number of Beats", selection: $top) {
				ForEach(1...12, id: \.self) {
					Text(String($0))
				}
			}
			Picker("Note Value", selection: $bottom) {
				Text(String(1))
					.tag(1)
				Text(String(2))
					.tag(2)
				Text(String(4))
					.tag(4)
				Text(String(8))
					.tag(8)
				Text(String(16))
					.tag(16)
				Text(String(32))
					.tag(32)
			}
		}
		.onChange(of: top) {
			ts = TimeSignatures(rawValue: "\(top)/\(bottom)")
		}
		.onChange(of: bottom) {
			ts = TimeSignatures(rawValue: "\(top)/\(bottom)")
		}
	}
}

#Preview {
	CustomTempo()
}
