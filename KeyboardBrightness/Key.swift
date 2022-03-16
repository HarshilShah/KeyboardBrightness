//
//  Key.swift
//  KeyboardBrightness
//
//  Created by Harshil Shah on 16/03/22.
//

import Cocoa

enum Key {
	case brightnessDown
	case brightnessUp
	
	static let modifier = NSEvent.ModifierFlags.command
	
	init?(event: NSEvent) {
		guard event.type == .systemDefined, event.modifierFlags.contains(Key.modifier) else {
			return nil
		}
		
		let keyCode = Int32((event.data1 & 0xFFFF0000) >> 16)
		
		switch keyCode {
		case NX_KEYTYPE_BRIGHTNESS_DOWN: self = .brightnessDown
		case NX_KEYTYPE_BRIGHTNESS_UP: self = .brightnessUp
		default: return nil
		}
	}
	
	var dual: Int32 {
		switch self {
		case .brightnessDown: return NX_KEYTYPE_ILLUMINATION_DOWN
		case .brightnessUp: return NX_KEYTYPE_ILLUMINATION_UP
		}
	}
}
