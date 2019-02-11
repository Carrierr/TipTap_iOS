//
//  Observables+.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 07/02/2019.
//  Copyright © 2019 Tiptap. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Observable {
    func withLatesFrom<T, U, R>(other1: Observable<T>, other2: Observable<U>, selector: @escaping (E, T, U) -> R) -> Observable<R> {
        return self.withLatestFrom(Observable<Any>.combineLatest(
            other1,
            other2
        )) { x, y in selector(x, y.0, y.1) }
    }
}


extension ObservableType {
    func suppressError() -> Observable<E> {
        return retryWhen { _ in return Observable<E>.empty()  }
    }
}
