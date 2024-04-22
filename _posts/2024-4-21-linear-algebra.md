---
layout: post
title:  "So what's the point of linear algebra, anyway?"
subtitle: "Or: let's try to invent linear algebra, but backwards"
category: math
tags: [math, musings]
mathjax: true
---

Asking someone in a STEM field to justify linear algebra concepts is a bit like asking a Haskell programmer about monads. The best case scenario is that you'll get a shrug and a "don't worry about it, just learn when to use it". The more common scenario is an hour-long explanation that leaves you more confused than when you started. In keeping with my lifelong passion for confusing and upsetting as many people as possible, today I would like to talk about linear algebra. (I'll save the monads for a later date. Don't worry, [they're just burritos][monad-burritos].)

Target audience for this post: someone with at least a little exposure to linear algebra. If you're starting from complete scratch and want a good high-level picture, I highly recommend 3Blue1Brown's [Essence of Linear Algebra series][3b1b] on YouTube. Though of course, even that is no substitute for an actual textbook.

## Why all the vague definitions?

One of the reasons that linear algebra can be frustrating to the average high schooler or undergrad is that it's often the first time in your life that you get exposed to the Mathematician Way of Doing Things™. That is, rather than working with relatively concrete definitions, like "a vector is a list of real numbers" (a.k.a. the physicist's vector), you get far less helpful and less intuitive definitions, like "a vector is an element of a vector space", and "a vector space is a set that satisfies all of these different properties that you definitely won't remember and will definitely just end up visualizing as $\mathbb{R}^n$ anyway".

There are basically two main benefits of doing things this way:

1. <u>Minimal assumptions.</u> Structures like $\mathbb{R}^n$ have a LOT going on - they have a notion of distance, they have a notion of an inner product, you can even do calculus in them! Why make so many assumptions if you don't need them to prove the theorem at hand?
1. <u>Broad applicability.</u> This goes hand in hand with the above. By assuming as little as possible, you can find potentially unexpected applications for existing ideas with minimal extra effort.

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
1. Invent the concepts of a basis, vector, and matrix
1. Invent matrix multiplication, eigenvalues and eigenvectors
1. Invent the rest of linear algebra now that we have what we need to do so

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

In other words, to understand how $T$ acts on the complicated input $a\vec{x} + b\vec{y}$, we just need to know how it acts on $\vec{x}$ and $\vec{y}$. I argue that this one concept is so immensely powerful that it motivates all of the other concepts in linear algebra: from matrices to eigenvectors to everything else. The notion of a transformation that can be studied just by breaking down how it acts on specific inputs encompasses concepts as disparate as 3D rotations, the growth of the Fibonacci sequence, differentiation and integration, and the evolution of quantum states over time. For whatever reason, the universe is just full of transformations that can be broken down like this. And so correspondingly, we want our _conception_ of these transformations to be broad enough to adequately capture this beautiful phenomenon in its myriad forms.[^3]

## Bases

To recap, we have now the vague half-concept of a "linear transformation" as some kind of operation that can be understood by examining how it acts on components of its input. But for a concept like this to be useful, we need to actually be able to break said input down into components in the first place. Hence, the notion of a *basis*.

<div class="callout">
A basis is a collection of building blocks that you can use to express the inputs to a linear transformation.
</div>

How delightfully backwards! How pleasantly vague! Let's try to strip away some of this vagueness and pin down something more useful and algebraic. "Input to a linear transformation" is a mouthful, so let's abbreviate that to the currently-meaningless term "vector". Let's assume our basis, our building blocks, consists of some set of mathematical objects $b_1, ..., b_n$. Let's assume that $\vec{x}$ is some complicated object ("vector") and we want to understand how our lovely linear transformation $T$ behaves when you feed it $\vec{x}$. To compute $T(\vec{x})$, then, we need to understand two things:

1. How can we build our vector $\vec{x}$ out of our presumably useful building blocks $b_1, ..., b_n$?
1. How can we express how $T$ behaves on each of these building blocks?

Our one question has grown to two, but these seem more tractable. In particular, we can solve the former by inventing the _coordinate vector_, and the latter by inventing the dreaded _matrix_.

## Coordinate vectors

We've got our building blocks $B = \\{b_1, ..., b_n\\}$, and we've got our complicated object $\vec{x}$, so let's take a first crack at building our $\vec{x}$ out of said building blocks.

<div class="callout">
Attempt 1: we can try to express $\vec{x}$ by listing off which building blocks it contains and which ones it doesn't. Like, $\vec{x} = \{b_1, b_3, b_5\}$.
</div>

