import SwiftUI
import Combine
struct TempoSelectionView: View {
	@AppStorage("tempo") private var tempo: Double = 120
	@Binding var isPlaying: Bool
	var body: some View {
		Picker("Tempo", selection: $tempo) {
			ForEach(66...200, id: \.self) {
				Text(String($0))
					.tag(Double($0))
			}
		}
		.pickerStyle(.wheel)
		.onChange(of: tempo, initial: true) {
			TempoCalculation.calculateInterval(isPlaying)
		}
	}
}

