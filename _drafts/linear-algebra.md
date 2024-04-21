---
layout: post
title:  "So what's the point of linear algebra, anyway?"
category: math
tags: [math, musings]
mathjax: true
---

Asking someone in a STEM field to motivate linear algebra is a bit like asking a Haskell programmer about monads. The best case scenario is that you'll get a shrug and a "don't worry about it, just learn when to use it". The more common scenario is an hour-long explanation that leaves you more confused than when you started. In keeping with my lifelong passion for confusing and upsetting as many people as possible, today I would like to talk about linear algebra. (I'll save the monads for a later date. Don't worry, [they're just burritos][monad-burritos].)

Target audience for this post: someone with at least a little exposure to linear algebra. If you're starting from complete scratch and want a good high-level picture, I highly recommend 3Blue1Brown's [Essence of Linear Algebra series][3b1b] on YouTube. Though of course, even that is no substitute for an actual textbook.

## Why all the vague definitions?

One of the reasons that linear algebra can be frustrating to the average high schooler or undergrad is that it's often the first time in your life that you get exposed to the Mathematician Way of Doing Things™. That is, rather than working with relatively concrete definitions, like "a vector is a list of real numbers" (a.k.a. the physicist's vector), you get far less helpful and less intuitive definitions, like "a vector is an element of a vector space", and "a vector space is a set that satisfies all of these different properties that you definitely won't remember and will definitely just end up visualizing as $\mathbb{R}^n$ anyway".

There are basically two main benefits of doing things this way:

1. <u>Minimal assumptions.</u> Structures like $\mathbb{R}^n$ have a LOT going on - they have a notion of distance, they have a notion of an inner product, you can even do calculus in them! Why make so many assumptions if you don't need them to prove the theorem at hand?
1. <u>Broad applicability.</u> This goes hand in hand with the above. By assuming as little as possible, you can find potentially unexpected applications for existing ideas with minimal extra effort. This will come up again a little later when we talk about function spaces.

In short: the math way of doing things is a programmer's dream come true.[^1] Maximum code reuse! But a little more confusing than necessary for someone who just wants to think of vectors as arrows and spaces as grids.

## Okay but seriously though what's up with all of these arrays of numbers and tedious operations?

Now for the contentious part. I'm no pedagogy expert, but my ideal linear algebra course would change up the order of things a bit from the usual approach. In particular, the typical course goes something like this:

1. Vectors, matrices
1. Lots and lots of number crunching: matrix-vector products, matrix multiplication, Gauss-Jordan elimination, determinants, etc.
1. Even more number crunching, projections, various kinds of decompositions
1. Nullspaces, bases, dimensions, kernels, etc.
1. Eigenvalues and eigenvectors
1. OH LOOK WE CAN FINALLY TALK ABOUT LINEAR TRANSFORMATIONS

Bluntly, while this ordering may make sense for someone whose idea of linear algebra starts and ends with BLAS and `numpy.linalg`, I think this approach tends to miss the forest for the trees. Don't get me wrong: drilling the fundamentals is absolutely essential, and having concrete numbers to work with can make new math more approachable. But linear algebra is in the unfortunate situation is being a particularly useful subject that is also particularly obtuse from a purely numerical standpoint. And so in my ideal course, we would start from the other end and teach in the following order:

1. Linearity and linear transformations
1. Motivate the definitions of a basis, vector, and matrix
1. Motivate matrix multiplication, eigenvalues and eigenvectors
1. Invent the rest of linear algebra now that we have the motivation to do so

I'm not sure if this would actually hold up in a real classroom, but regardless, I'd like to sketch out how this approach would work with the rest of this post.[^2] So let's start with:

## Linearity

Let's finally try to answer the question in the title of the post. What is the point of linear algebra? My answer is simple:

<div class="callout">
Linear algebra is the study of linear transformations.
</div>

Oh boy, if that isn't circular. But I mean this sincerely. And to illustrate what I mean, let's do something really mathematically inappropriate: I'll show you a formula, and I won't define any of the symbols in it. (Except $\forall$, which means "for all".)

$$\forall a,b,\vec{x},\vec{y}: \quad T(a\vec{x} + b\vec{y}) = a T(\vec{x}) + b T(\vec{y})$$

