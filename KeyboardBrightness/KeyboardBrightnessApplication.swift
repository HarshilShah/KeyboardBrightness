//
//  KeyboardBrightnessApplication.swift
//  KeyboardBrightness
//
//  Created by Harshil Shah on 16/03/22.
//

import Cocoa

class KeyboardBrightnessApplication: NSApplication {
	
	override func sendEvent(_ event: NSEvent) {
		guard let key = Key(event: event) else {
			super.sendEvent(event)
			return
		}
		
		let extra = event.data1 & 0x0000FFFF
		let newData1 = Int(key.dual << 16) | extra
		
		guard
			let newEvent = NSEvent.otherEvent(
				with: event.type,
				location: event.locationInWindow,
				modifierFlags: event.modifierFlags.subtracting(Key.modifier),
				timestamp: event.timestamp,
				windowNumber: event.windowNumber,
				context: nil,
				subtype: event.subtype.rawValue,
				data1: newData1,
				data2: -1
			),
			let cgEvent = newEvent.cgEvent
			else { return }
		
		cgEvent.post(tap: .cghidEventTap)
	}
	
}
