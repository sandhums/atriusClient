//
//  Note.swift
//  atriusClient
//
//  Created by Manjinder Sandhu on 13/10/23.
//

import Foundation
struct Note: Identifiable, Codable {
    let id: UUID
    let date: Date
//    var attendees: [DailyScrum.Attendee]
    var transcript: String?
    
    init(id: UUID = UUID(), date: Date = Date(), transcript: String? = nil) {
        self.id = id
        self.date = date
        self.transcript = transcript
    }
}
