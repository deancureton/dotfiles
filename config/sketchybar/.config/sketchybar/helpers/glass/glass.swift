// Draws a native Liquid Glass (NSGlassEffectView) window behind the bar.
// usage: sketchybar-glass <height> [--clear] [--tint 0xAARRGGBB]
import AppKit

var height: CGFloat = 40
var style: NSGlassEffectView.Style = .regular
var tint: NSColor? = nil

var args = Array(CommandLine.arguments.dropFirst())
while !args.isEmpty {
	let arg = args.removeFirst()
	switch arg {
	case "--clear":
		style = .clear
	case "--tint":
		guard !args.isEmpty, let value = UInt32(args.removeFirst().replacingOccurrences(of: "0x", with: ""), radix: 16) else {
			fatalError("--tint expects 0xAARRGGBB")
		}
		tint = NSColor(
			red: CGFloat((value >> 16) & 0xff) / 255,
			green: CGFloat((value >> 8) & 0xff) / 255,
			blue: CGFloat(value & 0xff) / 255,
			alpha: CGFloat((value >> 24) & 0xff) / 255
		)
	default:
		height = CGFloat(Double(arg) ?? 40)
	}
}

var windows: [NSWindow] = []

func rebuild() {
	for w in windows { w.orderOut(nil) }
	windows = []
	for screen in NSScreen.screens {
		let f = screen.frame
		let rect = NSRect(x: f.minX, y: f.maxY - height, width: f.width, height: height)
		let w = NSWindow(contentRect: rect, styleMask: .borderless, backing: .buffered, defer: false, screen: screen)
		w.isOpaque = false
		w.backgroundColor = .clear
		w.hasShadow = false
		// one below kCGBackstopMenuLevel
		w.level = NSWindow.Level(rawValue: -21)
		w.ignoresMouseEvents = true
		w.collectionBehavior = [.canJoinAllSpaces, .stationary, .ignoresCycle]
		w.isReleasedWhenClosed = false
		let glass = NSGlassEffectView(frame: NSRect(origin: .zero, size: rect.size))
		glass.cornerRadius = 0
		glass.style = style
		glass.tintColor = tint
		glass.autoresizingMask = [.width, .height]
		w.contentView = glass
		w.orderFrontRegardless()
		windows.append(w)
	}
}

let app = NSApplication.shared
app.setActivationPolicy(.prohibited)
NotificationCenter.default.addObserver(
	forName: NSApplication.didChangeScreenParametersNotification, object: nil, queue: .main
) { _ in rebuild() }
rebuild()
app.run()