Not a crazy idea. But we immediately run into a wall: if we have only a finite number of basis elements, then we can only express a finite number of vectors. In particular, if we're only adding basis elements, then we can express at most $2^n$ vectors with this scheme. Even if we invent a symbol for subtraction, like $\vec{x} = b_1 - b_2$, that still only gives us $3^n$ possibilities - way too finite.

![meme of Asuka saying 'pathetic' from Evangelion](/assets/images/posts/linear-algebra-1.jpg "This isn't xkcd. You're not going to get me to be witty twice in one go.")

Let's try a different approach. In addition to "adding" and "subtracting" basis elements (whatever that means), we'll also allow for "scaling". That is, we'll throw some coefficients into the mix, and assume they behave reasonably like numbers.[^4] Since we use these things for "scaling", we can call them "scalers", sorry, _scalars_.

This gives us the axiom we want:

<div class="callout">
Attempt 2: Any vector $\vec{x}$ can be expressed as a unique sum of scaled basis elements. For a basis $b_1, ..., b_n$ and corresponding scaling factors $x_1, ..., x_n$, we denote this as $\vec{x} = \sum_{i=1}^n {x_i b_i}$.
</div>

(Yes, I did sneak the extra "unique" in there; without it, we can have multiple ways to represent something with our basis, which is kind of annoying, as we'll see in a moment.)

Now that we have a nice notion of breaking a vector down into a basis, we notice something else. Since our basis is so great and reusable, there's probably no need to keep writing it down. In fact, if we have lots of vectors, we can distinguish them from each other solely by breaking them down into this basis and examining the scaling factors. (This is why uniqueness matters - you don't want two sets of scaling factors to give you the same vector!) So then we can simply hide away the $b_i$ and identify $\vec{x}$ with its coordinates $x_1,...,x_n$. The basis is still there, invisible, like the air you breathe. But there's no need to talk about it unless you ever want to switch to a different basis.

Henceforth, then, we'll refer to these scaling factors $x_i$ as the "coordinates" of $\vec{x}$ with respect to our basis $b_1, ..., b_n$, and we'll use the term "coordinate vector" to refer to the list of these coordinates $\begin{bmatrix}x_{1} & \dots & x_{n}\end{bmatrix}$. We can go from $\vec{x}$ to its coordinates by breaking it down along the basis elements, and we can go from the coordinate vector back to $\vec{x}$ just by using the handy sum $\vec{x} = \sum_{i=1}^n {x_i b_i}$. So far so good! We'll use the following notation for coordinate vectors:

$$\left[x\right]_B := \begin{bmatrix}x_{1} & \dots & x_{n}\end{bmatrix}$$

## Refining our notion of a vector

Earlier, we defined "vector" as "the input to a linear transformation". But now that we have this clean concept of a basis, we can refine our informal definition a bit. Namely:

<div class="callout">
A vector is anything that can be expressed as a scaled summation of basis elements, i.e. in the form $\vec{x} = \sum_{i=1}^n {x_i b_i}$. In other words, a vector is anything that can be broken down into understandable pieces. We henceforth refer to scaled summations of this form as "linear combinations".
</div>

Note that this means that basis elements are also vectors, because any basis element $b_i$ can be expressed as $b_i = 0 \times b_1 + ... + 1 \times b_i + ... + 0 \times b_n$. So we can now just call them _basis vectors_.

It's worth noting that, modulo rigor, this definition of a vector is pretty much always equivalent to the traditional "a vector is an element of a vector space" definition, since every vector space has a basis.[^5] Speaking of which, let's go ahead and define a vector space as well:

<div class="callout">
A vector space is the set of all vectors for some basis. In other words, it's a collection of objects than can be broken down into the same underlying components.
</div>

Note the careful phrasing; this basis isn't necessarily unique for said vector space, but unlike the traditional definition, you do need to pick a basis to start with when you define a vector space.

## Matrices

Recall that to understand $T(\vec{x})$, we needed to answer two questions:

1. How can we build our vector $\vec{x}$ out of our presumably useful ~~building blocks~~ basis vectors $b_1, ..., b_n$?
1. How can we express how our linear transformation $T$ behaves on each of these basis vectors?

The notion of a coordinate vector solves our first problem, but we still need to answer the second. And to do this, we'll need to add a long-overdue restriction to our notion of a linear transformation:

<div class="callout">
It's not just the inputs of a linear transformation that are vectors, but the outputs too! And all of the outputs share the same vector space.
</div>

In other words, we want to be able to understand both the input and output of $T$ by breaking them down into components, even if those components are completely different. Let's just feed in one basis element to start, $b_1$. By our definition of a vector, we know that we can break down $T(b_1)$ along some basis $C = \\{c_1,...,c_m\\}$ and get some coefficients, which we'll call $t_{1,1}, ..., t_{m, 1}$. We can use our handy concept of a coordinate vector to express the coordinates of $T(b_1)$:

