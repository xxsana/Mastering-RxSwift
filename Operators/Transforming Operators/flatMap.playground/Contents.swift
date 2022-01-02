//
//  Copyright (c) 2019 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import RxSwift

/*:
 # flatMap
 */

let disposeBag = DisposeBag()

// BehaviorSubject 2개를 만들고 1,2로 초기화
let a = BehaviorSubject(value: 1)
let b = BehaviorSubject(value: 2)

// BehaviorSubject를 방출하는 PublishSubject를 생성
let subject = PublishSubject<BehaviorSubject<Int>>()

subject
    .flatMap { $0.asObservable() }
    .subscribe{ print($0) }
    .disposed(by: disposeBag)

// behavior subject를 원하는대로 변환한 다음 새로운 observable을 리턴하는
// '클로저'를 파라미터로 취함.
// 여기에선 별다른 변환 없이 subject를 observable로 바꿔서 리턴

subject.onNext(a)
// publish subject에서 a를 방출하면 flatMap을 거쳐서 새로운 observable이 생성됨.
// 결과 next(1)

subject.onNext(b)

// 결과 next(1); next(2)
// 최종적으로 앞에서 생성된 observable과 합쳐짐
// 모든 observable이 하나의 -able로 합쳐지고, 방출되는 항목들이 순서대로 구독자에게 전달됨

// a에서 새 값을 방출하면
a.onNext(11)

// 결과 next(1); next(2); next(11)

// b에서 새 값을 방출하면
b.onNext(22)

// 결과 next(1); next(2); next(11); next(22)

// flatMap 연산자는 원본 observable이 방출하는 항목을 새로운 observable로 변환
// 새로운 observable은 항목이 업데이트 될 때 마다 새로운 항목을 방출
// 이렇게 생성된 모든 observable은 최종적으로 하나의 observable로 합쳐지고
// 모든 항목들이 이 최종 observable을 통해서 구독자에게 전달됨.
// 업데이트된 최신항목도 구독자로 전달되는 것이 특징
// 네트워크 요청을 구현할 때 자주 활용됨



