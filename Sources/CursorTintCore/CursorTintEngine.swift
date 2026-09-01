//
//  CursorTintEngine.swift
//  CursorTint
//
//  Created by fix on 2026/07/01.
//  Assisted by ChatGPT.
//  Copyright (c) 2026 fix
//  SPDX-License-Identifier: MIT
//

/// Coordinates input-source monitoring and Terminal cursor updates.
///
/// Monitor callbacks are delivered on the main queue, keeping state changes
/// serialized.
public final class CursorTintEngine: @unchecked Sendable {
	public init() {}

	private let inputSourceMonitor = InputSourceMonitor()
	private let cursorController = CursorController()
	private let terminalSessionMonitor = TerminalSessionMonitor()

	/// Starts monitoring and immediately applies the current input-source color.
	public func start() {
		cursorController.refreshTTYPaths()

		inputSourceMonitor.start { [weak self] in
			self?.applyCurrentInputSource()
		}

		terminalSessionMonitor.start { [weak self] in
			guard let self else {
				return
			}

			self.cursorController.refreshTTYPaths()
			self.applyCurrentInputSource()
		}

		applyCurrentInputSource()
	}

	/// Applies the color associated with the current input source.
	func applyCurrentInputSource() {
		if inputSourceMonitor.shouldHighlightCursor() {
			cursorController.broadcast(CursorColor.highlight)
		} else {
			cursorController.broadcast(
				CursorColor.resetToDefault
			)
		}
	}

	/// Restores the Terminal profile's default cursor color on all TTYs.
	func resetAllCursors() {
		cursorController.broadcast(
			CursorColor.resetToDefault,
			includeCurrentTTY: true
		)
	}

	/// Stops monitoring and restores the default cursor color.
	public func stop() {
		inputSourceMonitor.stop()
		terminalSessionMonitor.stop()
		resetAllCursors()
	}
}
