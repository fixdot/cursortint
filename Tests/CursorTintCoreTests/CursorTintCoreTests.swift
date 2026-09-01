//
//  CursorTintCoreTests.swift
//  CursorTint
//
//  Created by fix on 2026/07/01.
//  Assisted by ChatGPT.
//  Copyright (c) 2026 fix
//  SPDX-License-Identifier: MIT
//

import Testing
@testable import CursorTintCore

// Verifies the OSC sequences used to change and restore the cursor color.
@Test func highlightColor() {
	#expect(
		CursorColor.highlight
			== "\u{001B}]12;#EB5F5F\u{0007}"
	)
}

@Test func resetToDefaultColor() {
	#expect(
		CursorColor.resetToDefault
			== "\u{001B}]112\u{0007}"
	)
}
