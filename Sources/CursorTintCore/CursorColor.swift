//
//  CursorColor.swift
//  CursorTint
//
//  Created by fix on 2026/07/01.
//  Assisted by ChatGPT.
//  Copyright (c) 2026 fix
//  SPDX-License-Identifier: MIT
//

/// OSC sequences used to control the Terminal.app cursor color.
enum CursorColor {

	/// Highlight cursor color used for non-U.S. input sources.
	static let highlight = "\u{001B}]12;#EB5F5F\u{0007}"

	/// Restores the cursor color defined by the current Terminal profile.
	static let resetToDefault = "\u{001B}]112\u{0007}"
}
