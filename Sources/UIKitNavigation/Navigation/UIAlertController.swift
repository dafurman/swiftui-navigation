#if canImport(UIKit)
  import SwiftUINavigationCore
  import UIKit

  @available(iOS 13, *)
  @available(macCatalyst 13, *)
  @available(macOS, unavailable)
  @available(tvOS 13, *)
  @available(watchOS, unavailable)
  extension UIAlertController {
    public convenience init<Action>(
      state: AlertState<Action>,
      handler: @escaping (_ action: Action?) -> Void
    ) {
      self.init(
        title: String(state: state.title),
        message: state.message.map { String(state: $0) },
        preferredStyle: .alert
      )
      for button in state.buttons {
        addAction(UIAlertAction(button, action: handler))
      }
    }

    public convenience init<Action>(
      state: ConfirmationDialogState<Action>,
      handler: @escaping (_ action: Action?) -> Void
    ) {
      self.init(
        title: state.titleVisibility == .visible ? String(state: state.title) : nil,
        message: state.message.map { String(state: $0) },
        preferredStyle: .actionSheet
      )
      for button in state.buttons {
        addAction(UIAlertAction(button, action: handler))
      }
    }
  }

  @available(iOS 13, *)
  @available(macCatalyst 13, *)
  @available(macOS, unavailable)
  @available(tvOS 13, *)
  @available(watchOS, unavailable)
  extension UIAlertAction.Style {
    init(_ role: ButtonStateRole) {
      switch role {
      case .cancel:
        self = .cancel
      case .destructive:
        self = .destructive
      }
    }
  }

  @available(iOS 13, *)
  @available(macCatalyst 13, *)
  @available(macOS, unavailable)
  @available(tvOS 13, *)
  @available(watchOS, unavailable)
  extension UIAlertAction {
    convenience init<Action>(
      _ button: ButtonState<Action>,
      action handler: @escaping (_ action: Action?) -> Void
    ) {
      self.init(
        title: String(state: button.label),
        style: button.role.map(UIAlertAction.Style.init) ?? .default
      ) { _ in
        button.withAction(handler)
      }
    }
  }
#endif
