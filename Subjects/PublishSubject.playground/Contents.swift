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
 # PublishSubject
 */
let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}

// 문자열이 포함된 next event를 받아서 다른 observer에게 전달할 수 있음.
let subject = PublishSubject<String>()

// subject로 next event가 전달됨
subject.onNext("Hello")


// 새로운 observer를 추가하고 subject를 구독하기
let o1 = subject.subscribe { print(">> 1", $0) }
o1.disposed(by: disposeBag)

// Publish subject는 '구독이후'에 전달되는 새로운 이벤트만 구독자로 전달함
// code 41의 next event는 o1으로 전달되지 않음.

// RxSwift를 담은 next event가 subject로 전달되고, subject는 이 이벤트를 구독자에게 전달함
subject.onNext("RxSwift")


// 새로운 구독자 추가
let o2 = subject.subscribe { print(">> 2", $0 ) }
o2.disposed(by: disposeBag)

// "RxSwift"는 subject 이전 내용이므로 전달되지 않음
subject.onNext("Subject")

//subject.onCompleted()

// error 전달되면
subject.onError(MyError.error)

// 새로운 구독자 추가
let o3 = subject.subscribe { print(">> 3", $0) }
o3.disposed(by: disposeBag)
