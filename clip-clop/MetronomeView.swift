import Foundation
import SwiftUI

struct TimeSignatureSelectionView: View {
	@Binding var isPlaying: Bool
	@AppStorage("ts", store: .standard) private var ts: TimeSignatures = .common
	@State private var tsState: TimeSignatures = .common
	var body: some View {
		VStack {
			Picker("Time Sig", selection: $tsState) {
				ForEach(TimeSignatures.allCases, id: \.rawValue) {
					sig in
					Text(sig.rawValue)
						.tag(sig)
				}
			}
			.onChange(of: tsState, initial: true) {
				if tsState != .custom {
					ts = tsState
				}
			}
			.onChange(of: ts, initial: true) {
				TempoCalculation.calculateInterval(isPlaying)
			}
			if tsState == .custom {
				CustomTempo()
			}
		}
	}
}

