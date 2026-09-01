//
//  CursorController.swift
//  CursorTint
//
//  Created by fix on 2026/07/01.
//  Assisted by ChatGPT.
//  Copyright (c) 2026 fix
//  SPDX-License-Identifier: MIT
//

import Darwin

/// Sends cursor-color OSC sequences to detected Terminal TTYs.
final class CursorController {
	private let ttyManager = TerminalTTYManager()

	/// Refreshes the cached Terminal TTY list.
	func refreshTTYPaths() {
		ttyManager.refreshTTYPaths()
	}

	/// Broadcasts an OSC sequence to all target TTYs.
	///
	/// The current process's own TTY is excluded unless `includeCurrentTTY` is enabled.
	func broadcast(
		_ sequence: String,
		includeCurrentTTY: Bool = false,
		retry: Bool = true
	) {
		let excludedPath = includeCurrentTTY
			? nil
			: ttyManager.currentTTYPath()

		var failed = false

		for path in ttyManager.ttyPaths(excluding: excludedPath) {
			if !write(sequence, toTTY: path) {
				failed = true
			}
		}

		// Refresh the TTY cache and retry once if a session changed during the broadcast.
		if failed && retry {
			ttyManager.refreshTTYPaths()

			broadcast(
				sequence,
				includeCurrentTTY: includeCurrentTTY,
				retry: false
			)
		}
	}

	/// Writes one OSC sequence directly to a TTY device.
	private func write(_ sequence: String, toTTY path: String) -> Bool {
		let fd = open(path, O_WRONLY | O_NOCTTY)

		guard fd >= 0 else {
			return false
		}

		let bytes = Array(sequence.utf8)

		let written = bytes.withUnsafeBytes { buffer -> Int in
			guard let baseAddress = buffer.baseAddress else {
				return -1
			}

			return Darwin.write(fd, baseAddress, bytes.count)
		}

		close(fd)

		return written == bytes.count
	}
}
