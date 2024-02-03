import Foundation
import SwiftUI
import AVFoundation
struct TempoCalculation {
	static var clickPool: [AVAudioPlayer] = []
	static var highClickPool: [AVAudioPlayer] = []

	static var currentBeat: Int = 1
	@AppStorage("tempo") static var tempo: Double?
	@AppStorage("ts", store: .standard) static var ts: TimeSignatures?
	static var mainTimer = Timer.publish(every: Self.tempo ?? 120, on: .main, in: .common)
		.autoconnect()
		.sink {
			_ in
//			Self.playClick()
		}
	static func calculateInterval(_ isPlaying: Bool) -> TimeInterval {

		let seconds = 60.0
		var result: Double = seconds/(tempo ?? 120)
		result *= 4
		result /= Double(Self.ts?.getInfo().1 ?? 4)
		Self.mainTimer.cancel()
		Self.mainTimer = Timer.publish(every: result, tolerance: 0.02, on: .main, in: .common)
			.autoconnect()
			.sink {
				_ in
				Task(priority: .utility) {
					Self.playClick(isPlaying)
				}
			}
		return result
	}
	static func playClick(_ isPlaying: Bool) {
		if ts != nil && ts == .custom {
			return
		}
		if !isPlaying {
			Self.mainTimer.cancel()
			return
		}
		if Self.currentBeat > ts?.getInfo().0 ?? 4 {
			Self.currentBeat = 1
		}
		if Self.currentBeat == 1 {
			Self.currentBeat += 1
			var highClick: AVAudioPlayer?
			if Self.highClickPool.contains(where: {
				h in
				if !h.isPlaying {
					highClick = h
					return true
				}
				return false
			}) {
				highClick?.play()
				return
			}
			let url: URL! = Bundle.main.url(forResource: "Blop_High", withExtension: "mp3")
			let newPlayer: AVAudioPlayer! = try? AVAudioPlayer(contentsOf: url)
			Self.highClickPool.append(newPlayer)
			newPlayer?.play()
			return
		}
		Self.currentBeat += 1
		var existingPlayer: AVAudioPlayer?
		if Self.clickPool.contains(where: { p in
			if !p.isPlaying {
				existingPlayer = p
				return true
			}
			return false
		}) {
			existingPlayer?.play()
			return
		}
		let url = Bundle.main.url(forResource: "Blop", withExtension: "mp3")
		guard let url = url else {
			print("Invalid URL")
			return
		}
		guard let player = try? AVAudioPlayer(contentsOf: url) else {
			return
		}
		Self.clickPool.append(player)
		player.play()

	}
}