To me, that equation, and its many generalizations, are the absolute core of linear algebra. It doesn't matter what $T$ and $\vec{x}$ and $a$ are. It doesn't even matter what addition and multiplication mean. You can shuffle the definitions around however you like, as mathematicians are wont to do. What matters is the _structure of the equation itself_. Because when you view $T$ as a sort of function, and you view the above equation as a constraint on "linear" functions, you are basically saying the following:

<div class="callout">
A linear transformation is a function that you can understand just by understanding how it acts on smaller, simpler inputs.
</div>

In other words, to understand how $T$ acts on the complicated input $a\vec{x} + b\vec{y}$, we just need to know how it acts on $\vec{x}$ and $\vec{y}$. I argue that this one concept is so immensely powerful that it motivates all of the other concepts in linear algebra: from matrices to eigenvectors to everything else. And to illustrate this, I'm going to start, not with vectors, but with

## Bases

To recap, we have now the vague half-concept of a "linear transformation" as some kind of operation that can be understood by examining how it acts on components of its input. But for a concept like this to be useful, we need to actually be able to break said input down into components in the first place. Hence, the notion of a *basis*.

<div class="callout">
A basis is a collection of building blocks that you can use to express the inputs to a linear transformation.
</div>

How delightfully backwards! How pleasantly vague! Let's try to strip away some of this vagueness and pin down something more useful and algebraic. "Input to a linear transformation" is a mouthful, so let's abbreviate that to the currently-meaningless term "vector". Let's assume our basis, our building blocks, consists of some set of mathematical objects $b_1, ..., b_n$. Let's assume that $\vec{x}$ is some complicated object ("vector") and we want to understand how our lovely linear transformation $T$ behaves when you feed it $x$. To compute $T(\vec{x})$, then, we need to understand two things:

1. How can we build our vector $\vec{x}$ out of our presumably useful building blocks $b_1, ..., b_n$?
1. How can we express how $T$ behaves on each of these building blocks?

Our one question has grown to two, but these seem more tractable. In particular, we can solve the former by inventing the _coordinate vector_, and the latter by inventing the dreaded _matrix_.

## Coordinate vectors

We've got our building blocks $B = \{b_1, ..., b_n\}$, and we've got our complicated object $\vec{x}$, so let's take a first crack at building our $\vec{x}$ out of said building blocks.

<div class="callout">
Attempt 1: we can try to express $\vec{x}$ by listing off which building blocks it contains and which ones it doesn't. Like, $\vec{x} = \{b_1, b_3, b_5\}$.
</div>

Not a crazy idea. But we immediately run into a wall: if we have only a finite number of basis elements, then we can only express a finite number of vectors. In particular, if we're only adding basis elements, then we can express at most $2^n$ vectors with this scheme. Even if we invent a symbol for subtraction, like $\vec{x} = b_1 - b_2$, that still only gives us $3^n$ possibilities - way too finite.

![meme of Asuka saying 'pathetic' from Evangelion](/assets/images/posts/linear-algebra-1.jpg "This isn't xkcd. You're not going to get me to be witty twice in one go.")

Let's try a different approach. In addition to "adding" and "subtracting" basis elements (whatever that means), we'll also allow for "scaling". That is, we'll throw some coefficients into the mix, and assume they behave reasonably like numbers.[^3] Since we use these things for "scaling", we can call them "scalers", sorry, _scalars_.

This gives us the axiom we want:

<div class="callout">
Attempt 2: Any vector $\vec{x}$ can be expressed as a unique sum of scaled basis elements. For a basis $b_1, ..., b_n$ and corresponding scaling factors $x_1, ..., x_n$, we denote this as $\vec{x} = \sum_{i=0}^n {x_i b_i}$.
</div>

(Yes, I did sneak the extra "unique" in there; without it, we can have multiple ways to represent something with our basis, which is subjectively kind of annoying, as we'll see in a moment.)

Now that we have a nice notion of breaking a vector down into a basis, we notice something else. Since our basis is so great and reusable, there's probably no need to keep writing it down. In fact, if we have lots of vectors, we can distinguish them from each other solely by breaking them down into this basis and examining the scaling factors. (This is why uniqueness matters - you don't want two sets of scaling factors to give you the same vector!) So then we can simply hide away the $b_i$ and identify $\vec{x}$ with its coordinates $x_1,...,x_n$. The basis is still there, invisible, like the air you breathe. But there's no need to talk about it unless you ever want to switch to a different basis.