$$
\begin{align*}
T(b_1) &= \sum_{i=1}^m {t_{i,1} c_i} \quad & \text{By the definition of a vector} \\[2ex]
\left[T(b_1)\right]_C &= \begin{bmatrix}t_{1,1} & \dots & t_{m,1}\end{bmatrix} \quad & \text{Re-expressing as a coordinate vector}
\end{align*}
$$

<br>
But there are quite a few more input basis vectors than just $b_1$, so we may as well write out all of these components as a grid of numbers:
<br>
<br>

$$
\begin{align*}
\left[T(b_i)\right]_C &= \begin{bmatrix}t_{1,i} & \dots & t_{m,i}\end{bmatrix} \quad & \text{The coordinates when we feed in just one basis vector} \\[2ex]
\left[T\right]_{B,C} &:=
\begin{bmatrix}
t_{1,1} & \dots & t_{1,n} \\
t_{2,1} & \dots & t_{2,n} \\
\vdots & \ddots & \vdots \\
t_{m,1} & \dots & t_{m,n}
\end{bmatrix}
\quad & \text{Making a big grid with each value above as a separate column}
\end{align*}
$$

<br>
We'll call this thing we just invented a _matrix_. There are two things to note here:

1. Reifying $T$ into a concrete grid of numbers required us to use two bases, not just one. Hence the notation $[T]_{B,C}$.
1. We've written down all of our components, but that doesn't actually help us _do_ anything yet. We're still not sure what $T(\vec{x})$ is.

The second point above segues nicely into our next topic:

## Matrix-vector multiplication as an efficient shorthand for function application

At this point we have all of the puzzle pieces. We have clean, concrete representations of $\vec{x}$ and $T$ relative to our well-understood basis vectors. Now all we need to do is find a good representation of $T(\vec{x})$. This representation will invariably be in the form of coordinates with respect to the basis $C$. With this, we'll finally have a full, concrete understanding of $T(\vec{x})$. In essence, we're replicating the green arrow below with the three white arrows:

![Square-shaped diagram with arrows. There are two paths from x to T(x). One is direct and applies the abstract linear transformation T, one is indirect and first converts x to coordinates with basis B, then does a matrix multiplication, then uses coordinates in basis C to recover T(x).](/assets/images/posts/linear-algebra-2.svg "I hope you like this diagram, because I spent WAY too long fiddling with tikz before giving up. Shoutout to mathcha.io.")

As the diagram suggests, the missing piece here is the notion of matrix-vector multiplication. We simply take the dot product of each row of $\left[T\right]_{B,C}$ with $[x]_B$ to get the coordinates of $T(\vec{x})$ in the basis $C$. The proof for this is quite elegant:

<br>

$$
\begin{align*}
\left[T\left(\vec{x}\right)\right]_C &= \left[T\left( \sum_{i=1}^n {x_i b_i} \right)\right]_C \quad &\text{Rewriting $x$ in the basis $B$} \\[2ex]
&= \left[\sum_{i=1}^n {x_i T\left(b_i\right)} \right]_C \quad &\text{Using the fact that $T$ is linear} \\[2ex]
&= \left[\sum_{i=1}^n \left({x_i \sum_{j=1}^m {t_{j,i} c_j}}\right) \right]_C \quad &\text{By definition of the coordinates of $T(b_i)$} \\[2ex]
&= \left[\sum_{j=1}^m\sum_{i=1}^n {t_{j,i} x_i c_j} \right]_C \quad &\text{Swapping summations} \\[2ex]
&= \begin{bmatrix}\sum_{i=1}^n {t_{1,i} x_i} & \dots & \sum_{i=1}^n {t_{m,i} x_i}\end{bmatrix} \quad & \text{By the definition of a coordinate vector}
\end{align*}
$$

<br>

We can now read off the $j$-th element of our result above, $\sum_{i=1}^n {t_{j,i} x_i}$, and call it the "dot product" of the coordinate vectors $\begin{bmatrix}x_{1} & \dots & x_{n}\end{bmatrix}$ (our input) and $\begin{bmatrix}t_{j,1} & \dots & t_{j,n}\end{bmatrix}$ (the $j$-th row of our original matrix $\left[T\right]_{B,C}$). Feel free to quickly check that this is, indeed, the same thing as the traditional definition of a dot product.

And that's it! It's worth meditating on that proof for a little bit. Matrix-vector multiplication isn't just some meaningless symbol shuffling: we've derived exactly the computations necessary to go from a representation of $\vec{x}$ to a representation of $T(\vec{x})$.

