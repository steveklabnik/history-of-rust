% The Story of Rust

<div style="text-align: center; margin-top: 40px">
<img src="http://www.rust-lang.org/logos/rust-logo-256x256-blk.png">
</div>

Steve Klabnik

# Let's talk about Rust

- Rust is a programming language.

- It's been in development a long time.

- It's been one year since 1.0.

- I'm here to tell you about that.

# Let's talk about Rust

I'm not going to say more about Rust itself yet. We'll get there!

First, let's talk about why you should care about this story.

# Let's talk about stories

- This is a story about history

- History can be divided up into 'epochs'

- Epochs are determined by the predominant paradigm of the time

- As things change, the paradigm (and hence the epoch) changes

# Epoch Rust

Rust has undergone four epochs so far:

- The Personal Years (2006-2010)

- The Graydon Years (2010-2012)

- The Typesystem Years (2012-2014)

- The Release Year (2015 -> May 2016)

We are now entering a new epoch: The Production Year (May 2016 -> ?)

# Moving between epochs

> It took a long time to figure out how Rust ought
> to work. - Niko

# Empiric Iteration

It's basically a completely different language if you compare by features.

It's basically the exact same language if you compare by goals.

Eight years is a long time.

# Empiric Iteration

Rust and Servo are both written in Rust.

"This feature seems cool" -> implement -> try it out

Cool? Keep it.

Not cool? Throw it out!

# Empiric Iteration

Rust has lost more features than many languages have in the first place.

# Empiric Iteration

Iteration does not mean identity crisis. The 'how' may not be clear, but the
goal can be.

# Epoch Rust

Rust has undergone four epochs so far:

- The Personal Years (2006-2010)

- The Graydon Years (2010-2012)

- The Typesystem Years (2012-2014)

- The Release Year (2015)

We are now entering a new epoch: The Production Year (May 2016 -> ?)

# The Personal Years

> I have been writing a compiled, concurrent, safe, systems
> programming language for the past four and a half years.

---

> We do not know what exactly will come of it.

---

> Many older languages _better_ than new ones. We keep forgetting
> already-learned lessons.

---

> Technology from the past come to save the future from itself

# The Personal Years

```
fn main() {
    log "hello, world";
}
```

---

```
fn max(int x, int y) -> int {
    if (x > y) {
        ret x;
    } else {
        ret y;
    }
}
```

# The Personal Years

```
obj counter(int i) {
    fn incr() {
        i += 1;
    }
    fn get() -> int {
        ret i;
    }
}

fn main() {
    auto c = counter(10);
    c.incr();
    log c.get();
}
```

# The Personal Years

```
obj swap[T](tup(T,T) pair) -> tup(T,T) {
    ret tup(pair._1, pair._0);
}

fn main() {
    auto str_pair = tup("hi", "there");
    auto int_pair = tup(10, 12);
    str_pair = swap[str](str_pair);
    int_pair = swap[int](int_pair);
}
```

# The Personal Years

> The semantics is the interesting part. The syntax is,
> really, about the last concern.

# The Personal Years

- Memory Safety, no wild pointers
- Typestate system, no null pointers
- Mutability control, immutable by default
- Side-effect control, pure by default
- You can break the rules
- You have to authorize _where_ and _how_
- In a standard way, that's integrated into the language and
  easy to audit.

# The Personal Years

- Multi-paradigm
- Not "everything is an object"
- Different abstractions for different problems, trade-offs
  between control and expression, clarity and brevity

# The Personal Years

- ~90% language features "working" in rough form
- ~70% runtime working
- 38kloc Ocaml compiler

# The Graydon Years

Rust now a Mozilla project, with Graydon as a BDFL-style figure.

Steady rate of improvement and change.

The team slowly grows.

# The Typesystem Years

As the team grows, the typesystem grows as well.

As the typesystem grows, more and more moves from the language
to the libraries.

Graydon steps down from the project.

# The Typesystem Years

Case study: Channels

