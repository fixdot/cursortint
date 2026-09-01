//
//  TerminalSessionMonitor.swift
//  CursorTint
//
//  Created by fix on 2026/08/08.
//  Assisted by ChatGPT.
//  Copyright (c) 2026 fix
//  SPDX-License-Identifier: MIT
//

import Foundation
import Darwin

/// Detects Terminal session changes without polling.
///
/// macOS updates `/var/run/utmpx` when TTY sessions are created or removed.
final class TerminalSessionMonitor {
	private static let utmpxPath = "/var/run/utmpx"

	private var source: DispatchSourceFileSystemObject?

	/// Starts monitoring the macOS user-accounting database.
	func start(onChange: @escaping @Sendable () -> Void) {
		guard source == nil else {
			return
		}

		let fileDescriptor = open(
			Self.utmpxPath,
			O_EVTONLY
		)

		guard fileDescriptor >= 0 else {
			print("Failed to monitor \(Self.utmpxPath)")
			return
		}

		let source = DispatchSource.makeFileSystemObjectSource(
			fileDescriptor: fileDescriptor,
			eventMask: [.write],
			queue: .main
		)

		source.setEventHandler {
			onChange()
		}

		source.setCancelHandler {
			close(fileDescriptor)
		}

		self.source = source
		source.resume()
	}

	/// Stops monitoring and releases the file descriptor.
	func stop() {
		source?.cancel()
		source = nil
	}

	deinit {
		stop()
	}
}
