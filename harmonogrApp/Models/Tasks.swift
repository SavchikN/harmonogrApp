//
//  Tasks.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 23/07/2023.
//

import UIKit

enum Types: String {
    case high = "High"
    case medium = "Medium"
    case low = "low"
}

struct Tasks {
    var name: String
    var description: String
    var taskType: Types
    
    static var tasks: [Tasks] = []
    
    static var allTasks: [Tasks] {
        return tasks
    }
    
    static func getPriorityTasks(type: Types) -> [Tasks] {
        let tasks = tasks.filter { task in
            return task.taskType == type
        }
        return tasks
    }
    
    static func addTask(task: Tasks) {
        tasks.append(task)
    }
}
