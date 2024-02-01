//
//  TimeSig.swift
//  clip-clop
//
//  Created by Ricardo Herrera on 1/28/24.
//

import Foundation
enum TimeSignatures: String, Hashable, CaseIterable, Codable {
	typealias TimeSignature = (Int, Int)
	case common = "4/4"
	case twoFour = "2/4"
	case threeFour = "3/4"
	case fiveFour = "5/4"
	case sixEight = "6/8"
	case sevenEight = "7/8"
	case nineEight = "9/8"
	case custom
	func getInfo() -> TimeSignature {
		let numbers = self.rawValue.split(separator: "/")
		var result: TimeSignature
		result.0 = Int(String(numbers[0]))!
		result.1 = Int(String(numbers[1]))!
		return result
	}
}
struct Measure: Hashable {
	let beats: Int
	let subdivisions = 0
}
