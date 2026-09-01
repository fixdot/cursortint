//
//  main.swift
//  CursorTint
//
//  Created by fix on 2026/08/29.
//  Assisted by ChatGPT.
//  Copyright (c) 2026 fix
//  SPDX-License-Identifier: MIT
//

import AppKit

// Starts CursorTint using the AppKit application lifecycle.
MainActor.assumeIsolated {
	let appDelegate = AppDelegate()
	let application = NSApplication.shared

	application.delegate = appDelegate
	application.run()
}
