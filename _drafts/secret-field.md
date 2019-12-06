---
layout: post
title:  "The secret field that nobody will tell you about"
category: math
tags: [math, musings]
---

### Outline
- useful reals form a field (closed under necessary operations)
- strict superset of rationals and strict subset of reals
    - in other words, a field extension of the rationals, but countable
    - apparently this is called an algebraic number field?
- not complete but good for most non-calculus applications like geometry
- most people don't teach via Cauchy sequences anyway
- aside: Busy Beavers and why you can't just describe numbers with English
- 100% of real numbers can't be represented, but we don't mind, why?
	- "order from chaos"
	- we care about order and structure, which arise from our symbols
	- similar analog to how 100% of functions can't be expressed but we don't care
	- Ignoring Solovay-Kitaev theorem, most quantum circuits of interest can be exactly computed (not just approximated) with poly(n) gates
	- this post never really was about just real numbers
- disclaimer that this may be a known idea already
 
# Article
Most schools teach number systems the same way. First they teach natural numbers (or "counting numbers"), then integers, rationals, reals, and complex numbers, in that order. Rationals are countable and reals are not, but that's okay. Once you start taking roots, you need a field more powerful than a countable underlying set allows for. Right?

Well, no, not really. Full disclaimer here, I'm by no means a mathematician, but there seems to be a secret field between the rationals and reals that doesn't arise often in discussion. And that field is the field of middle and high-school algebra.

### What are you talking about?
Let's step back for a moment. Why do most schools actually teach real numbers? It's true that the real numbers are complete, which is critical for calculus, but most schools introduce the general concept of reals far earlier than that. Usually, real numbers are introduced as a concept alongside irrationals to explain why $\pi$, $e$, and $\sqrt{2}$ can't be represented as mere fractions of two integers. The intuition seems clear; a real number is just an arbitrary point somewhere on the number line. 

But here, a question presents itself. The number line is pretty long, and there are quite a few numbers along it. Uncountably many of them, in fact. How many of these numbers could we actually write out? Not just explicitly, but even indirectly via a formula or Cauchy sequence. Pretty much any symbolic notation goes as long as it's well-defined. So for example, we could define $\pi$ like this:

$$\pi=2\int_{-1}^{1} {\sqrt{1-x^2}dx}$$

That is, twice the area of a semicircle of radius 1. And we could define $e$ like this:

$$e=\lim_{n\rightarrow\infty}{\left(1+\frac{1}{n}\right)^n}$$

Of course, there are innumerable other equivalent definitions we could have picked. Finding formulas for $\pi$ is [practically its own sport](http://mathworld.wolfram.com/PiFormulas.html). Put another way, our partial function from symbolic expressions to real numbers is non-injective, that is, multiple symbolic expressions can represent the same number. (Put yet another way, $2+2$ and $4$ are the same thing.)

This then immediately raises another question. Is this function *surjective*? That is, can every real number be represented this way, via some Cauchy sequence or other trickery? No, of course not. A quick diagonalization argument is all we need to show that. All symbolic expressions can be represented by binary sequences, that is, natural numbers - LaTeX source code is one example, or even a .png image of the expression counts as a function to integers. And of course, you can't have a surjection from the natural numbers to reals, so in a sense 100% of real numbers are impossible to precisely express in finite space.

Wait a second. Let's take a moment to process what that means. It doesn't matter if you're a human or alien, it doesn't matter what mathematical formalization you use or what symbols you prefer with what meaning. I can confidently assert that if I choose a real number at random (e.g. from the distribution $N(0, 1)$) there is a probability of 1 that you will be unable to express what number I picked. This assertion is predicated on the well-definedness of your symbolic notation and nothing else!

### Introducing the "useful reals"
This is the part you've been waiting for, where I define the secret field I've been talking about. It's quite straightforward. A "useful real" is just a real number that can be precisely described (not just approximated!) by some symbolic notation. Obviously, this definition is loose and depends greatly on your choice of symbols and their definitions. In normal human mathematical notation, the useful reals are a strict superset of the rationals. Some useful reals in this notation include $\pi$, $e$, $\frac{1}{2}$, $\tau$, $\sqrt[3]{5}$, and the golden ratio $\phi$.

#### Do these really have the properties we want?
Well, other than completeness, yes! Let $A$, $B$, and $C$ be parenthesized symbolic expressions that correspond to real numbers. (Or, more precisely, since we want a correspondence with elements of our field, we'll consider each of them a representative of an equivalence class of symbolic expressions that evaluate to a given real number.)

Now, if you have a symbolic expression $A$, and a symbolic expression $B$, there's really nothing stopping you from writing $(A+B)$ and claiming that this expression represents a specific real number. It also makes sense that $(A+B) = (B+A)$, that is, the expression on the left and the expression on the right are in the same equivalence class, and so on. In fact, you can say all of these things without even knowing what's in the symbolic expressions! I won't list out all the properties here, but a motivated reader can verify that these symbolic expression equivalence classes form an abelian group under addition and nonzero multiplication, that the multiplication distributes over the addition, and so on - in short, that we have all of the necessary properties of a field.

#### Why do we care?
This is where we notice something interesting. The useful reals are merely countable, yet they contain all of the reals you would ever want to explicitly specify. Why do they always seem to feel "good enough"? Why is it that most people never really consider the limitations of their own notation?