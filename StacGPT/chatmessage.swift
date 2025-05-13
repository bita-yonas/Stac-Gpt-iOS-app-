//
//  chatmessage.swift
//  StacGPT
//
//  Created by Bitania yonas on 4/6/25.
//

import Foundation

struct ChatMessage: Identifiable {
    var id = UUID()
    var content: String
    var isFromUser: Bool
    var date: Date = Date()
} 
