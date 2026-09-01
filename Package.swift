// swift-tools-version: 6.3
//
//  Package.swift
//  CursorTint
//
//  Created by fix on 2026/08/01.
//  Assisted by ChatGPT.
//  Copyright (c) 2026 fix
//  SPDX-License-Identifier: MIT
//

import PackageDescription

/// Defines the shared CursorTint core library and its tests.
let package = Package(
	name: "CursorTintCore",
	platforms: [
		.macOS(.v12)
	],
	products: [
		.library(
			name: "CursorTintCore",
			targets: ["CursorTintCore"]
		),
	],
	targets: [
		.target(
			name: "CursorTintCore"
		),
		.testTarget(
			name: "CursorTintCoreTests",
			dependencies: ["CursorTintCore"]
		),
	],
	swiftLanguageModes: [.v6]
)
