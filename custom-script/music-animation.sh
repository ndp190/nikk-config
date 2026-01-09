#!/usr/bin/env swift

import Foundation

// Animation frames - radio waves
let frames = [
    "   ♪   ",
    "  (♪)  ",
    " ((♪)) ",
    "(((♪)))",
    " ((♪)) ",
    "  (♪)  "
]

let pausedIcon = "⏸"

// Get current frame based on seconds
let idx = Int(Date().timeIntervalSince1970) % frames.count
let playingIcon = frames[idx]

// Define the necessary types and functions from MediaRemote framework
typealias MRMediaRemoteGetNowPlayingInfoFunction = @convention(c) (DispatchQueue, @escaping (CFDictionary) -> Void) -> Void

// Load the MediaRemote framework dynamically
guard let bundle = CFBundleCreate(kCFAllocatorDefault, NSURL(fileURLWithPath: "/System/Library/PrivateFrameworks/MediaRemote.framework")),
      let MRMediaRemoteGetNowPlayingInfoPointer = CFBundleGetFunctionPointerForName(bundle, "MRMediaRemoteGetNowPlayingInfo" as CFString) else {
    exit(0)
}

let MRMediaRemoteGetNowPlayingInfo = unsafeBitCast(MRMediaRemoteGetNowPlayingInfoPointer, to: MRMediaRemoteGetNowPlayingInfoFunction.self)

let group = DispatchGroup()
var nowPlayingInfo: [String: Any]?

group.enter()

MRMediaRemoteGetNowPlayingInfo(DispatchQueue.global()) { info in
    nowPlayingInfo = info as? [String: Any]
    group.leave()
}

let result = group.wait(timeout: .now() + 2)
if result == .timedOut {
    exit(0)
}

// Extract and format the information
if let info = nowPlayingInfo,
   let artist = info["kMRMediaRemoteNowPlayingInfoArtist"] as? String,
   let title = info["kMRMediaRemoteNowPlayingInfoTitle"] as? String {
    let playbackRate = info["kMRMediaRemoteNowPlayingInfoPlaybackRate"] as? Double ?? 0.0

    if playbackRate == 1.0 {
        // Playing - show animation
        print("\(playingIcon) \(artist) - \(title)")
    } else {
        // Paused - show pause icon
        print("\(pausedIcon) \(artist) - \(title)")
    }
}
