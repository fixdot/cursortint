//
//  TerminalTTYManager.swift
//  CursorTint
//
//  Created by fix on 2026/07/01.
//  Assisted by ChatGPT.
//  Copyright (c) 2026 fix
//  SPDX-License-Identifier: MIT
//

import Foundation

/// Discovers and caches active TTY sessions owned by the current user.
final class TerminalTTYManager {
	private var cachedPaths: [String] = []

	/// Returns the TTY connected to the current process.
	func currentTTYPath() -> String? {
		guard let name = ttyname(STDOUT_FILENO) else {
			return nil
		}

		return String(cString: name)
	}

	/// Refreshes the cached active `/dev/ttys*` paths reported by `who`.
	func refreshTTYPaths() {
		cachedPaths = discoverTTYPaths()
	}

	/// Returns cached active TTY paths, optionally excluding one path.
	func ttyPaths(excluding excludedPath: String? = nil) -> [String] {
		cachedPaths.filter { $0 != excludedPath }
	}

	/// Discovers active `/dev/ttys*` paths reported by `who`.
	private func discoverTTYPaths() -> [String] {
		let process = Process()
		let pipe = Pipe()

		process.executableURL = URL(fileURLWithPath: "/usr/bin/who")
		process.standardOutput = pipe

		do {
			try process.run()
		} catch {
			return []
		}

		process.waitUntilExit()

		let data = pipe.fileHandleForReading.readDataToEndOfFile()

		guard let output = String(data: data, encoding: .utf8) else {
			return []
		}

		let user = NSUserName()
		var paths = Set<String>()

		for line in output.split(separator: "\n") {
			let parts = line.split(separator: " ")

			guard parts.count >= 2 else {
				continue
			}

			let lineUser = String(parts[0])
			let tty = String(parts[1])
			let path = "/dev/\(tty)"

			if lineUser == user && tty.hasPrefix("ttys") {
				paths.insert(path)
			}
		}

		return Array(paths).sorted()
	}
}