Henceforth, then, we'll refer to these scaling factors $x_i$ as the "coordinates" of $\vec{x}$ with respect to our basis $b_1, ..., b_n$, and we'll use the term "coordinate vector" (denoted $\boldsymbol{x_B}$) to refer to the list of these coordinates $\begin{bmatrix}x_{1} & \dots & x_{n}\end{bmatrix}$. We can go from $\vec{x}$ to its coordinates by breaking it down along the basis elements, and we can go from the coordinate vector $\boldsymbol{x_B}$ back to $\vec{x}$ just by using the handy sum $\vec{x} = \sum_{i=0}^n {x_i b_i}$. So far so good!

## Refining our notion of a vector

Earlier, we defined "vector" as "the input to a linear transformation". But now that we have this clean concept of a basis, we can refine our informal definition a bit. Namely:

<div class="callout">
A vector is anything that can be expressed as a scaled summation of basis elements, i.e. in the form $\vec{x} = \sum_{i=0}^n {x_i b_i}$. In other words, a vector is anything that can be broken down into understandable pieces. We henceforth refer to scaled summations of this form as "linear combinations".
</div>

Note that this means that basis elements are also vectors, because any basis element $b_i$ can be expressed as $b_i = 0 \times b_1 + ... + 1 \times b_i + ... + 0 \times b_n$. So we can now just call them _basis vectors_.

It's worth noting that, modulo rigor, this definition of a vector is pretty much always equivalent to the traditional "a vector is an element of a vector space" definition, since every vector space has a basis.[^4]

## Matrices

Recall that to understands $T(\vec{x})$, we needed to answer two questions:

1. How can we build our vector $\vec{x}$ out of our presumably useful ~~building blocks~~ basis vectors $b_1, ..., b_n$?
1. How can we express how $T$ behaves on each of these basis vectors?

The notion of a coordinate vector solves our first problem, but we still need to answer the second. And to do this, we'll need to add a long-overdue restriction to our notion of a linear transformation:

<div class="callout">
It's not just that the inputs of a linear transformation that are vectors, but the outputs too!
</div>

TODO


## TODO

- Also lots of things are linear in practice: derivatives, the quantum Hamiltonian. We can locally linearize differential equations too to make them well behaved. Mention representation theory
- Matrix multiplications are parallelizable and lend well to GPUs
- Eigenvectors/values are about finding the right basis: seeing the transformation as just a scaling once you express the inputs the right way.


## Footnotes

[^1]: An aside for programmers: the math way of defining structures can be thought of as defining interfaces or protocols, like `VectorSpace` or `TopologicalSpace` or `Ring`, and then letting any arbitrary concrete structure implement said interface if it satisfies the necessary properties (i.e. a structural type system). In a sense, the structuralist point of view on math is that it's _only_ these interfaces that really matter, not the underlying concrete objects that implement them. So the natural numbers, for example, could just as well be any sequence of things with the right properties to be assigned the labels of "one" and "two" and so on, not just one particular canonical set of mathematical objects. This is a bit like programming while only paying attention to your type system and contracts and never once thinking about the actual bytes that you're shuffling around. Which, well, is exactly what math is, from the [Curry-Howard perspective][curry-howard]. But now we're getting REALLY off topic.
[^2]: In particular, what I'm aiming for here is a little [reverse mathematics][reverse-math], where rather than presenting definitions as a _fait accompli_ and deriving theorems, I want to work backwards from the properties we _want_ to figure out what definitions would get us there.
[^3]: More specifically, we assume they come from a field, i.e. have reasonable definitions of addition, subtraction, multiplication, and division with reasonable concepts of 0 and 1. If you give up on division you still have a ring, which means that we end up defining modules instead of vector spaces, which are still pretty nice but way beyond the scope of this post.
[^4]: The caveat here is that the proof that every vector space has a basis requires the axiom of choice, but that's basically a given if you want to have any fun anyway.

<!--- References -->
[3b1b]: https://www.youtube.com/playlist?list=PLZHQObOWTQDPD3MizzM2xVFitgF8hE_ab
[curry-howard]: https://en.wikipedia.org/wiki/Curry%E2%80%93Howard_correspondence
[monad-burritos]: https://byorgey.wordpress.com/2009/01/12/abstraction-intuition-and-the-monad-tutorial-fallacy/
[reverse-math]: https://en.wikipedia.org/wiki/Reverse_mathematics