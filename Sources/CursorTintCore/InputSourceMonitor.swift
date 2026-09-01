//
//  InputSourceMonitor.swift
//  CursorTint
//
//  Created by fix on 2026/07/01.
//  Assisted by ChatGPT.
//  Copyright (c) 2026 fix
//  SPDX-License-Identifier: MIT
//

import Foundation
import Carbon

/// Observes macOS input-source changes without polling.
final class InputSourceMonitor {
	private var observer: NSObjectProtocol?

	/// Returns the identifier of the currently selected input source.
	func currentInputSourceID() -> String {
		guard
			let source = TISCopyCurrentKeyboardInputSource()?
				.takeRetainedValue(),
			let value = TISGetInputSourceProperty(
				source,
				kTISPropertyInputSourceID
			)
		else {
			return ""
		}

		return Unmanaged<CFString>
			.fromOpaque(value)
			.takeUnretainedValue() as String
	}

	/// Returns whether CursorTint should highlight the cursor for the current input source.
	func shouldHighlightCursor() -> Bool {
		currentInputSourceID() != "com.apple.keylayout.US"
	}

	/// Starts observing input-source changes on the main queue.
	func start(onChange: @escaping @Sendable () -> Void) {
		guard observer == nil else {
			return
		}

		let name = Notification.Name(
			kTISNotifySelectedKeyboardInputSourceChanged as String
		)

		observer = DistributedNotificationCenter.default().addObserver(
			forName: name,
			object: nil,
			queue: .main
		) { _ in
			onChange()
		}
	}

	/// Stops observing input-source changes.
	func stop() {
		guard let observer else {
			return
		}

		DistributedNotificationCenter.default()
			.removeObserver(observer)

		self.observer = nil
	}

	deinit {
		stop()
	}
}
