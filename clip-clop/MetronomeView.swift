import Foundation
import SwiftUI

struct TimeSignatureSelectionView: View {
	@Binding var isPlaying: Bool
	@AppStorage("ts", store: .standard) private var ts: TimeSignatures = .common
	var body: some View {
		VStack {
			Picker("Time Sig", selection: $ts) {
				ForEach(TimeSignatures.allCases, id: \.rawValue) {
					sig in
					Text(sig.rawValue)
						.tag(sig)
				}
			}
			.onChange(of: ts, initial: true) {
				TempoCalculation.calculateInterval(isPlaying)
			}
		}
	}
}