```
rec(task task, chan[T] chan)
```

`task` and `chan` are keywords that the language knows about.

# The Typesystem Years

Case study: Channels

```
use std::thread::Thread;
use std::sync::mpsc::{Sender,Receiver};

struct Foo<T> {
    thread: Thread,
    chan: (Sender<T>, Receiver<T>),
}
```

# The Typesystem Years

Case study: Pointers

```
let x = @5; // GC'd pointer
let y = ~5; // unique pointer
let z = &5; // borrowed pointer
```

# The Typesystem Years

Case study: Pointers

```
let y = Box::new(5); // box
let z = &5; // reference
```

# The Typesystem Years

Not typesystem related: Cargo and Crates.io

```bash
$ cargo new foo --bin
$ cd foo
$ cargo run
   Compiling foo v0.0.1 (file:///home/steve/tmp/foo)
     Running `target/foo`
Hello, world!
```

# The Typesystem Years

Not typesystem related: Cargo and Crates.io

```bash
$ cargo build -v
   Compiling foo v0.0.1 (file:///home/steve/tmp/foo)
     Running `rustc src/main.rs --crate-name foo --crate-type bin -g --out-dir /home/steve/tmp/foo/target --emit=dep-info,link -L dependency=/home/steve/tmp/foo/target -L dependency=/home/steve/tmp/foo/target/deps`
```

Enable common patterns:

```bash
$ cargo build --release -v
   Compiling foo v0.0.1 (file:///home/steve/tmp/foo)
     Running `rustc src/main.rs --crate-name foo --crate-type bin -C opt-level=3 --cfg ndebug --out-dir /home/steve/tmp/foo/target/release --emit=dep-info,link -L dependency=/home/steve/tmp/foo/target/release -L dependency=/home/steve/tmp/foo/target/release/deps`
```

# The Typesystem Years

Not typesystem related: Cargo and Crates.io

```toml
$ cat Cargo.toml 
[package]

name = "foo"
version = "0.0.1"
authors = ["Steve Klabnik <steve@steveklabnik.com>"]
```

# The Typesystem Years

Not typesystem related: Cargo and Crates.io

```toml
$ cat Cargo.toml 
[package]

name = "foo"
version = "0.0.1"
authors = ["Steve Klabnik <steve@steveklabnik.com>"]

[dependencies]
time = "*"
log = "0.2.1"
```

