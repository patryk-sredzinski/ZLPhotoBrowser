//
//  ZLUndoManager.swift
//  ZLPhotoBrowser
//
//  Created by Patryk Średziński on 01/09/2023.
//

import Foundation

public enum ZLUndoAction {
    case draw
    case clip
    case sticker
    case text
    case mosaic
    case filter(_ previousFilter: ZLFilter)
    case adjustment
}

protocol ZLUndoManagerDelegate: AnyObject {
    func undoManager(_ undoManager: ZLUndoManager, didUpdateActions actionList: [ZLUndoAction])
    func undoManager(_ undoManager: ZLUndoManager, didUndoAction action: ZLUndoAction)
}

final class ZLUndoManager {
    var actions = [ZLUndoAction]()
    weak var delegate: ZLUndoManagerDelegate?
    
    func storeAction(_ action: ZLUndoAction) {
        actions.append(action)
        delegate?.undoManager(self, didUpdateActions: actions)
    }
    
    func undoAction() {
        guard let poppedAction = actions.popLast() else { return }
        delegate?.undoManager(self, didUndoAction: poppedAction)
        delegate?.undoManager(self, didUpdateActions: actions)
    }
}
