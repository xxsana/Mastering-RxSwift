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
 # just
 */

let disposeBag = DisposeBag()
let element = "😀"

// 위의 변수를 파라미터로 전달,
// 바로 구독 후 전달되는 이벤트를 프린트하도록 구독
Observable.just(element)
    .subscribe { event in
        print(event)
    }.disposed(by: disposeBag)


// 차근차근 만든다 치면
// 1. observable 생성 (동시에 이벤트도 구체적으로 적음)
let observable = Observable.just(element)

// 2. 구독하기+disposed by
observable.subscribe { event in //event의 타입은 Event<String>으로 자동
    print(event)                 // 받을때마다 할 일
}.disposed(by: disposeBag)


// parmameter로 배열 전달, 바로 구독시작
Observable.just([1, 2, 3])
    .subscribe { event in
        print(event)
    }
