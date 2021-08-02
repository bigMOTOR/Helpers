//
//  Lifecycle.swift
//  
//
//  Created by Nikolay Fiantsev on 31.07.2021.
//

import Foundation
import SwiftUI
import ComposableArchitecture

// MARK: - LifecycleAction
public enum LifecycleAction<Action: Equatable>: Equatable {
  case onAppear
  case onDisappear
  case action(Action)
}

// MARK: - Lifecycle Reducer
public extension Reducer {
  func lifecycle(
    onAppear: @escaping (Environment) -> Effect<Action, Never>,
    onDisappear: @escaping (Environment) -> Effect<Never, Never>
  ) -> Reducer<State?, LifecycleAction<Action>, Environment> where Action: Equatable {
    
    return .init { state, lifecycleAction, environment in
      switch lifecycleAction {
      case .onAppear:
        return onAppear(environment).map(LifecycleAction.action)
        
      case .onDisappear:
        return onDisappear(environment).fireAndForget()
        
      case let .action(action):
        guard state != nil else { return .none }
        return self.run(&state!, action, environment)
          .map(LifecycleAction.action)
      }
    }
  }
}

// MARK: - WithViewStore + Lifecycle

/// Proxy View to resolve types for  Lifecycle.actions auto inject
public struct LifeCycleView<State, Action, Content>: View where Content: View, Action: Equatable {
  let viewStore: ViewStore<State, LifecycleAction<Action>>
  let content: () -> Content
  
  public var body: some View {
    content()
      .onAppear { viewStore.send(.onAppear) }
      .onDisappear { viewStore.send(.onDisappear) }
  }
}

/// Extensions of WithViewStore to deal with Lifecycle.actions
public extension WithViewStore where Content: View {
  init<LocalContent>(
    _ store: Store<State, LifecycleAction<Action>>,
    removeDuplicates isDuplicate: @escaping (State, State) -> Bool,
    @ViewBuilder content: @escaping (ViewStore<State, Action>) -> LocalContent
  ) where Content == LifeCycleView<State, Action, LocalContent> {
    self.init(
      store.scope(action: LifecycleAction.action),
      removeDuplicates: isDuplicate,
      content: { viewStore in
        LifeCycleView(
          viewStore: ViewStore(store, removeDuplicates: isDuplicate),
          content: { content(viewStore) }
        )
      }
    )
  }
}

public extension WithViewStore where Content: View, State: Equatable {
  init<LocalContent>(
    _ store: Store<State, LifecycleAction<Action>>,
    @ViewBuilder content: @escaping (ViewStore<State, Action>) -> LocalContent
  ) where Content == LifeCycleView<State, Action, LocalContent> {
    self.init(store, removeDuplicates: ==, content: content)
  }
}

// MARK: - WithViewStore + Alerts and ActionSheet
public extension View {
  func actionSheet<Action>(
    _ store: Store<ActionSheetState<Action>?, LifecycleAction<Action>>,
    dismiss: Action
  ) -> some View {
    self.actionSheet(store.scope(action: LifecycleAction.action), dismiss: dismiss)
  }
  
  func alert<Action>(
    _ store: Store<AlertState<Action>?, LifecycleAction<Action>>,
    dismiss: Action
  ) -> some View {
    self.alert(store.scope(action: LifecycleAction.action), dismiss: dismiss)
  }
}

// MARK: - Helpers
private extension Store {
  func scope<LocalAction>(
    action fromLocalAction: @escaping (LocalAction) -> Action
  ) -> Store<State, LocalAction> {
    self.scope(state: { $0 }, action: fromLocalAction)
  }
}
