//
//  AppDelegate.swift
//  CursorTint
//
//  Created by fix on 2026/08/08.
//  Assisted by ChatGPT.
//  Copyright (c) 2026 fix
//  SPDX-License-Identifier: MIT
//

import AppKit
import CursorTintCore

/// Manages the menu bar UI and the CursorTint engine lifecycle.
final class AppDelegate: NSObject, NSApplicationDelegate {
	private var statusItem: NSStatusItem?
	private let cursorTint = CursorTintCore.CursorTintEngine()

	func applicationDidFinishLaunching(_ notification: Notification) {

		let statusItem = NSStatusBar.system.statusItem(
			withLength: NSStatusItem.variableLength
		)

		if let image = NSImage(named: "MenuBarIcon") {
			image.isTemplate = true
			statusItem.button?.image = image
		}

		let menu = NSMenu()

		let aboutItem = NSMenuItem(
			title: "About CursorTint",
			action: #selector(showAbout),
			keyEquivalent: ""
		)

		aboutItem.target = self
		menu.addItem(aboutItem)
		menu.addItem(.separator())

		let quitItem = NSMenuItem(
			title: "Quit CursorTint",
			action: #selector(quit),
			keyEquivalent: "q"
		)

		quitItem.target = self
		menu.addItem(quitItem)

		statusItem.menu = menu
		self.statusItem = statusItem

		let mainMenu = NSMenu()
		let windowMenuItem = NSMenuItem()
		let windowMenu = NSMenu(title: "Window")

		let closeItem = NSMenuItem(
			title: "Close Window",
			action: #selector(NSWindow.performClose(_:)),
			keyEquivalent: "w"
		)

		closeItem.keyEquivalentModifierMask = [.command]
		windowMenu.addItem(closeItem)

		windowMenuItem.submenu = windowMenu
		mainMenu.addItem(windowMenuItem)

		NSApplication.shared.mainMenu = mainMenu

		cursorTint.start()
	}

	func applicationWillTerminate(_ notification: Notification) {
		cursorTint.stop()
	}

	@MainActor
	@objc private func showAbout() {
		let url = NSAttributedString(
			string: "https://github.com/fixdot/cursortint",
			attributes: [
				.link: "https://github.com/fixdot/cursortint",
				.font: NSFont.systemFont(ofSize: NSFont.systemFontSize)
			]
		)

		let options: [NSApplication.AboutPanelOptionKey: Any] = [
			.applicationName: "CursorTint",
			.applicationVersion: "0.1.0",
			.credits: url
		]

		NSApplication.shared.orderFrontStandardAboutPanel(
			options: options
		)

		NSApplication.shared.activate(ignoringOtherApps: true)
	}

	@MainActor
	@objc private func quit() {
		NSApplication.shared.terminate(nil)
	}
}
