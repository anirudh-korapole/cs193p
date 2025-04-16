import Foundation
import SwiftXML

struct Playlist {
    var name: String
    var description: String?
    var songs: [String]
}

func parseiTunesLibrary(xmlFile: String, outputFile: String, mainPlaylistNamesFile: String) -> [Playlist] {
    var playlists = [Playlist]()
    var tracks = [String: String]()
    var mainPlaylistNames = Set<String>()

    do {
        // Parse the XML file
        let xml = try XML.Document(contentsOf: URL(fileURLWithPath: xmlFile))

        // Read main playlist names
        if let mainPlaylistNamesData = FileManager.default.contents(atPath: mainPlaylistNamesFile),
           let mainPlaylistNamesString = String(data: mainPlaylistNamesData, encoding: .utf8) {
            mainPlaylistNames = Set(mainPlaylistNamesString.components(separatedBy: .newlines).filter { !$0.isEmpty })
        }

        // Find the main dict element
        if let mainDict = xml.root.children.first(where: { $0.name == "dict" }) {
            // Parse tracks
            if let tracksDict = mainDict.children.first(where: { $0.name == "dict" && $0.children.first?.text == "Tracks" }) {
                for trackDict in tracksDict.children.filter({ $0.name == "dict" }) {
                    if let trackID = trackDict.children.first(where: { $0.name == "integer" && $0.text == "Track ID" })?.next?.text,
                       let trackName = trackDict.children.first(where: { $0.name == "string" && $0.text == "Name" })?.next?.text {
                        let artistName = trackDict.children.first(where: { $0.name == "string" && $0.text == "Artist" })?.next?.text ?? ""
                        tracks[trackID] = "\(trackName) (\(artistName))"
                    }
                }
            }

            // Parse playlists
            if let playlistsArray = mainDict.children.first(where: { $0.name == "dict" && $0.children.first?.text == "Playlists" }) {
                for playlistDict in playlistsArray.children.filter({ $0.name == "dict" }) {
                    var playlistName: String?
                    var playlistDescription: String?
                    var playlistSongs: [String] = []
                    for item in playlistDict.children {
                        if item.name == "string" && item.text == "Name" {
                            playlistName = item.next?.text
                        } else if item.name == "string" && item.text == "Description" {
                            playlistDescription = item.next?.text
                        } else if item.name == "dict" && item.children.first?.text == "Playlist Items" {
                            for trackDict in item.children.first(where: { $0.name == "array" })?.children ?? [] {
                                if let trackID = trackDict.children.first(where: { $0.name == "integer" })?.text {
                                    if let trackName = tracks[trackID] {
                                        playlistSongs.append(trackName)
                                    }
                                }
                            }
                        }
                    }
                    if let playlistName = playlistName, let playlistSongs = playlistSongs, mainPlaylistNames.contains(playlistName) {
                        playlists.append(Playlist(name: playlistName, description: playlistDescription, songs: playlistSongs))
                    }
                }
            }
        }
    } catch {
        print("Error parsing XML file: \(error)")
        return []
    }

    // Write filtered playlists to file
    do {
        let data = playlists.map { playlist -> String in
            var output = "\nPlaylist: \(playlist.name)\n"
            if let description = playlist.description {
                output += "Description: \(description)\n"
            }
            output += "Songs:\n"
            for song in playlist.songs {
                output += "  - \(song)\n"
            }
            return output
        }.joined(separator: "")
        try data.write(to: URL(fileURLWithPath: outputFile), atomically: true, encoding: .utf8)
        print("Filtered playlists written to \(outputFile)")
    } catch {
        print("Error writing to file: \(error)")
    }

    return playlists
}

// Example usage
let xmlFile = "/Users/anirudhkorapole/Documents/AppleMusic_Proj/Library.xml"
let outputFile = "/Users/anirudhkorapole/Documents/AppleMusic_Proj/playlists.txt"
let mainPlaylistNamesFile = "/Users/anirudhkorapole/Documents/AppleMusic_Proj/playlist_names_main.txt"

let playlists = parseiTunesLibrary(xmlFile: xmlFile, outputFile: outputFile, mainPlaylistNamesFile: mainPlaylistNamesFile)

if playlists.isEmpty {
    print("No playlists were found or parsed.")
} else {
    print("Filtered playlists parsed successfully.")
}

//print("hi what")
