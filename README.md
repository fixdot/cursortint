# CursorTint

**See your Terminal input mode at a glance.**

<img src="images/cursortint-title.png" alt="CursorTint" width="100%">

Using the wrong input mode can result in unintended text in Terminal.  
CursorTint makes the current input mode visible through the cursor color.  
U.S. input uses the Terminal default cursor color, while non-U.S. input is highlighted with `#EB5F5F`.

<img src="images/cursortint-demo.gif" alt="CursorTint demo" width="720">

The highlight color `#EB5F5F` was chosen after testing it against multiple Terminal background colors for good visibility without being overly harsh.

## Installation

1. Download the latest ZIP from GitHub Releases.
2. Extract the ZIP.
3. Copy `CursorTint.app` to the Applications folder.
4. Launch CursorTint.

To uninstall CursorTint, simply delete `CursorTint.app` from the Applications folder.

CursorTint is signed with Developer ID and notarized by Apple.

## Usage

Launch CursorTint and leave it running in the menu bar.

<img src="images/menu-bar-icon.png" alt="CursorTint menu bar icon">

- **U.S. input** → uses the default cursor color of the current Terminal profile
- **Non-U.S. input** → highlights the cursor with `#EB5F5F`
- **Quit CursorTint** → restores the Terminal profile's default cursor color

The menu bar provides:

- About CursorTint
- Quit CursorTint

### Tips

- Using **U.S. input + one non-U.S. input source you normally use** keeps input switching simple.
- Use a Terminal cursor color that is easy to distinguish from `#EB5F5F`.
- A block cursor is recommended because it makes the color change easier to see.
- If you want CursorTint available immediately after logging in, add it to your macOS Login Items.

## Compatibility

- macOS 12 or later
- Terminal.app only
- Apple Silicon: tested
- Intel Mac: built as a Universal Binary for Intel Macs that support macOS 12 or later, but not tested on actual Intel hardware

Basic behavior has been confirmed with:

- Japanese — Apple's Japanese input and Kawasemi Version 4
- Chinese — Simplified Chinese, Pinyin
- Korean — 2-Set Korean

## Privacy

CursorTint:

- does not read or store what you type
- does not make network connections
- only checks the currently selected input source
- sends cursor-color control sequences to Terminal

## Feedback

I'd like to verify CursorTint in more environments, so both successful compatibility reports and bug reports are welcome in GitHub Issues.

## License

CursorTint is released under the MIT License.

Copyright © 2026 fix

## Project

https://github.com/fixdot/cursortint
