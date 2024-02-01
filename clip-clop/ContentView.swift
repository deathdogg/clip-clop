import SwiftUI
import Combine
struct ContentView: View {
	@State private var isPlaying = false
	var body: some View {
		VStack {
			HStack {
				TimeSignatureSelectionView(isPlaying: $isPlaying)
				TempoSelectionView(isPlaying: $isPlaying)
			}
			Button(isPlaying ? "Pause" : "Play") {
				isPlaying.toggle()
				if !isPlaying {
					TempoCalculation.mainTimer.cancel()
				} else {
					TempoCalculation.currentBeat = 1
					TempoCalculation.calculateInterval(isPlaying)
				}
			}
		}
		.onAppear {
			if !isPlaying {
				TempoCalculation.mainTimer.cancel()
			}
		}

	}
}