A similar process can be used to invent matrix-matrix multiplication: it's just function composition, carried out numerically. This one is left as an exercise for the reader :D

## Some conclusions

Originally, I had planned to go further with this post, inventing eigenvectors as "particularly nice basis vectors" which allow you to just think of your transformation as scalings, and then introducing the Fourier transform as an eigendecomposition for the second derivative operator. But I think I've made the high-level idea clear enough now, so let's skip to conclusions.

In short, I don't think it's necessarily optimal to teach linear algebra the way it is taught traditionally, with a deluge of mechanical rigmarole preceding any conceptual justification for why we do things the way we do. Worse, I think that obfuscating the centrality of linear transformations actually _undersells_ the broad applicability of linear algebra, since priming students to think of the subject as just manipulating grids of numbers makes them less equipped to grasp other kinds of vector spaces, especially function spaces.

Heck, linear algebra is so broadly useful that we will go out of our way to make things linear when we can - whether we're [linearizing differential equations][linearization] or using [representation theory][representation-theory] to convert all kinds of algebraic structures into linear transformations.

Does that mean you should ditch Gilbert Strang and actually teach things the way this blog post does? Well, probably not. But I think there is a pedagogical middle ground here that doesn't leave linear transformations as an afterthought, and I hope that I've at least shown that the idea to front-load linear transformations isn't without merit.

One thing I have not mentioned yet is that part of linear algebra's usefulness comes not just from its mathematical universality, but from how amenable it is to being automated on modern hardware. The natural parallelizability of matrix multiplication has allowed us to build larger and faster GPUs to crunch numbers in quantities that have a quality all of their own. The entire modern field of deep learning hinges on this, as do other kinds of numerical methods and physical simulation.

![xkcd joke about machine learning and linear algebra](https://imgs.xkcd.com/comics/machine_learning.png "The pile gets soaked with data and starts to get mushy over time, so it's technically recurrent.")

Even quantum computers are really just chains of matrix multiplications when it comes down to it.

In a way, trying to explain how useful linear algebra is before actually teaching it may be a fool's errand; like a prisoner staring at dancing shadows on the wall of Plato's cave, sometimes you just have to understand something for yourself before it can really click. But that doesn't mean that we can't help people turn around so they can see the vast world that lay unnoticed behind them.

## Footnotes

[^1]: An aside for programmers: the math way of defining structures can be thought of as defining interfaces or protocols, like `VectorSpace` or `TopologicalSpace` or `Ring`, and then letting any arbitrary concrete structure implement said interface if it satisfies the necessary properties (i.e. a structural type system). In a sense, the structuralist point of view on math is that it's _only_ these interfaces that really matter, not the underlying concrete objects that implement them. So the natural numbers, for example, could just as well be any sequence of things with the right properties to be assigned the labels of "one" and "two" and so on, not just one particular canonical set of mathematical objects. This is a bit like programming while only paying attention to your type system and contracts and never once thinking about the actual bytes that you're shuffling around. Which, well, is exactly what math is, from the [Curry-Howard perspective][curry-howard]. But now we're getting REALLY off topic.
[^2]: In particular, what I'm aiming for here is a little [reverse mathematics][reverse-math], where rather than presenting definitions as a _fait accompli_ and deriving theorems, I want to work backwards from the properties we _want_ to figure out what definitions would get us there.
[^3]: For the sake of clarity, though, I will cheat a little bit and stick to finite-dimensional reasoning for most of this post. Pretty much everything should be generalizable to the infinite-dimensional case.
[^4]: More specifically, we assume they come from a field, i.e. have reasonable definitions of addition, subtraction, multiplication, and division with reasonable concepts of 0 and 1. If you give up on division you still have a ring, which means that we end up defining modules instead of vector spaces, which are still pretty nice but way beyond the scope of this post.
[^5]: The caveat here is that the proof that every vector space has a basis requires the axiom of choice, but that axiom's basically a given if you want to have any fun anyway.

<!--- References -->
[3b1b]: https://www.youtube.com/playlist?list=PLZHQObOWTQDPD3MizzM2xVFitgF8hE_ab
[curry-howard]: https://en.wikipedia.org/wiki/Curry%E2%80%93Howard_correspondence
[linearization]: https://en.wikipedia.org/wiki/Local_linearization_method
[monad-burritos]: https://byorgey.wordpress.com/2009/01/12/abstraction-intuition-and-the-monad-tutorial-fallacy/
[representation-theory]: https://en.wikipedia.org/wiki/Representation_theory
[reverse-math]: https://en.wikipedia.org/wiki/Reverse_mathematics