```bash
$ cargo build
    Updating registry `https://github.com/rust-lang/crates.io-index`
   Compiling log v0.2.1
   Compiling libc v0.1.1
   Compiling gcc v0.1.7
   Compiling time v0.1.15
   Compiling foo v0.0.1 (file:///home/steve/tmp/foo)
```

# The Typesystem Years

As Rust's community grows, three large camps form:

- Ex C++ users
- Ex scripting language users
- Ex functional programmers

In some ways, Rust is a combination of all three of these things.

# The Typesystem Years

March 2014: RFC process begins

- Inspired by Python's PEP
- for introducing "significant" language changes
- 1632 submitted so far, 243 accepted, 69 open
- Even the core team goes through this process

# Intermezzo: Rust today: Ownership

```ruby
v = []

v.push("Hello")

x = v[0]

v.push("world")

puts x
```

# Intermezzo: Rust today: Ownership

```cpp
#include<iostream>
#include<vector>
#include<string>

int main() {
    std::vector<std::string> v;

    v.push_back("Hello");

    std::string& x = v[0];

    v.push_back("world");

    std::cout << x;
}
```

# Intermezzo: Rust today: Ownership

```bash
$ g++ hello.cpp -Wall -Werror
$ ./a.out
Segmentation fault (core dumped)
```

# Intermezzo: Rust today: Ownership

> If the new size() is greater than capacity() then all iterators and
> references (including the past-the-end iterator) are invalidated.

# Intermezzo: Rust today: Ownership

```
fn main() {
    let mut v = vec![];

    v.push("Hello");

    let x = &v[0];

    v.push("world");

    println!("{}", x);
}
```

# Intermezzo: Rust today: Ownership

```bash
$ cargo run
   Compiling hello_world v0.0.1 (file:///Users/you/src/hello_world)
error: cannot borrow `v` as mutable because it is also borrowed as immutable
    v.push("world");
    ^
note: previous borrow of `v` occurs here; the immutable borrow prevents
subsequent moves or mutable borrows of `v` until the borrow ends
    let x = &v[0];
             ^
note: previous borrow ends here
fn main() {
...
}
^
error: aborting due to previous error
```

# Intermezzo: Rust today: Concurrency

```
use std::thread;

fn main() {
    let guards: Vec<_> = (0..10).map(|_| {
        thread::spawn(|| {
            println!("Hello, world!");
        })
    }).collect();
}
```

# Intermezzo: Rust today: Concurrency

```
use std::thread;

fn main() {
    let guards: Vec<_> = (0..10).map(|_| {
        thread::spawn(|| {
            println!("Hello, world!");
        })
    }).collect();
}
```

---

```bash
error: capture of moved value: `numbers`
```

# Intermezzo: Rust today: Concurrency

```
use std::thread::Thread;
use std::sync::{Arc, Mutex};

fn main() {
    let numbers = Arc::new(Mutex::new(vec![1, 2, 3]));
    let mut handles = Vec::new();

    for i in 0..3 {
        let number = numbers.clone();

        let handle = thread::spawn(move || {
            let mut array = number.lock().unwrap();

            array[i] += 1;

            println!("numbers[{}] is {}", i, array[i]);
        });

        handles.push(handle);
    }

    for handle in handles {
        handle.join().unwrap();
    }
}
```

# Intermezzo: Rust today: Concurrency

```
extern crate crossbeam;

fn main() {
    let numbers = [1, 2, 3];
    
    crossbeam::scope(|scope| {
        for i in &mut numbers {
            scope.spawn(move || {
                numbers[i] += 1;
                println!("numbers[{}] is {}", i, numbers[i]);
            });
        }
    });
}
```

# The Release Year

* Rust 1.0.0-alpha – Friday, Jan 9, 2015
* Rust 1.0.0-beta1 – Week of Feb 16, 2015
* Rust 1.0.0 – May 15, 2015

# The Release Year

Continual pushing the boundaries of what's possible.

It's not just about the language, it's about the ecosystem.

It's not just about the language, it's about the tooling.

It's not just about the language, it's about stability.

It's not just about the language, it's about the community.

# The Release Year

Ecosystem:

- Cargo + Crates.io = Super easy sharing of code
- 5,055 crates on crates.io _last night_ (when I checked)
- 1,410 total contributors to `rustc`
- Big areas: game dev, operating systems, web development

# The Release Year

Tooling:

- Cargo. Never write a `Makefile` again.
- `rustfmt`: coming soon
- IDE integration: pretty okay!
- `rustfix`: not as strongly needed because...

# The Release Year

Stability:

- A new 1.x every six weeks
- Semver means painless upgrades
- Stability is hard, but your users will love you
- Additive change is the way to go
- Why do we make each other go on the upgrade treadmill?
- Build every crate on crates.io as part of the release process

# The Release Year

Community:

- We have a code of conduct. Treat each other like humans. It's just software.
- A number of meetups around the world
- ~1000 people on IRC

# The Production Year

Now that we've built a thing... time for people to use it!

# The Production Year

- Mozilla: Firefox 45 has Rust inside! (> 1 billion executions, 100% correctness)
- Dropbox: core of the product now in Rust
- Tilde: Skylight.io is a Ruby gem with Rust inside, 2 crashes in the last 4 years
- 22 organizations at [https://www.rust-lang.org/friends.html](https://www.rust-lang.org/friends.html)

# That's it!

I love Rust, and I hope you do too. If you don't, that's totally cool.

What will the future of this story be? We hope you'll join us in writing the next epoch.

Thank you! <3

