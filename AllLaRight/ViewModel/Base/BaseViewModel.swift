//
//  BaseViewModel.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import Foundation
import RxSwift
import RxCocoa

protocol BaseViewModel {
    var disposBag: DisposeBag { get }
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}
