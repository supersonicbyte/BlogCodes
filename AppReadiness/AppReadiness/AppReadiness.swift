//
//  AppReadiness.swift
//  AppReadiness
//
//  Created by Mirza Učanbarlić on 17. 5. 2024..
//

import Foundation

 final class AppReadiness: @unchecked Sendable {
    typealias Task = () -> Void
    private let queue = DispatchQueue(label: "com.supersonicbyte.AppReadiness")
    private var taskQueue: [Task] = []
    private var _isAppReady = false
    
    static let shared = AppReadiness()
    
    private init() {}
    
    func setAppIsReady() {
        queue.sync {
            guard !_isAppReady else { return }
            runQueuedTaks()
            _isAppReady = true
        }
    }
    
    func isAppReady() -> Bool {
        return queue.sync {
            return _isAppReady
        }
    }
    
    func runSyncNowOrWhenAppBecomesReady(_ task: @escaping Task) {
        queue.sync {
            if _isAppReady {
                task()
            } else {
                taskQueue.append(task)
            }
        }
    }
    
    private func runQueuedTaks() {
        for task in taskQueue {
            task()
        }
        taskQueue.removeAll()
    }
}
