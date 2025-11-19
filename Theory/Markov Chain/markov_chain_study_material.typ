#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/cetz:0.3.1"

#set document(title: "Markov Chains: A Comprehensive Study Guide", author: "Md Ayan Alam")
#set page(
  paper: "a4",
  margin: (x: 2cm, y: 2.5cm),
  numbering: "1",
  header: align(right)[
    _Markov Chains Study Material_
  ],
)
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true, leading: 0.65em)
#set heading(numbering: "1.1")

#show heading.where(level: 1): it => block(above: 1.5em, below: 1em)[
  #set text(size: 20pt, weight: "bold")
  #it
]

#show heading.where(level: 2): it => block(above: 1.2em, below: 0.8em)[
  #set text(size: 16pt, weight: "bold")
  #it
]

// Title Page
#align(center)[
  #text(size: 24pt, weight: "bold")[Markov Chains]
  #v(0.5em)
  #text(size: 18pt)[A Comprehensive Study Guide]
  #v(1em)
  #line(length: 100%, stroke: 2pt)
  #v(2em)

  #text(size: 14pt)[
    *Student:* Md Ayan Alam \
    *Roll Number:* GF202342645 \
    *Course:* Statistical Foundation of Data Science \
    *Institution:* Shoolini University
  ]

  #v(2em)
  #text(size: 12pt)[
    _Last Updated: November 19, 2025_
  ]
]

#pagebreak()

// Table of Contents
#outline(
  title: [Table of Contents],
  depth: 3,
  indent: auto,
)

#pagebreak()

= Introduction

== Historical Background

Markov chains are named after the Russian mathematician *Andrey Markov* (1856-1922), who first studied them in the early 20th century. In 1906, Markov published his groundbreaking paper introducing what we now call Markov chains. His work was motivated by a disagreement with Pavel Nekrasov, who claimed that independence was necessary for the law of large numbers to hold.

Markov demonstrated that the weak law of large numbers could hold for dependent random variables, provided they satisfied certain conditions—what we now call the Markov property. He famously applied his theory to analyze the distribution of vowels and consonants in Alexander Pushkin's novel _Eugene Onegin_.

#align(center)[
  #table(
    columns: (1fr, 2fr),
    align: (left, left),
    [*Year*], [*Milestone*],
    [1906], [Markov publishes first paper on Markov chains],
    [1912], [Henri Poincaré studies Markov chains on finite groups],
    [1928], [Maurice Fréchet's detailed study],
    [1931], [Andrey Kolmogorov develops continuous-time theory],
    [1948], [Claude Shannon applies to information theory],
    [Present], [Widespread applications in ML, finance, biology],
  )
]

== What is a Markov Chain?

A *Markov chain* is a stochastic (random) process that satisfies the *Markov property*: the probability of transitioning to the next state depends only on the current state and not on the sequence of states that preceded it. This "memoryless" property is the defining characteristic of Markov chains.

#block(
  fill: rgb("#e8f4f8"),
  inset: 10pt,
  radius: 4pt,
)[
  *The Markov Property (Informal):* "The future is independent of the past, given the present."

  *Mathematical Definition:*
  $ P(X_(n+1) = x | X_0 = x_0, X_1 = x_1, ..., X_n = x_n) = P(X_(n+1) = x | X_n = x_n) $
]

== Key Terminology

- *State Space (S)*: The set of all possible states the system can be in
- *Transition*: A change from one state to another
- *Transition Probability*: The probability of moving from state $i$ to state $j$
- *Transition Matrix (P)*: A matrix containing all transition probabilities
- *Initial Distribution*: The probability distribution over states at time $t = 0$

#pagebreak()

= Types of Markov Chains

== Classification by Time Parameter

#table(
  columns: (1fr, 2fr),
  align: (center, left),
  [*Type*], [*Description*],
  [*Discrete-Time Markov Chain (DTMC)*], [State changes occur at discrete time steps (e.g., $t = 0, 1, 2, ...$)],
  [*Continuous-Time Markov Chain (CTMC)*], [State changes can occur at any time (continuous parameter)],
)

== Classification by State Space

#table(
  columns: (1fr, 2fr),
  align: (center, left),
  [*Type*], [*Description*],
  [*Finite State Space*], [Countable and finite number of states],
  [*Countably Infinite*], [States can be enumerated (e.g., $ℕ$)],
  [*Continuous State Space*], [Uncountable state space (e.g., $ℝ$)],
)

#pagebreak()

= Mathematical Foundations

== Formal Definition: Discrete-Time Markov Chain

A *discrete-time Markov chain* is a sequence of random variables $X_0, X_1, X_2, ...$ with the Markov property:

$ P(X_(n+1) = j | X_n = i, X_(n-1) = i_(n-1), ..., X_0 = i_0) = P(X_(n+1) = j | X_n = i) $

where both conditional probabilities are well-defined.

=== Time-Homogeneous Markov Chains

A Markov chain is *time-homogeneous* (or *stationary*) if the transition probabilities are independent of time:

$ P(X_(n+1) = j | X_n = i) = P(X_1 = j | X_0 = i) = p_(i j) $

for all $n ≥ 0$.

== Transition Matrix

For a finite state space $S = {1, 2, ..., N}$, the *transition matrix* $P$ is an $N × N$ matrix where:

$
  P = mat(
    p_(11), p_(12), ..., p_(1 N);
    p_(21), p_(22), ..., p_(2 N);
    dots.v, dots.v, dots.down, dots.v;
    p_(N 1), p_(N 2), ..., p_(N N)
  )
$

=== Properties of Transition Matrix

#block(
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  1. *Non-negativity*: $p_(i j) ≥ 0$ for all $i, j$

  2. *Row Stochastic*: Each row sums to 1:
    $ sum_(j=1)^N p_(i j) = 1 quad "for all" i $

  3. *n-Step Transition Probability*:
     $ P^n = underbrace(P · P · ... · P, n "times") $

  4. *Chapman-Kolmogorov Equation*:
     $ p_(i j)^((n+m)) = sum_(k=1)^N p_(i k)^((n)) p_(k j)^((m)) $
]

=== Detailed Derivation: n-Step Transition Probabilities

The $n$-step transition probability $p_(i j)^((n))$ is the probability of being in state $j$ after exactly $n$ steps, starting from state $i$.

*Base Cases:*
- *n = 0:* $p_(i j)^((0)) = cases(1 "if" i = j, 0 "if" i ≠ j)$ (identity matrix)
- *n = 1:* $p_(i j)^((1)) = p_(i j)$ (one-step transition)

*Recursive Formula:*
$ p_(i j)^((n+1)) = sum_(k=1)^N p_(i k)^((n)) p_(k j) $

*Proof by Induction:*

*Base case (n=1):* Already have $p_(i j)^((1)) = p_(i j)$ ✓

*Inductive step:* Assume $P^n$ gives $n$-step probabilities. Show $P^(n+1) = P^n · P$.

By law of total probability:
$ p_(i j)^((n+1)) = P(X_(n+1) = j | X_0 = i) $
$ = sum_(k=1)^N P(X_(n+1) = j, X_n = k | X_0 = i) $
$ = sum_(k=1)^N P(X_(n+1) = j | X_n = k, X_0 = i) · P(X_n = k | X_0 = i) $

By Markov property:
$ = sum_(k=1)^N P(X_(n+1) = j | X_n = k) · P(X_n = k | X_0 = i) $
$ = sum_(k=1)^N p_(k j) · p_(i k)^((n)) = sum_(k=1)^N p_(i k)^((n)) p_(k j) $

This is exactly the $(i,j)$ entry of the matrix product $P^n · P = P^(n+1)$. □

*Matrix Power Interpretation:*

#table(
  columns: (auto, auto, auto),
  align: center,
  [*Matrix Power*], [*Meaning*], [*Calculation*],
  [$P^0$], [Identity (no steps)], [$I$],
  [$P^1$], [One-step transitions], [$P$],
  [$P^2$], [Two-step transitions], [$P · P$],
  [$P^3$], [Three-step transitions], [$P^2 · P$],
  [$P^n$], [$n$-step transitions], [$P^(n-1) · P$],
)

*Example: Computing $P^3$ for 2×2 Matrix*

Let $P = mat(0.7, 0.3; 0.4, 0.6)$

*Step 1: Compute $P^2$*
$ P^2 = mat(0.7, 0.3; 0.4, 0.6) mat(0.7, 0.3; 0.4, 0.6) $

Entry $(1,1)$: $0.7 × 0.7 + 0.3 × 0.4 = 0.49 + 0.12 = 0.61$
Entry $(1,2)$: $0.7 × 0.3 + 0.3 × 0.6 = 0.21 + 0.18 = 0.39$
Entry $(2,1)$: $0.4 × 0.7 + 0.6 × 0.4 = 0.28 + 0.24 = 0.52$
Entry $(2,2)$: $0.4 × 0.3 + 0.6 × 0.6 = 0.12 + 0.36 = 0.48$

$ P^2 = mat(0.61, 0.39; 0.52, 0.48) $

*Step 2: Compute $P^3 = P^2 · P$*
$ P^3 = mat(0.61, 0.39; 0.52, 0.48) mat(0.7, 0.3; 0.4, 0.6) $

Entry $(1,1)$: $0.61 × 0.7 + 0.39 × 0.4 = 0.427 + 0.156 = 0.583$
Entry $(1,2)$: $0.61 × 0.3 + 0.39 × 0.6 = 0.183 + 0.234 = 0.417$
Entry $(2,1)$: $0.52 × 0.7 + 0.48 × 0.4 = 0.364 + 0.192 = 0.556$
Entry $(2,2)$: $0.52 × 0.3 + 0.48 × 0.6 = 0.156 + 0.288 = 0.444$

$ P^3 = mat(0.583, 0.417; 0.556, 0.444) $

*Interpretation Table:*

#table(
  columns: 5,
  align: center,
  [*Steps*], [$p_(11)^((n))$], [$p_(12)^((n))$], [$p_(21)^((n))$], [$p_(22)^((n))$],
  [0], [1.000], [0.000], [0.000], [1.000],
  [1], [0.700], [0.300], [0.400], [0.600],
  [2], [0.610], [0.390], [0.520], [0.480],
  [3], [0.583], [0.417], [0.556], [0.444],
  [4], [0.575], [0.425], [0.567], [0.433],
  [∞], [0.571], [0.429], [0.571], [0.429],
)

Notice convergence to stationary distribution!=== Chapman-Kolmogorov Equation: Detailed Derivation

The Chapman-Kolmogorov equation is fundamental to Markov chain theory. It states that the probability of going from state $i$ to state $j$ in $n+m$ steps equals the sum over all intermediate states $k$ of going from $i$ to $k$ in $n$ steps, then from $k$ to $j$ in $m$ steps.

*Theorem:* For a Markov chain with transition probabilities $p_(i j)$:
$ p_(i j)^((n+m)) = sum_(k∈S) p_(i k)^((n)) p_(k j)^((m)) $

*Proof:*

By definition:
$ p_(i j)^((n+m)) = P(X_(n+m) = j | X_0 = i) $

Using the law of total probability, we condition on the state at time $n$:
$ p_(i j)^((n+m)) = sum_(k∈S) P(X_(n+m) = j, X_n = k | X_0 = i) $

By conditional probability:
$ = sum_(k∈S) P(X_(n+m) = j | X_n = k, X_0 = i) · P(X_n = k | X_0 = i) $

*Key step* - Apply Markov property:
$ P(X_(n+m) = j | X_n = k, X_0 = i) = P(X_(n+m) = j | X_n = k) $

The future state $X_(n+m)$ depends only on $X_n = k$, not on how we got to $k$.

Therefore:
$ p_(i j)^((n+m)) = sum_(k∈S) P(X_(n+m) = j | X_n = k) · P(X_n = k | X_0 = i) $
$ = sum_(k∈S) P(X_m = j | X_0 = k) · P(X_n = k | X_0 = i) $
$ = sum_(k∈S) p_(k j)^((m)) · p_(i k)^((n)) $
$ = sum_(k∈S) p_(i k)^((n)) p_(k j)^((m)) $ □

*Matrix Interpretation:*

In matrix form: $P^((n+m)) = P^((n)) · P^((m))$

This is just matrix multiplication! The $(i,j)$ entry is:
$ (P^((n)) · P^((m)))_(i j) = sum_k (P^((n)))_(i k) (P^((m)))_(k j) = sum_k p_(i k)^((n)) p_(k j)^((m)) $

*Example Application:*

For the weather model with $P = mat(0.7, 0.3; 0.5, 0.5)$, verify Chapman-Kolmogorov for $n=1, m=1$:

$ p_("SS")^((2)) = sum_(k∈{S,R}) p_("S"k)^((1)) p_(k"S")^((1)) $
$ = p_("SS")^((1)) p_("SS")^((1)) + p_("SR")^((1)) p_("RS")^((1)) $
$ = (0.7)(0.7) + (0.3)(0.5) $
$ = 0.49 + 0.15 = 0.64 $ ✓

*Graphical Representation:*

#align(center)[
  #diagram(
    spacing: 2.5cm,
    node-stroke: 1pt,
    edge-stroke: 1pt,
    node((0, 0), [$i$\ $t=0$], name: <i>, radius: 0.8cm),
    node((2.5, 1), [$k_1$], name: <k1>, radius: 0.6cm),
    node((2.5, 0), [$k_2$], name: <k2>, radius: 0.6cm),
    node((2.5, -1), [$k_3$], name: <k3>, radius: 0.6cm),
    node((5, 0), [$j$\ $t=n+m$], name: <j>, radius: 0.8cm),

    edge(<i>, <k1>, "->", label: $p_(i k_1)^((n))$),
    edge(<i>, <k2>, "->", label: $p_(i k_2)^((n))$),
    edge(<i>, <k3>, "->", label: $p_(i k_3)^((n))$),
    edge(<k1>, <j>, "->", label: $p_(k_1 j)^((m))$),
    edge(<k2>, <j>, "->", label: $p_(k_2 j)^((m))$),
    edge(<k3>, <j>, "->", label: $p_(k_3 j)^((m))$),
  )
]

The total probability is the sum over all possible intermediate states:
$
  p_(i j)^((n+m)) = p_(i k_1)^((n)) p_(k_1 j)^((m)) + p_(i k_2)^((n)) p_(k_2 j)^((m)) + p_(i k_3)^((n)) p_(k_3 j)^((m)) + ...
$

#pagebreak()

== Initial Distribution

The *initial distribution* $π^((0))$ is a row vector specifying the probability of starting in each state:

$ π^((0)) = [π_1^((0)), π_2^((0)), ..., π_N^((0))] $

where:
- $π_i^((0)) = P(X_0 = i)$
- $sum_(i=1)^N π_i^((0)) = 1$

The distribution at time $n$ is:
$ π^((n)) = π^((0)) P^n $

#pagebreak()

= Examples and Applications

== How to Construct Markov Chain State Machines

Creating a state machine diagram is essential for visualizing Markov chains. Follow this systematic approach:

=== Step-by-Step Construction Process

*Step 1: Identify the State Space*

Determine all possible states the system can occupy.

*Questions to ask:*
- What are the distinct configurations/conditions?
- Are states discrete or continuous?
- Is the state space finite or infinite?

*Example:* Weather model → States: {Sunny, Rainy}

*Step 2: Define Transition Probabilities*

For each state $i$, determine:
- Which states $j$ can be reached in one step?
- What is $p_(i j)$ for each reachable state?

*Constraint:* $sum_j p_(i j) = 1$ for all $i$

*Step 3: Draw the State Diagram*

*Components:*
- *Nodes (circles):* Represent states
- *Directed edges (arrows):* Represent transitions
- *Edge labels:* Transition probabilities
- *Self-loops:* Transitions from state to itself

*Step 4: Construct Transition Matrix*

Organize probabilities in matrix form where:
- Rows = current state
- Columns = next state
- Entry $(i,j)$ = $p_(i j)$

*Step 5: Verify*

Check that:
1. All row sums equal 1
2. All entries are non-negative
3. Diagram matches matrix

=== Detailed Example: Card Game

*Problem:* A player has 3 cards. Each round:
- If holding 1 card: gain a card with prob 0.6, lose it with prob 0.4
- If holding 2 cards: gain one (prob 0.5), lose one (prob 0.3), stay same (prob 0.2)
- If holding 3 cards: lose one with prob 0.7, keep all with prob 0.3
- If holding 0 cards: game over (absorbing)

*Step 1: State Space*
$ S = {0, 1, 2, 3} $
States represent number of cards held.

*Step 2: Transition Probabilities*

From state 0 (no cards):
- $p_(00) = 1$ (absorbing)

From state 1 (one card):
- $p_(10) = 0.4$ (lose the card)
- $p_(12) = 0.6$ (gain a card)

From state 2 (two cards):
- $p_(21) = 0.3$ (lose one)
- $p_(22) = 0.2$ (stay same)
- $p_(23) = 0.5$ (gain one)

From state 3 (three cards):
- $p_(32) = 0.7$ (lose one)
- $p_(33) = 0.3$ (keep all)

*Verification:*
- State 0: $1.0 = 1$ ✓
- State 1: $0.4 + 0.6 = 1$ ✓
- State 2: $0.3 + 0.2 + 0.5 = 1$ ✓
- State 3: $0.7 + 0.3 = 1$ ✓

*Step 3: State Diagram*

#align(center)[
  #diagram(
    spacing: 2cm,
    node-stroke: 1pt,
    edge-stroke: 1pt,
    node((0, 0), [*0*\ Game\ Over], name: <0>, radius: 0.9cm, fill: rgb("#ffcccc")),
    node((2.5, 0), [1\ Card], name: <1>, radius: 0.8cm),
    node((5, 0), [2\ Cards], name: <2>, radius: 0.8cm),
    node((7.5, 0), [3\ Cards], name: <3>, radius: 0.8cm),
    
    edge(<1>, <0>, "->", label: "0.4", bend: 20deg),
    edge(<1>, <2>, "->", label: "0.6", bend: 20deg),
    edge(<2>, <1>, "->", label: "0.3", bend: 20deg),
    edge(<2>, <3>, "->", label: "0.5", bend: 20deg),
    edge(<3>, <2>, "->", label: "0.7", bend: 20deg),
    edge(<0>, <0>, "->", label: "1.0", bend: 130deg, loop-angle: 180deg),
    edge(<2>, <2>, "->", label: "0.2", bend: 130deg, loop-angle: 90deg),
    edge(<3>, <3>, "->", label: "0.3", bend: -130deg, loop-angle: 0deg),
  )
]

*Step 4: Transition Matrix*

$ P = mat(
  1, 0, 0, 0;
  0.4, 0, 0.6, 0;
  0, 0.3, 0.2, 0.5;
  0, 0, 0.7, 0.3
) $

#table(
  columns: 5,
  align: center,
  [From \ To], [*0*], [*1*], [*2*], [*3*],
  [*0*], [1.0], [0], [0], [0],
  [*1*], [0.4], [0], [0.6], [0],
  [*2*], [0], [0.3], [0.2], [0.5],
  [*3*], [0], [0], [0.7], [0.3],
)

*Step 5: Analysis*

*Properties:*
- State 0 is absorbing (once game over, stays over)
- States 1, 2, 3 are transient (eventually reach 0)
- Chain is not irreducible (can't leave state 0)
- States 1, 2, 3 are aperiodic (have different periods)

*Key Questions:*
1. Probability of game ending from state 2?
2. Expected number of rounds from state 3?

These can be answered using absorbing chain theory!

=== Common State Machine Patterns

*Pattern 1: Cyclic Chain*
States form a cycle: $0 → 1 → 2 → ... → N → 0$

Used for: Periodic processes, round-robin scheduling

*Pattern 2: Birth-Death Chain*
Can only move to adjacent states: $i → i±1$

Used for: Queues, population dynamics

*Pattern 3: Random Walk*
Symmetric movement: $P(i → i+1) = P(i → i-1) = 0.5$

Used for: Brownian motion, stock prices

*Pattern 4: Absorbing Chain*
One or more absorbing states with transient states leading to them

Used for: Games, bankruptcy models, machine failure

== Example 1: Two-State Weather Model

Consider a simplified weather model with two states: Sunny (S) and Rainy (R).

#align(center)[
  #diagram(
    node-stroke: 1pt,
    edge-stroke: 1pt,
    node((0, 0), [Sunny], name: <s>, radius: 1.5cm),
    node((3, 0), [Rainy], name: <r>, radius: 1.5cm),
    edge(<s>, <r>, "->", label: "0.3", bend: 20deg),
    edge(<r>, <s>, "->", label: "0.5", bend: 20deg),
    edge(<s>, <s>, "->", label: "0.7", bend: 130deg),
    edge(<r>, <r>, "->", label: "0.5", bend: -130deg),
  )
]

*Interpretation:*
- If today is sunny, there's a 70% chance tomorrow will be sunny
- If today is rainy, there's a 50% chance tomorrow will be rainy

*Transition Matrix:*
$
  P = mat(
    0.7, 0.3;
    0.5, 0.5
  )
$

=== Computing Future Probabilities

If today is sunny, what's the probability it will be sunny in 2 days?

$ P^2 = mat(0.7, 0.3; 0.5, 0.5) mat(0.7, 0.3; 0.5, 0.5) = mat(0.64, 0.36; 0.60, 0.40) $

The probability is $p_("SS")^((2)) = 0.64 = 64%$.

*Detailed Calculation:*
$ p_("SS")^((2)) = p_("SS") · p_("SS") + p_("SR") · p_("RS") $
$ = (0.7)(0.7) + (0.3)(0.5) = 0.49 + 0.15 = 0.64 $

*Path Interpretation:*
#align(center)[
  #diagram(
    spacing: 3cm,
    node-stroke: 1pt,
    edge-stroke: 1pt,
    node((0, 0), [Sunny\ Day 0], name: <s0>, radius: 1cm),
    node((3, 1), [Sunny\ Day 1], name: <s1>, radius: 1cm),
    node((3, -1), [Rainy\ Day 1], name: <r1>, radius: 1cm),
    node((6, 0), [Sunny\ Day 2], name: <s2>, radius: 1cm),

    edge(<s0>, <s1>, "->", label: "0.7"),
    edge(<s0>, <r1>, "->", label: "0.3"),
    edge(<s1>, <s2>, "->", label: "0.7"),
    edge(<r1>, <s2>, "->", label: "0.5"),
  )
]

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  [*Path*], [*States*], [*Probability*], [*Contribution*],
  [Path 1], [S → S → S], [0.7 × 0.7 = 0.49], [49%],
  [Path 2], [S → R → S], [0.3 × 0.5 = 0.15], [15%],
  [*Total*], [], [], [*64%*],
)

*n-Step Transition Probabilities:*

#table(
  columns: (auto, auto, auto, auto, auto),
  align: center,
  [*Steps (n)*], [$P^n_(S S)$], [$P^n_(S R)$], [$P^n_(R S)$], [$P^n_(R R)$],
  [0], [1.000], [0.000], [0.000], [1.000],
  [1], [0.700], [0.300], [0.500], [0.500],
  [2], [0.640], [0.360], [0.600], [0.400],
  [3], [0.628], [0.372], [0.620], [0.380],
  [5], [0.6256], [0.3744], [0.6240], [0.3760],
  [10], [0.62502], [0.37498], [0.62497], [0.37503],
  [∞], [0.625], [0.375], [0.625], [0.375],
)

#pagebreak()

== Example 2: Random Walk

A particle moves on the integers ${0, 1, 2, 3, 4}$ with:
- From state $i$ (where $1 ≤ i ≤ 3$): move to $i+1$ with probability 0.5, to $i-1$ with probability 0.5
- States 0 and 4 are *absorbing states* (once reached, never leave)

#align(center)[
  #diagram(
    spacing: 2cm,
    node-stroke: 1pt,
    edge-stroke: 1pt,
    node((0, 0), $0$, name: <0>, radius: 0.8cm),
    node((1.5, 0), $1$, name: <1>, radius: 0.8cm),
    node((3, 0), $2$, name: <2>, radius: 0.8cm),
    node((4.5, 0), $3$, name: <3>, radius: 0.8cm),
    node((6, 0), $4$, name: <4>, radius: 0.8cm),

    edge(<1>, <0>, "->", label: "0.5", bend: 20deg),
    edge(<1>, <2>, "->", label: "0.5", bend: 20deg),
    edge(<2>, <1>, "->", label: "0.5", bend: 20deg),
    edge(<2>, <3>, "->", label: "0.5", bend: 20deg),
    edge(<3>, <2>, "->", label: "0.5", bend: 20deg),
    edge(<3>, <4>, "->", label: "0.5", bend: 20deg),
    edge(<0>, <0>, "->", label: "1", bend: 130deg),
    edge(<4>, <4>, "->", label: "1", bend: -130deg),
  )
]

*Transition Matrix:*
$
  P = mat(
    1, 0, 0, 0, 0;
    0.5, 0, 0.5, 0, 0;
    0, 0.5, 0, 0.5, 0;
    0, 0, 0.5, 0, 0.5;
    0, 0, 0, 0, 1
  )
$

#pagebreak()

== Example 3: PageRank Algorithm

Google's PageRank algorithm uses Markov chains to rank web pages. Each webpage is a state, and transition probabilities are based on hyperlinks between pages.

Key idea:
- A page is important if it is linked to by other important pages
- Random surfer model: follow links randomly or jump to random page

The PageRank of page $i$ is:
$ "PageRank"(i) = (1-d)/N + d sum_(j→i) ("PageRank"(j))/(L(j)) $

where:
- $d$ ≈ 0.85 is the damping factor
- $N$ is total number of pages
- $L(j)$ is number of outgoing links from page $j$

#pagebreak()

= Properties of States

== Accessibility and Communication

#block(
  fill: rgb("#f0f0f0"),
  inset: 10pt,
  radius: 4pt,
)[
  *Definition:* State $j$ is *accessible* from state $i$ (written $i → j$) if there exists $n ≥ 0$ such that $p_(i j)^((n)) > 0$.

  *Definition:* States $i$ and $j$ *communicate* (written $i ↔ j$) if $i → j$ and $j → i$.
]

Communication is an equivalence relation:
- *Reflexive*: $i ↔ i$
- *Symmetric*: If $i ↔ j$, then $j ↔ i$
- *Transitive*: If $i ↔ j$ and $j ↔ k$, then $i ↔ k$

=== Communicating Classes: Detailed Analysis

The state space can be partitioned into *communicating classes*—maximal sets of states that communicate with each other.

*Definition:* A communicating class $C$ is a set of states where:
1. All states in $C$ communicate with each other
2. No state in $C$ communicates with any state outside $C$

*Finding Communicating Classes: Step-by-Step*

*Algorithm:*
1. Start with any state $i$
2. Find all states accessible from $i$
3. Find all states from which $i$ is accessible
4. The intersection forms a communicating class
5. Repeat for uncategorized states

*Example 1: Identifying Classes*

Consider the transition matrix:
$ P = mat(
  0.5, 0.5, 0, 0, 0;
  0.3, 0.7, 0, 0, 0;
  0, 0, 0.6, 0.4, 0;
  0, 0, 0.3, 0.7, 0;
  0.1, 0, 0, 0, 0.9
) $

*Step 1: Build accessibility table*

#table(
  columns: 6,
  align: center,
  [From \ To], [*0*], [*1*], [*2*], [*3*], [*4*],
  [*0*], [✓], [✓], [✗], [✗], [✗],
  [*1*], [✓], [✓], [✗], [✗], [✗],
  [*2*], [✗], [✗], [✓], [✓], [✗],
  [*3*], [✗], [✗], [✓], [✓], [✗],
  [*4*], [✓], [✗], [✗], [✗], [✓],
)

*Step 2: Identify classes*

*Class 1:* ${0, 1}$
- 0 ↔ 1 (can reach each other)
- Cannot reach states 2, 3, 4

*Class 2:* ${2, 3}$
- 2 ↔ 3 (can reach each other)
- Cannot reach other states

*Class 3:* ${4}$
- State 4 can reach state 0, but 0 cannot reach 4
- Forms its own class (transient)

*Step 3: Classify classes*

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  [*Class*], [*States*], [*Type*], [*Reason*],
  [Class 1], [{0, 1}], [Closed], [No exits possible],
  [Class 2], [{2, 3}], [Closed], [No exits possible],
  [Class 3], [{4}], [Transient], [Can exit to Class 1],
)

*State Diagram:*

#align(center)[
  #diagram(
    spacing: 2.5cm,
    node-stroke: 1pt,
    edge-stroke: 1pt,
    
    // Class 1
    node((0, 1), $0$, name: <0>, radius: 0.6cm, stroke: rgb("#0066cc") + 2pt),
    node((1.5, 1), $1$, name: <1>, radius: 0.6cm, stroke: rgb("#0066cc") + 2pt),
    
    // Class 2  
    node((0, -1), $2$, name: <2>, radius: 0.6cm, stroke: rgb("#cc0066") + 2pt),
    node((1.5, -1), $3$, name: <3>, radius: 0.6cm, stroke: rgb("#cc0066") + 2pt),
    
    // Class 3
    node((3.5, 0), $4$, name: <4>, radius: 0.6cm, stroke: rgb("#00aa00") + 2pt),
    
    // Edges within Class 1
    edge(<0>, <1>, "->", label: "0.5", bend: -20deg),
    edge(<1>, <0>, "->", label: "0.3", bend: -20deg),
    edge(<0>, <0>, "->", label: "0.5", bend: 130deg, loop-angle: 180deg),
    edge(<1>, <1>, "->", label: "0.7", bend: -130deg, loop-angle: 0deg),
    
    // Edges within Class 2
    edge(<2>, <3>, "->", label: "0.4", bend: -20deg),
    edge(<3>, <2>, "->", label: "0.3", bend: -20deg),
    edge(<2>, <2>, "->", label: "0.6", bend: 130deg, loop-angle: 180deg),
    edge(<3>, <3>, "->", label: "0.7", bend: -130deg, loop-angle: 0deg),
    
    // Edges from Class 3
    edge(<4>, <0>, "->", label: "0.1", bend: 20deg),
    edge(<4>, <4>, "->", label: "0.9", bend: 130deg, loop-angle: 90deg),
  )
]

*Example 2: Reducible vs Irreducible*

*Reducible Chain:* Has multiple communicating classes

The chain above is reducible (3 classes).

*Irreducible Chain:* Only one communicating class (all states communicate)

$ P = mat(
  0, 1, 0;
  0, 0, 1;
  1, 0, 0
) $

All states form one class: ${0, 1, 2}$
- 0 → 1 → 2 → 0 (cycle)
- All states can reach all others

*Closed Classes and Absorption*

*Definition:* A communicating class $C$ is *closed* if:
$ p_(i j) = 0 quad "for all" i ∈ C, j ∉ C $

Once the chain enters a closed class, it never leaves!

*Theorem:* Every finite Markov chain has at least one closed communicating class.

*Long-term Behavior:*
- Chain will eventually be absorbed into one of the closed classes
- Probability of absorption depends on initial state and transition probabilities

== Irreducibility

#block(
  fill: rgb("#e8f4f8"),
  inset: 10pt,
  radius: 4pt,
)[
  A Markov chain is *irreducible* if all states communicate with each other. In other words, there is only one communicating class.
]

*Example of Irreducible Chain:*
$ P = mat(0, 1, 0; 0.5, 0, 0.5; 0, 1, 0) $

All states are mutually accessible.

== Periodicity

#block(
  fill: rgb("#f0f0f0"),
  inset: 10pt,
  radius: 4pt,
)[
  The *period* of state $i$ is:
  $ d(i) = gcd{n ≥ 1 : p_(i i)^((n)) > 0} $

  - If $d(i) = 1$, state $i$ is *aperiodic*
  - If $d(i) > 1$, state $i$ is *periodic* with period $d(i)$
]

*Example of Periodic Chain:*

#align(center)[
  #diagram(
    spacing: 2cm,
    node-stroke: 1pt,
    node((0, 0), $0$, name: <0>, radius: 0.6cm),
    node((1.5, 0), $1$, name: <1>, radius: 0.6cm),
    node((3, 0), $2$, name: <2>, radius: 0.6cm),
    edge(<0>, <1>, "->", label: "1"),
    edge(<1>, <2>, "->", label: "1"),
    edge(<2>, <0>, "->", label: "1"),
  )
]

This chain has period 3 (returns to state 0 only at steps 3, 6, 9, ...).

#pagebreak()

== Recurrence and Transience

#block(
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  *Definition:* Let $f_(i i)$ be the probability that the chain ever returns to state $i$, starting from $i$.

  - State $i$ is *recurrent* if $f_(i i) = 1$
  - State $i$ is *transient* if $f_(i i) < 1$
]

=== Classification of Recurrent States

#table(
  columns: (1fr, 2fr),
  align: (center, left),
  [*Type*], [*Definition*],
  [*Positive Recurrent*], [Expected return time is finite: $E[T_i] < ∞$],
  [*Null Recurrent*], [Expected return time is infinite: $E[T_i] = ∞$],
)

where $T_i$ is the first return time to state $i$.

*Key Result:* For finite-state Markov chains, all recurrent states are positive recurrent.

== Absorbing States

#block(
  fill: rgb("#f0f0f0"),
  inset: 10pt,
  radius: 4pt,
)[
  *Definition:* State $i$ is *absorbing* if $p_(i i) = 1$ (once entered, never left).
]

An absorbing state is:
- Recurrent (obviously returns with probability 1)
- Aperiodic (period = 1)

#pagebreak()

= Stationary Distributions

== Definition

#block(
  fill: rgb("#e8f4f8"),
  inset: 10pt,
  radius: 4pt,
)[
  A probability distribution $π = [π_1, π_2, ..., π_N]$ is a *stationary distribution* (or *steady-state distribution*) if:

  $ π P = π $

  Equivalently, $π$ is a left eigenvector of $P$ with eigenvalue 1.
]

=== Properties

1. If $X_0 ∼ π$, then $X_n ∼ π$ for all $n ≥ 0$
2. $sum_(i=1)^N π_i = 1$
3. $π_i ≥ 0$ for all $i$

== Existence and Uniqueness

#block(
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  *Theorem:* An irreducible, aperiodic Markov chain with a finite state space has a unique stationary distribution $π$.

  Furthermore:
  $
    lim_(n→∞) P^n = mat(
      π_1, π_2, ..., π_N;
      π_1, π_2, ..., π_N;
      dots.v, dots.v, dots.down, dots.v;
      π_1, π_2, ..., π_N
    )
  $
]

== Computing Stationary Distributions

This section presents four comprehensive methods for finding stationary distributions, each with complete derivations and examples.

=== Method 1: Direct Linear System Solution

*Mathematical Foundation:*

The stationary distribution $π$ satisfies:
1. Balance equation: $π P = π$
2. Normalization: $sum_(i=1)^N π_i = 1$

*Complete Algorithm:*

#block(
  fill: rgb("#f0f8ff"),
  inset: 10pt,
  radius: 4pt,
)[
  *Step 1:* Write out the balance equations
  $ π_j = sum_(i=1)^N π_i p_(i j) quad "for all" j = 1, 2, ..., N $

  *Step 2:* Expand the system
  $
    cases(
      π_1 p_(11) + π_2 p_(21) + ... + π_N p_(N 1) = π_1,
      π_1 p_(12) + π_2 p_(22) + ... + π_N p_(N 2) = π_2,
      dots.v,
      π_1 p_(1 N) + π_2 p_(2 N) + ... + π_N p_(N N) = π_N
    )
  $

  *Step 3:* Rearrange to homogeneous form
  $
    cases(
      π_1 (p_(11) - 1) + π_2 p_(21) + ... + π_N p_(N 1) = 0,
      π_1 p_(12) + π_2 (p_(22) - 1) + ... + π_N p_(N 2) = 0,
      dots.v,
      π_1 p_(1 N) + π_2 p_(2 N) + ... + π_N (p_(N N) - 1) = 0
    )
  $

  *Step 4:* Replace one equation with $sum_i π_i = 1$

  *Step 5:* Solve the resulting linear system
]

*Detailed Example - 3-State Chain:*

Consider:
$ P = mat(0.5, 0.3, 0.2; 0.4, 0.4, 0.2; 0.3, 0.3, 0.4) $

*Step-by-step solution:*

Balance equations:
$
  cases(
    0.5 π_1 + 0.4 π_2 + 0.3 π_3 = π_1,
    0.3 π_1 + 0.4 π_2 + 0.3 π_3 = π_2,
    0.2 π_1 + 0.2 π_2 + 0.4 π_3 = π_3
  )
$

Rearranging:
$
  cases(
    -0.5 π_1 + 0.4 π_2 + 0.3 π_3 = 0,
    0.3 π_1 - 0.6 π_2 + 0.3 π_3 = 0,
    0.2 π_1 + 0.2 π_2 - 0.6 π_3 = 0
  )
$

Using equations 1 and 2 with normalization:
From equation 1: $π_1 = (0.4 π_2 + 0.3 π_3)/(0.5) = 0.8 π_2 + 0.6 π_3$

From equation 2: $0.3 π_1 = 0.6 π_2 - 0.3 π_3$
$π_1 = 2 π_2 - π_3$

Equating: $0.8 π_2 + 0.6 π_3 = 2 π_2 - π_3$
$1.6 π_3 = 1.2 π_2$
$π_3 = 0.75 π_2$

Therefore: $π_1 = 2 π_2 - 0.75 π_2 = 1.25 π_2$

Normalization: $π_1 + π_2 + π_3 = 1$
$1.25 π_2 + π_2 + 0.75 π_2 = 1$
$3 π_2 = 1$
$π_2 = 1/3$

Final solution:
$π = [1.25 · 1/3, 1/3, 0.75 · 1/3] = [5/12, 1/3, 1/4]$

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  [*State*], [*π Value*], [*Decimal*], [*Percentage*],
  [1], [$5/12$], [0.4167], [41.67%],
  [2], [$1/3$], [0.3333], [33.33%],
  [3], [$1/4$], [0.2500], [25.00%],
)

=== Method 2: Eigenvalue/Eigenvector Approach

*Theoretical Foundation:*

The stationary distribution is the left eigenvector of $P$ corresponding to eigenvalue $λ = 1$.

*Complete Derivation:*

#block(
  fill: rgb("#fffacd"),
  inset: 10pt,
  radius: 4pt,
)[
  *Key Insight:* $π P = π$ can be written as $π P = 1 · π$

  This means $π$ is a left eigenvector of $P$ with eigenvalue 1.

  *Equivalently:* Solve $(P^T - I)π^T = 0$

  *Why eigenvalue 1 exists:*
  - $P$ is stochastic: columns sum to 1
  - $(P - I)e = 0$ where $e = [1, 1, ..., 1]^T$
  - So 1 is an eigenvalue of $P$ (right eigenvector $e$)
  - By Perron-Frobenius theorem, for irreducible $P$, the eigenvalue 1 has multiplicity 1
]

*Step-by-step Algorithm:*

1. Form matrix $A = P^T - I$
2. Solve $A π^T = 0$ (find null space)
3. Normalize: $π ← π / (sum_i π_i)$

*Detailed Example - Same 3-State Chain:*

$ P = mat(0.5, 0.3, 0.2; 0.4, 0.4, 0.2; 0.3, 0.3, 0.4) $

*Step 1:* Compute $P^T$:
$ P^T = mat(0.5, 0.4, 0.3; 0.3, 0.4, 0.3; 0.2, 0.2, 0.4) $

*Step 2:* Form $A = P^T - I$:
$ A = mat(-0.5, 0.4, 0.3; 0.3, -0.6, 0.3; 0.2, 0.2, -0.6) $

*Step 3:* Row reduce to find null space:

$
  mat(-0.5, 0.4, 0.3; 0.3, -0.6, 0.3; 0.2, 0.2, -0.6) 
  →
  mat(1, -0.8, -0.6; 0.3, -0.6, 0.3; 0.2, 0.2, -0.6)
$

After row operations:
$
  mat(1, -0.8, -0.6; 0, -0.36, 0.48; 0, 0.36, -0.48)
$

From row 2: $-0.36 π_2 + 0.48 π_3 = 0$
$π_2 = (0.48)/(0.36) π_3 = (4)/(3) π_3$

From row 1: $π_1 = 0.8 π_2 + 0.6 π_3 = 0.8 · (4)/(3) π_3 + 0.6 π_3$
$π_1 = (16)/(15) π_3 + (9)/(15) π_3 = (25)/(15) π_3 = (5)/(3) π_3$

*Step 4:* Normalize with $π_1 + π_2 + π_3 = 1$:
$(5)/(3) π_3 + (4)/(3) π_3 + π_3 = 1$
$(5 + 4 + 3)/(3) π_3 = 1$
$π_3 = 3/12 = 1/4$

Therefore:
$π = [(5)/(3) · 1/4, (4)/(3) · 1/4, 1/4] = [5/12, 1/3, 1/4]$ ✓

#table(
  columns: (auto, auto, auto),
  align: center,
  [*Method*], [*Advantage*], [*Disadvantage*],
  [Direct Linear System], [Intuitive, straightforward], [May have numerical instability],
  [Eigenvalue Approach], [Theoretically elegant], [Requires matrix computation],
)

=== Method 3: Iterative Power Method

*Algorithm Foundation:*

For an irreducible, aperiodic chain: $lim_(n→∞) P^n = mat(π; π; dots.v; π)$

Each row converges to the stationary distribution.

*Complete Algorithm:*

#block(
  fill: rgb("#e6f3ff"),
  inset: 10pt,
  radius: 4pt,
)[
  *Input:* Transition matrix $P$, tolerance $ε$, initial distribution $π^((0))$

  *Iteration:*
  $ π^((k+1)) = π^((k)) P $

  *Stopping criterion:*
  $ ||π^((k+1)) - π^((k))|| < ε $

  *Output:* $π ≈ π^((k))$
]

*Convergence Rate:*

For irreducible, aperiodic chain with eigenvalues $1 = λ_1 > |λ_2| ≥ |λ_3| ≥ ... ≥ |λ_N|$:

$ ||π^((k)) - π|| ≤ C |λ_2|^k $

where $C$ is a constant depending on the initial distribution.

*Detailed Example with Convergence Table:*

Using the same 3-state chain with $π^((0)) = [1, 0, 0]$:

$ P = mat(0.5, 0.3, 0.2; 0.4, 0.4, 0.2; 0.3, 0.3, 0.4) $

*Iteration calculations:*

$k = 1$: $π^((1)) = [1, 0, 0] mat(0.5, 0.3, 0.2; 0.4, 0.4, 0.2; 0.3, 0.3, 0.4) = [0.5, 0.3, 0.2]$

$k = 2$: $π^((2)) = [0.5, 0.3, 0.2] P = [0.43, 0.33, 0.24]$

$k = 3$: $π^((3)) = [0.43, 0.33, 0.24] P = [0.424, 0.330, 0.246]$

$k = 4$: $π^((4)) = [0.424, 0.330, 0.246] P = [0.4196, 0.3326, 0.2478]$

#table(
  columns: (auto, auto, auto, auto, auto),
  align: center,
  [*Iteration k*], [$π_1^((k))$], [$π_2^((k))$], [$π_3^((k))$], [*Max Error*],
  [0], [1.0000], [0.0000], [0.0000], [0.5833],
  [1], [0.5000], [0.3000], [0.2000], [0.0833],
  [2], [0.4300], [0.3300], [0.2400], [0.0133],
  [3], [0.4240], [0.3300], [0.2460], [0.0073],
  [4], [0.4196], [0.3326], [0.2478], [0.0029],
  [5], [0.4177], [0.3329], [0.2494], [0.0010],
  [10], [0.4168], [0.3333], [0.2499], [0.0001],
  [∞], [0.4167], [0.3333], [0.2500], [0.0000],
  [Exact], [$5/12$], [$1/3$], [$1/4$], [-],
)

*Convergence Analysis:*
- Geometric rate of convergence
- Error decreases by factor of approximately $|λ_2| ≈ 0.2$ per iteration
- Practical convergence (error < 0.001) achieved in ~10 iterations

=== Method 4: Detailed Balance Equations (for Reversible Chains)

*Definition of Reversibility:*

#block(
  fill: rgb("#f0fff0"),
  inset: 10pt,
  radius: 4pt,
)[
  A Markov chain is *reversible* with respect to distribution $π$ if:
  $ π_i p_(i j) = π_j p_(j i) quad "for all states" i, j $

  This is called the *detailed balance condition*.

  *Physical Interpretation:* The probability flow from $i$ to $j$ equals the flow from $j$ to $i$ in equilibrium.
]

*Why This Simplifies Computation:*

If detailed balance holds, we can solve $N(N-1)/2$ equations instead of $N$ equations!

*Complete Algorithm for Reversible Chains:*

1. Verify reversibility by checking if $p_(i j)/p_(j i)$ is consistent across paths
2. Choose a reference state (usually state 1)
3. For each state $j$, compute:
   $ π_j = π_1 · product_("path" 1 → j) p_k / p_(k^(-1)) $
4. Normalize: $π_1 = 1 / (1 + sum_(j≠1) π_j / π_1)$

*Detailed Example - Birth-Death Process:*

A birth-death process has:
- Birth rates: $λ_0 = 2, λ_1 = 1.5, λ_2 = 1$
- Death rates: $μ_1 = 1, μ_2 = 1.5, μ_3 = 2$

Transition probabilities (normalizing within each row):
$ P = mat(0, 2/3, 1/3, 0; 1/2.5, 0, 1.5/2.5, 0; 0, 1.5/2.5, 0, 1/2.5; 0, 0, 2/3, 1/3) $

Wait, let me construct this more carefully:

From state 0: can go to 1 with rate $λ_0 = 2$
From state 1: can go to 0 with rate $μ_1 = 1$, or to 2 with rate $λ_1 = 1.5$
Total rate from 1: $μ_1 + λ_1 = 2.5$

*Detailed balance approach:*

For birth-death, detailed balance gives:
$ π_i λ_i = π_(i+1) μ_(i+1) $

Therefore:
$ π_1 = π_0 · (λ_0)/(μ_1) = π_0 · 2/1 = 2 π_0 $

$ π_2 = π_1 · (λ_1)/(μ_2) = 2 π_0 · (1.5)/(1.5) = 2 π_0 $

$ π_3 = π_2 · (λ_2)/(μ_3) = 2 π_0 · 1/2 = π_0 $

*Normalization:*
$ π_0 + π_1 + π_2 + π_3 = 1 $
$ π_0 + 2 π_0 + 2 π_0 + π_0 = 1 $
$ 6 π_0 = 1 $
$ π_0 = 1/6 $

*Final stationary distribution:*
$ π = [1/6, 2/6, 2/6, 1/6] = [1/6, 1/3, 1/3, 1/6] $

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  [*State*], [*π Value*], [*Detailed Balance Verification*], [*Flow Rate*],
  [0], [1/6], [$π_0 λ_0 = 1/6 · 2 = 1/3$], [→1: 1/3],
  [1], [1/3], [$π_1 μ_1 = 1/3 · 1 = 1/3$ ✓], [→0: 1/3],
  [], [], [$π_1 λ_1 = 1/3 · 1.5 = 1/2$], [→2: 1/2],
  [2], [1/3], [$π_2 μ_2 = 1/3 · 1.5 = 1/2$ ✓], [→1: 1/2],
  [], [], [$π_2 λ_2 = 1/3 · 1 = 1/3$], [→3: 1/3],
  [3], [1/6], [$π_3 μ_3 = 1/6 · 2 = 1/3$ ✓], [→2: 1/3],
)

*Summary of Four Methods:*

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  [*Method*], [*Best For*], [*Complexity*], [*Special Requirements*],
  [Direct Linear System], [Small chains (N ≤ 10)], [$O(N^3)$], [None],
  [Eigenvalue Approach], [Theoretical analysis], [$O(N^3)$], [None],
  [Power Iteration], [Large sparse chains], [$O(N^2 k)$], [Aperiodic chain],
  [Detailed Balance], [Reversible chains], [$O(N)$], [Reversibility],
)

*Practical Recommendations:*
1. For small chains: Use direct method or eigenvalue approach
2. For large sparse chains: Use power iteration
3. For birth-death or random walks: Check detailed balance first
4. Always verify solution by checking $π P = π$ and $sum_i π_i = 1$

#pagebreak()

=== Example: Weather Model (Detailed Solution)

For our weather example:
$ P = mat(0.7, 0.3; 0.5, 0.5) $

Solve $π P = π$:
$ [π_S, π_R] mat(0.7, 0.3; 0.5, 0.5) = [π_S, π_R] $

*Step-by-step derivation:*

Expanding the matrix equation:
$
  cases(
    π_S · 0.7 + π_R · 0.5 = π_S,
    π_S · 0.3 + π_R · 0.5 = π_R,
    π_S + π_R = 1
  )
$

From equation 1:
$ 0.7 π_S + 0.5 π_R = π_S $
$ 0.5 π_R = π_S - 0.7 π_S $
$ 0.5 π_R = 0.3 π_S $
$ π_R = (0.3)/(0.5) π_S = (3)/(5) π_S $

Substituting into $π_S + π_R = 1$:
$ π_S + (3)/(5) π_S = 1 $
$ (5)/(5) π_S + (3)/(5) π_S = 1 $
$ (8)/(5) π_S = 1 $
$ π_S = 5/8 = 0.625 $

Therefore:
$ π_R = 1 - π_S = 1 - 5/8 = 3/8 = 0.375 $

*Verification:*
$ [5/8, 3/8] mat(0.7, 0.3; 0.5, 0.5) = [5/8 · 0.7 + 3/8 · 0.5, 5/8 · 0.3 + 3/8 · 0.5] $
$ = [0.4375 + 0.1875, 0.1875 + 0.1875] = [0.625, 0.375] = [5/8, 3/8] ✓ $

#table(
  columns: (auto, auto, auto),
  align: center,
  [*Measure*], [*Sunny*], [*Rainy*],
  [Stationary Prob.], [0.625 (62.5%)], [0.375 (37.5%)],
  [Expected Return Time], [1/0.625 = 1.6 days], [1/0.375 ≈ 2.67 days],
  [Interpretation], [Sunny 5 out of 8 days], [Rainy 3 out of 8 days],
)

*Interpretation:* In the long run, about 62.5% of days are sunny and 37.5% are rainy.

#pagebreak()

= Ergodic Markov Chains

== Definition

#block(
  fill: rgb("#e8f4f8"),
  inset: 10pt,
  radius: 4pt,
)[
  A state is *ergodic* if it is:
  1. Aperiodic
  2. Positive recurrent

  A Markov chain is *ergodic* if all its states are ergodic.
]

== Ergodic Theorem

#block(
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  *Theorem (Ergodic Theorem):* For an irreducible, aperiodic Markov chain with stationary distribution $π$:

  $ lim_(n→∞) p_(i j)^((n)) = π_j quad "for all states" i, j $

  Furthermore:
  $ lim_(N→∞) 1/N sum_(n=1)^N 𝟙{X_n = j} = π_j quad "with probability 1" $
]

This means:
- The proportion of time spent in state $j$ converges to $π_j$
- Long-run average equals the stationary probability

=== Complete Proof of Ergodic Theorem

We prove this fundamental result in several steps, building from basic principles to the full convergence guarantee.

*Proof Strategy:*

The proof relies on three key ideas:
1. Spectral decomposition of the transition matrix
2. Properties of aperiodic, irreducible chains
3. Perron-Frobenius theorem for stochastic matrices

*Step 1: Eigenvalue Structure*

#block(
  fill: rgb("#f0f8ff"),
  inset: 10pt,
  radius: 4pt,
)[
  *Lemma 1:* For an irreducible, aperiodic, finite-state Markov chain with transition matrix $P$:

  1. $λ = 1$ is an eigenvalue with multiplicity 1
  2. All other eigenvalues satisfy $|λ_i| < 1$
  3. The eigenvector corresponding to $λ = 1$ is the stationary distribution $π$

  *Proof sketch:*
  - Irreducibility + aperiodicity ⟹ primitive matrix (by Perron-Frobenius)
  - Primitive stochastic matrix has unique largest eigenvalue 1
  - Left eigenvector for $λ = 1$ is stationary distribution: $π P = π$
]

*Step 2: Spectral Decomposition*

For finite-state chains, we can decompose:

$ P = sum_(i=1)^N λ_i v_i w_i^T $

where $λ_i$ are eigenvalues, $v_i$ right eigenvectors, $w_i$ left eigenvectors.

For our ergodic chain:
$ P = 1 · e π^T + sum_(i=2)^N λ_i v_i w_i^T $

where $e = [1, 1, ..., 1]^T$ and $π$ is the stationary distribution.

Taking $n$-th power:
$ P^n = 1^n · e π^T + sum_(i=2)^N λ_i^n v_i w_i^T = e π^T + sum_(i=2)^N λ_i^n v_i w_i^T $

*Step 3: Convergence to Stationary Distribution*

As $n → ∞$:

$ lim_(n→∞) P^n = lim_(n→∞) [e π^T + sum_(i=2)^N λ_i^n v_i w_i^T] $

Since $|λ_i| < 1$ for $i ≥ 2$ (by Lemma 1):
$ lim_(n→∞) λ_i^n = 0 quad "for all" i ≥ 2 $

Therefore:
$ lim_(n→∞) P^n = e π^T = mat(π_1, π_2, ..., π_N; π_1, π_2, ..., π_N; dots.v, dots.v, dots.down, dots.v; π_1, π_2, ..., π_N) $

This proves:
$ lim_(n→∞) p_(i j)^((n)) = π_j quad "for all" i, j $

*Step 4: Convergence Rate*

The rate of convergence is determined by the second-largest eigenvalue magnitude:

$ ρ = max{|λ_2|, |λ_3|, ..., |λ_N|} $

We can bound the error:

$ |p_(i j)^((n)) - π_j| ≤ C ρ^n $

where $C$ depends on the eigenvector structure.

*Step 5: Time-Average Convergence (SLLN Part)*

#block(
  fill: rgb("#ffe6f0"),
  inset: 10pt,
  radius: 4pt,
)[
  *Theorem (Strong Law for Markov Chains):*

  $ lim_(N→∞) 1/N sum_(n=1)^N 𝟙{X_n = j} = π_j quad "almost surely" $

  *Proof outline:*
  
  Define $V_N(j) = sum_(n=1)^N 𝟙{X_n = j}$ (number of visits to state $j$ by time $N$)

  *Claim:* $V_N(j) / N → π_j$ almost surely

  1. By Markov property:
  $ 𝔼[V_N(j) | X_0 = i] = sum_(n=1)^N p_(i j)^((n)) $

  2. From Step 3, we know $p_(i j)^((n)) → π_j$, so:
  $ lim_(N→∞) (𝔼[V_N(j)])/(N) = lim_(N→∞) 1/N sum_(n=1)^N p_(i j)^((n)) = π_j $

  3. By ergodic theorem for Markov chains (more general than SLLN):
  $ lim_(N→∞) V_N(j)/(N) = π_j quad "almost surely" $

  This uses the fact that for ergodic chains, the empirical distribution converges to the stationary distribution.
]

*Detailed Example: 2-State Weather Model*

Let's verify convergence numerically:

$ P = mat(0.7, 0.3; 0.5, 0.5) $

*Eigenvalue analysis:*

Characteristic polynomial: $det(P - λ I) = 0$
$ det mat(0.7 - λ, 0.3; 0.5, 0.5 - λ) = (0.7 - λ)(0.5 - λ) - 0.15 = 0 $
$ λ^2 - 1.2λ + 0.35 - 0.15 = 0 $
$ λ^2 - 1.2λ + 0.2 = 0 $

Using quadratic formula:
$ λ = (1.2 ± sqrt(1.44 - 0.8))/(2) = (1.2 ± sqrt(0.64))/(2) = (1.2 ± 0.8)/(2) $

So: $λ_1 = 1$, $λ_2 = 0.2$

*Convergence rate:* $ρ = |λ_2| = 0.2$

*Numerical verification:*

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  align: center,
  [*n*], [$p_(S S)^((n))$], [$p_(S R)^((n))$], [$p_(R S)^((n))$], [$p_(R R)^((n))$], [*Max Error*],
  [0], [1.000], [0.000], [0.000], [1.000], [0.3750],
  [1], [0.700], [0.300], [0.500], [0.500], [0.0750],
  [2], [0.640], [0.360], [0.600], [0.400], [0.0150],
  [3], [0.628], [0.372], [0.620], [0.380], [0.0030],
  [5], [0.6256], [0.3744], [0.6240], [0.3760], [0.0006],
  [10], [0.62500], [0.37500], [0.62500], [0.37500], [0.00001],
  [∞], [0.625], [0.375], [0.625], [0.375], [0.000],
  [Exact $π$], [$5/8$], [$3/8$], [$5/8$], [$3/8$], [-],
)

*Error decay verification:*

For $n = 5$: Error $≈ 0.0006 ≈ C · 0.2^5 = C · 0.00032$

The error decreases geometrically with rate $ρ = 0.2$, confirming the theorem.

*Physical interpretation:*
1. After 10 steps, any initial state "forgets" where it started
2. Distribution converges to [0.625, 0.375] regardless of $X_0$
3. Over long runs, spend 62.5% of time sunny, 37.5% rainy
4. Convergence is exponentially fast with rate $0.2^n$

*Key insight:* Aperiodicity ensures smooth convergence (no oscillations), irreducibility ensures all states eventually communicate, leading to unique stationary distribution.

== Convergence Rate

The convergence to stationarity is geometric:

$ ||P^n - π||_"TV" ≤ C ρ^n $

where:
- $|| · ||_"TV"$ is total variation distance
- $ρ < 1$ is the second-largest eigenvalue of $P$
- $C$ is a constant

*Faster convergence* occurs when $ρ$ is small (eigenvalues well-separated).

#pagebreak()

= Absorbing Markov Chains

== Definition

#block(
  fill: rgb("#f0f0f0"),
  inset: 10pt,
  radius: 4pt,
)[
  A Markov chain is *absorbing* if:
  1. It has at least one absorbing state
  2. From every state, it is possible to reach an absorbing state
]

== Canonical Form

An absorbing chain can be written in canonical form:

$
  P = mat(
    Q, R;
    0, I
  )
$

where:
- $Q$: transition probabilities between transient states
- $R$: transition probabilities from transient to absorbing states
- $I$: identity matrix (absorbing states stay put)
- $0$: zero matrix (can't leave absorbing states)

=== How to Construct Canonical Form: Complete Methodology

#block(
  fill: rgb("#f0f8ff"),
  inset: 10pt,
  radius: 4pt,
)[
  *Step-by-Step Algorithm:*

  *Step 1: Identify State Types*
  - Absorbing states: $p_(i i) = 1$
  - Transient states: all others (can eventually reach absorbing states)

  *Step 2: Reorder States*
  - List all transient states first: ${1, 2, ..., t}$
  - Then list absorbing states: ${t+1, t+2, ..., t+a}$
  - Total states: $N = t + a$

  *Step 3: Extract Submatrices*
  - $Q$: $(t × t)$ matrix of transitions between transient states
  - $R$: $(t × a)$ matrix from transient to absorbing states
  - Verify: Each row of $[Q | R]$ sums to 1
  - Bottom blocks: $0$ is $(a × t)$ zero matrix, $I$ is $(a × a)$ identity

  *Step 4: Verify Validity*
  - Check: $Q$ has spectral radius $< 1$ (eigenvalues inside unit circle)
  - Check: $(I - Q)$ is invertible
  - Check: All entries of $(I - Q)^(-1)$ are non-negative
]

*Detailed Example 1: Simple 4-State Absorbing Chain*

Original transition matrix (states ordered 1, 2, 3, 4):

$ P_"original" = mat(
  0.5, 0.3, 0.2, 0;
  0.4, 0, 0.6, 0;
  0, 0, 1, 0;
  0, 0, 0, 1
) $

*Step 1: Identify states*
- Transient: states 1, 2 (can leave)
- Absorbing: states 3, 4 ($p_(33) = p_(44) = 1$)

*Step 2: Already in canonical form!* (transient first, absorbing last)

*Step 3: Extract blocks*

$
  Q = mat(0.5, 0.3; 0.4, 0) quad "(transitions among transient states 1,2)"
$

$
  R = mat(0.2, 0; 0.6, 0) quad "(from transient to absorbing 3,4)"
$

*Verification:*
- Row 1 of $[Q | R]$: $0.5 + 0.3 + 0.2 + 0 = 1$ ✓
- Row 2 of $[Q | R]$: $0.4 + 0 + 0.6 + 0 = 1$ ✓

*Detailed Example 2: Reordering Required*

Original matrix (states A, B, C, D where B and D are absorbing):

#table(
  columns: (auto, auto, auto, auto, auto),
  align: center,
  [], [*A*], [*B*], [*C*], [*D*],
  [*A*], [0.3], [0.4], [0.2], [0.1],
  [*B*], [0], [1], [0], [0],
  [*C*], [0.5], [0.2], [0.1], [0.2],
  [*D*], [0], [0], [0], [1],
)

$ P_"original" = mat(
  0.3, 0.4, 0.2, 0.1;
  0, 1, 0, 0;
  0.5, 0.2, 0.1, 0.2;
  0, 0, 0, 1
) $

*Step 1: Identify*
- Transient: A (state 1), C (state 3)
- Absorbing: B (state 2), D (state 4)

*Step 2: Reorder as (A, C, B, D)*

New state order: $1 → 1, 2 → 3, 3 → 2, 4 → 4$

*Permutation matrix construction:*

To move from old to new order, apply permutation $(1, 3, 2, 4)$:

$ P_"canonical" = Π P_"original" Π^T $

where $Π$ swaps rows/columns 2 and 3.

*Step 3: Result in canonical form*

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  align: center,
  [], [*A*], [*C*], [| *B*], [*D*], [],
  [*A*], [0.3], [0.2], [| 0.4], [0.1], [],
  [*C*], [0.5], [0.1], [| 0.2], [0.2], [],
  [―], [―], [―], [|―], [―], [],
  [*B*], [0], [0], [| 1], [0], [],
  [*D*], [0], [0], [| 0], [1], [],
)

$ P_"canonical" = mat(
  0.3, 0.2, |, 0.4, 0.1;
  0.5, 0.1, |, 0.2, 0.2;
  ―, ―, ―, ―, ―;
  0, 0, |, 1, 0;
  0, 0, |, 0, 1
) = mat(Q, R; 0, I) $

where:
$
  Q = mat(0.3, 0.2; 0.5, 0.1) quad R = mat(0.4, 0.1; 0.2, 0.2)
$

*Verification of row sums:*
- Row A: $0.3 + 0.2 + 0.4 + 0.1 = 1$ ✓
- Row C: $0.5 + 0.1 + 0.2 + 0.2 = 1$ ✓

*Mathematical Properties of Canonical Form:*

#block(
  fill: rgb("#fffacd"),
  inset: 10pt,
  radius: 4pt,
)[
  *Theorem (Powers of Canonical Form):*

  $ P^n = mat(Q^n, (sum_(k=0)^(n-1) Q^k) R; 0, I) $

  *Proof by induction:*

  *Base case (n=1):* True by definition

  *Inductive step:* Assume true for $n$, prove for $n+1$:

  $ P^(n+1) = P^n · P = mat(Q^n, (sum_(k=0)^(n-1) Q^k) R; 0, I) mat(Q, R; 0, I) $

  Block multiplication:
  - Top-left: $Q^n · Q = Q^(n+1)$ ✓
  - Top-right: $Q^n R + (sum_(k=0)^(n-1) Q^k) R · I = Q^n R + sum_(k=0)^(n-1) Q^k R = sum_(k=0)^n Q^k R$ ✓
  - Bottom-left: $0 · Q + 0 = 0$ ✓
  - Bottom-right: $0 · R + I · I = I$ ✓

  *Convergence:* As $n → ∞$, $Q^n → 0$ (since spectral radius $< 1$):

  $ lim_(n→∞) P^n = mat(0, (I - Q)^(-1) R; 0, I) $

  The top-right block $(I - Q)^(-1) R$ gives absorption probabilities!
]

*Step-by-Step Calculation for Example 1:*

$ Q = mat(0.5, 0.3; 0.4, 0) $

*Compute $I - Q$:*
$ I - Q = mat(1, 0; 0, 1) - mat(0.5, 0.3; 0.4, 0) = mat(0.5, -0.3; -0.4, 1) $

*Compute $(I - Q)^(-1)$ using matrix inversion:*

For $mat(a, b; c, d)$, inverse is $(1)/(a d - b c) mat(d, -b; -c, a)$

Determinant: $det(I - Q) = 0.5 · 1 - (-0.3)(-0.4) = 0.5 - 0.12 = 0.38$

$ (I - Q)^(-1) = (1)/(0.38) mat(1, 0.3; 0.4, 0.5) = mat(2.632, 0.789; 1.053, 1.316) $

This is the fundamental matrix $N$!

== Fundamental Matrix

The *fundamental matrix* is:
$ N = (I - Q)^(-1) = I + Q + Q^2 + Q^3 + ... $

*Interpretation:* $N_(i j)$ is the expected number of times the chain visits transient state $j$ starting from transient state $i$.

=== Absorption Probabilities

The matrix $B = N R$ gives absorption probabilities:
- $B_(i j)$ = probability of being absorbed in state $j$ starting from transient state $i$

=== Expected Time to Absorption

The vector $t = N 𝟙$ gives expected absorption times:
- $t_i$ = expected number of steps until absorption, starting from state $i$

#pagebreak()

== Example: Gambler's Ruin

A gambler starts with $k$ dollars and plays until reaching $0$ (broke) or $N$ (wins). Each game, win \$1 with probability $p$, lose \$1 with probability $q = 1-p$.

#align(center)[
  #diagram(
    spacing: 1.5cm,
    node-stroke: 1pt,
    node((0, 0), $0$, name: <0>, radius: 0.6cm),
    node((1.5, 0), $1$, name: <1>, radius: 0.6cm),
    node((3, 0), $2$, name: <2>, radius: 0.6cm),
    node((4.5, 0), $...$, name: <dots>, shape: "rect", stroke: none),
    node((6, 0), $N$, name: <N>, radius: 0.6cm),

    edge(<1>, <0>, "->", label: $q$, bend: 20deg),
    edge(<1>, <2>, "->", label: $p$, bend: 20deg),
    edge(<2>, <1>, "->", label: $q$, bend: 20deg),
    edge(<2>, <dots>, "->", label: $p$),
    edge(<0>, <0>, "->", label: "1", bend: 130deg),
    edge(<N>, <N>, "->", label: "1", bend: -130deg),
  )
]

*Questions of Interest:*
1. Probability of ruin starting with $k$ dollars?
2. Expected duration of the game?

=== Detailed Solution for Fair Game ($p = q = 1/2$)

*Part 1: Probability of Ruin*

Let $P_k$ = probability of ruin (reaching \$0) starting from $k$ dollars.

*Boundary conditions:*
- $P_0 = 1$ (already ruined)
- $P_N = 0$ (already won)

*Recursive relation:* From state $k$ ($1 ≤ k ≤ N-1$):
$ P_k = p · P_(k+1) + q · P_(k-1) $

For fair game ($p = q = 1/2$):
$ P_k = (1)/(2) P_(k+1) + (1)/(2) P_(k-1) $
$ 2 P_k = P_(k+1) + P_(k-1) $
$ P_(k+1) - P_k = P_k - P_(k-1) $

This means the differences are constant! Let $d = P_1 - P_0 = P_1 - 1$.

Then:
- $P_1 = P_0 + d = 1 + d$
- $P_2 = P_1 + d = 1 + 2d$
- $P_3 = P_2 + d = 1 + 3d$
- $P_k = 1 + k d$

Using $P_N = 0$:
$ 0 = 1 + N d $
$ d = -1/N $

Therefore:
$ P_k = 1 + k(-1/N) = 1 - k/N = (N-k)/N $

*Numerical Example:* If $N = 10$ and $k = 3$:
$ P_3 = (10-3)/10 = 7/10 = 0.7 $

70% chance of ruin, 30% chance of winning.

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  [*Starting Amount ($k$)*], [*P(Ruin)*], [*P(Win)*], [*Odds*],
  [1], [9/10 = 0.90], [0.10], [9:1 against],
  [3], [7/10 = 0.70], [0.30], [7:3 against],
  [5], [5/10 = 0.50], [0.50], [Even],
  [7], [3/10 = 0.30], [0.70], [3:7 for],
  [9], [1/10 = 0.10], [0.90], [1:9 for],
)

*Part 2: Expected Duration*

Let $D_k$ = expected number of games starting from $k$ dollars.

*Boundary conditions:*
- $D_0 = 0$ (game over)
- $D_N = 0$ (game over)

*Recursive relation:*
$ D_k = 1 + p · D_(k+1) + q · D_(k-1) $

The "+1" accounts for the current game.

For fair game ($p = q = 1/2$):
$ D_k = 1 + (1)/(2) D_(k+1) + (1)/(2) D_(k-1) $
$ 2 D_k = 2 + D_(k+1) + D_(k-1) $
$ D_(k+1) - 2D_k + D_(k-1) = -2 $

This is a second-order difference equation. Try solution $D_k = a k^2 + b k + c$:

$ D_(k+1) = a(k+1)^2 + b(k+1) + c = a k^2 + 2a k + a + b k + b + c $
$ D_(k-1) = a(k-1)^2 + b(k-1) + c = a k^2 - 2a k + a + b k - b + c $

Substituting:
$ (a k^2 + 2a k + a + b k + b + c) - 2(a k^2 + b k + c) + (a k^2 - 2a k + a + b k - b + c) = -2 $
$ 2a = -2 $
$ a = -1 $

So $D_k = -k^2 + b k + c$.

Using $D_0 = 0$: $c = 0$
Using $D_N = 0$: $-N^2 + b N = 0$, so $b = N$

Therefore:
$ D_k = -k^2 + N k = k(N - k) $

*Numerical Example:* If $N = 10$ and $k = 3$:
$ D_3 = 3(10-3) = 3 · 7 = 21 "games" $

#table(
  columns: (auto, auto, auto),
  align: center,
  [*Starting Amount ($k$)*], [*Expected Duration*], [*Formula*],
  [1], [1(10-1) = 9], [$k(N-k)$],
  [2], [2(10-2) = 16], [],
  [3], [3(10-3) = 21], [],
  [5], [5(10-5) = 25], [Maximum at $k = N/2$],
  [7], [7(10-7) = 21], [],
  [9], [9(10-9) = 9], [],
)

*Key Insight:* Expected duration is maximized when starting at the midpoint ($k = N/2$).

=== General Case (Unfair Game, $p ≠ q$)

For $p ≠ 1/2$, let $r = q/p$:

*Probability of ruin:*
$
  P_k = cases(
    (r^N - r^k)/(r^N - 1) quad & "if" p ≠ 1/2,
    (N-k)/N quad & "if" p = 1/2
  )
$

*Expected duration:*
$
  D_k = cases(
    (1)/(q-p) (k - N (r^k - 1)/(r^N - 1)) quad & "if" p ≠ 1/2,
    k(N-k) quad & "if" p = 1/2
  )
$

*Example with advantage ($p = 0.6, q = 0.4$):*

For $N = 10, k = 5$, $r = 0.4/0.6 = 2/3$:
$ P_5 = ((2/3)^10 - (2/3)^5)/((2/3)^10 - 1) ≈ 0.087 $

Much better than fair game! Only 8.7% chance of ruin vs 50%.

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  [*Game Type*], [$p$], [P(Ruin) from \$5], [Interpretation],
  [Player disadvantage], [0.4], [0.913], [91.3% lose],
  [Fair game], [0.5], [0.500], [50% lose],
  [Player advantage], [0.6], [0.087], [8.7% lose],
)

#pagebreak()

= First Passage Times and Hitting Probabilities

This section explores the fundamental questions: "How long until we reach a target state?" and "What's the probability we ever reach it?"

== Definitions

#block(
  fill: rgb("#e6f3ff"),
  inset: 10pt,
  radius: 4pt,
)[
  *First Passage Time* from state $i$ to state $j$:
  $ T_j^((i)) = min{n ≥ 1 : X_n = j | X_0 = i} $

  *First Return Time* to state $i$ (when $i = j$):
  $ T_i = min{n ≥ 1 : X_n = i | X_0 = i} $

  *Hitting Probability* (or reachability):
  $ h_(i j) = P(T_j^((i)) < ∞) = P("ever reach" j "from" i) $

  *Mean First Passage Time*:
  $ m_(i j) = 𝔼[T_j^((i)) | T_j^((i)) < ∞] $

  *Mean Return Time* to state $i$:
  $ μ_i = 𝔼[T_i | X_0 = i] = m_(i i) $
]

== Computing Hitting Probabilities

*Method 1: First-Step Analysis*

The hitting probability $h_(i j)$ satisfies:

#block(
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  *Boundary conditions:*
  $ h_(j j) = 1 quad "(already at target)" $

  *Recursive equation:* For $i ≠ j$:
  $ h_(i j) = sum_(k∈S) p_(i k) h_(k j) $

  *System form:* This gives a linear system with $|S| - 1$ equations (excluding $j$).

  *Matrix formulation:* Let $h = [h_(1 j), h_(2 j), ..., h_(N j)]^T$

  Then: $(I - tilde(P))h = b$ where $tilde(P)$ is $P$ with row/column $j$ removed, $b$ has 1's for states that can reach $j$ directly.
]

*Detailed Example 1: 3-State Chain*

Consider:
$ P = mat(0.5, 0.3, 0.2; 0.4, 0.4, 0.2; 0, 0, 1) $

State 3 is absorbing. Find $h_(1 3)$ and $h_(2 3)$.

*Solution using first-step analysis:*

Since state 3 is absorbing: $h_(33) = 1$

For state 1:
$ h_(13) = 0.5 · h_(13) + 0.3 · h_(23) + 0.2 · h_(33) $
$ h_(13) = 0.5 h_(13) + 0.3 h_(23) + 0.2 $

For state 2:
$ h_(23) = 0.4 · h_(13) + 0.4 · h_(23) + 0.2 · h_(33) $
$ h_(23) = 0.4 h_(13) + 0.4 h_(23) + 0.2 $

*Rearranging into standard form:*
$
  cases(
    0.5 h_(13) - 0.3 h_(23) = 0.2,
    -0.4 h_(13) + 0.6 h_(23) = 0.2
  )
$

From equation 1: $h_(13) = (0.2 + 0.3 h_(23))/(0.5) = 0.4 + 0.6 h_(23)$

Substituting into equation 2:
$ -0.4(0.4 + 0.6 h_(23)) + 0.6 h_(23) = 0.2 $
$ -0.16 - 0.24 h_(23) + 0.6 h_(23) = 0.2 $
$ 0.36 h_(23) = 0.36 $
$ h_(23) = 1 $

Therefore: $h_(13) = 0.4 + 0.6 · 1 = 1$

*Interpretation:* Both states 1 and 2 will eventually reach the absorbing state 3 with probability 1.

#table(
  columns: (auto, auto, auto),
  align: center,
  [*Starting State*], [*Target State 3*], [*Interpretation*],
  [1], [$h_(13) = 1$], [Certain to be absorbed],
  [2], [$h_(23) = 1$], [Certain to be absorbed],
  [3], [$h_(33) = 1$], [Already absorbed],
)

== Computing Mean First Passage Times

*Method: First-Step Analysis for Expectations*

The mean first passage time $m_(i j)$ satisfies:

#block(
  fill: rgb("#f0fff0"),
  inset: 10pt,
  radius: 4pt,
)[
  *Boundary condition:*
  $ m_(j j) = 0 quad "(starting at target, time = 0)" $

  *Recursive equation:* For $i ≠ j$:
  $ m_(i j) = 1 + sum_(k≠j) p_(i k) m_(k j) $

  *Interpretation:* Take one step (cost = 1) and then average over next states.

  *System form:* Linear system with $|S| - 1$ unknowns.
]

*Detailed Example 2: Same 3-State Chain*

Find $m_(13)$ and $m_(23)$ (mean time to absorption from states 1 and 2).

*Boundary:* $m_(33) = 0$ (already absorbed)

*For state 1:*
$ m_(13) = 1 + 0.5 · m_(13) + 0.3 · m_(23) + 0.2 · m_(33) $
$ m_(13) = 1 + 0.5 m_(13) + 0.3 m_(23) + 0 $
$ 0.5 m_(13) - 0.3 m_(23) = 1 $

*For state 2:*
$ m_(23) = 1 + 0.4 · m_(13) + 0.4 · m_(23) + 0.2 · m_(33) $
$ m_(23) = 1 + 0.4 m_(13) + 0.4 m_(23) $
$ -0.4 m_(13) + 0.6 m_(23) = 1 $

*Solving the system:*

From equation 1: $m_(13) = (1 + 0.3 m_(23))/(0.5) = 2 + 0.6 m_(23)$

Substituting:
$ -0.4(2 + 0.6 m_(23)) + 0.6 m_(23) = 1 $
$ -0.8 - 0.24 m_(23) + 0.6 m_(23) = 1 $
$ 0.36 m_(23) = 1.8 $
$ m_(23) = 5 $

Therefore: $m_(13) = 2 + 0.6 · 5 = 2 + 3 = 5$

#table(
  columns: (auto, auto, auto),
  align: center,
  [*Starting State*], [*Mean Time to State 3*], [*Interpretation*],
  [1], [$m_(13) = 5$ steps], [Average 5 transitions until absorption],
  [2], [$m_(23) = 5$ steps], [Also average 5 steps],
  [3], [$m_(33) = 0$ steps], [Already there],
)

*Interesting observation:* Despite different positions, states 1 and 2 have equal mean absorption times due to the transition structure!

== Relationship to Stationary Distribution

#block(
  fill: rgb("#fffacd"),
  inset: 10pt,
  radius: 4pt,
)[
  *Theorem (Return Time and Stationary Distribution):*

  For an irreducible, positive recurrent chain with stationary distribution $π$:

  $ π_i = 1/(μ_i) $

  where $μ_i = 𝔼[T_i]$ is the mean return time to state $i$.

  *Proof Sketch:*
  1. In equilibrium, state $i$ is visited with frequency $π_i$
  2. Between visits, average time gap is $μ_i$
  3. Therefore: (visit frequency) × (time between visits) = 1
  4. So: $π_i · μ_i = 1$

  *Physical Interpretation:* Rare states ($π_i$ small) have long return times ($μ_i$ large).
]

*Detailed Example 3: Weather Model*

Recall the 2-state weather model:
$ P = mat(0.7, 0.3; 0.5, 0.5) $

Stationary distribution: $π = [5/8, 3/8]$

*Computing mean return times:*

By theorem: $μ_S = 1/(π_S) = 1/(5/8) = 8/5 = 1.6$ days

$μ_R = 1/(π_R) = 1/(3/8) = 8/3 ≈ 2.67$ days

*Verification using first-step analysis:*

For $m_(S S)$ (return to Sunny):
$ m_(S S) = 1 + 0.7 · m_(S S) + 0.3 · m_(R S) $

For $m_(R S)$ (time from Rainy to Sunny):
$ m_(R S) = 1 + 0.5 · 0 + 0.5 · m_(R S) $
$ 0.5 m_(R S) = 1 $
$ m_(R S) = 2 $

Substituting back:
$ m_(S S) = 1 + 0.7 m_(S S) + 0.3 · 2 $
$ 0.3 m_(S S) = 1 + 0.6 = 1.6 $
$ m_(S S) = 1.6 / 0.3 ≈ 5.33 $ 

Wait, this doesn't match! Let me recalculate properly.

Actually, for *first return* to $S$, we must leave $S$ first:
$ μ_S = 1 + 0.7 · (1 + μ_S) + 0.3 · (1 + m_(R S))  $ — This is WRONG!

Correct formulation:
$ μ_S = 1 + 0.7 · μ_S + 0.3 · m_(R S) $

Actually, there's a simpler approach using the theorem directly:
$ μ_S = 1/π_S = 8/5 = 1.6 $ ✓

$ μ_R = 1/π_R = 8/3 ≈ 2.67 $ ✓

== Gambler's Ruin: Complete First Passage Analysis

Consider a random walk on ${0, 1, 2, ..., N}$ with absorbing barriers at 0 and $N$.

From state $k$ ($1 ≤ k ≤ N-1$): move to $k+1$ with probability $p$, to $k-1$ with probability $q = 1-p$.

*Question 1: Duration of the game (mean absorption time)*

Let $d_k$ = expected duration starting from $k$ dollars.

*Boundary conditions:* $d_0 = d_N = 0$ (game over)

*Recursive relation:* For $1 ≤ k ≤ N-1$:
$ d_k = 1 + p · d_(k+1) + q · d_(k-1) $

*For fair game ($p = q = 1/2$):*

$ d_k = 1 + (1)/(2) d_(k+1) + (1)/(2) d_(k-1) $
$ d_(k+1) - 2 d_k + d_(k-1) = -2 $

This is a second-order difference equation. The solution is:
$ d_k = k(N - k) $

*Derivation:*
General solution: $d_k = A k + B k^2 + C$

Particular solution for $-2$: Try $d_k = α k^2$
$ α(k+1)^2 - 2α k^2 + α(k-1)^2 = -2 $
$ α[(k^2 + 2k + 1) - 2k^2 + (k^2 - 2k + 1)] = -2 $
$ α · 2 = -2 $
$ α = -1 $

With boundary conditions $d_0 = 0$ and $d_N = 0$:
$ d_k = C - k^2 + D k $

$d_0 = C = 0$
$d_N = -N^2 + D N = 0 ⟹ D = N$

Therefore: $d_k = N k - k^2 = k(N - k)$

*Numerical Example:* $N = 10$, start with $k = 5$:
$ d_5 = 5(10 - 5) = 25 "steps" $

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  align: center,
  [*N*], [*Starting k*], [*Duration $d_k$*], [*Interpretation*], [], [],
  [10], [1], [9], [Near ruin, short game], [], [],
  [10], [5], [25], [Middle, longest game], [], [],
  [10], [9], [9], [Near win, short game], [], [],
  [100], [50], [2500], [Large stakes, very long], [], [],
)

*Key Insight:* Expected duration is quadratic in the initial capital and total wealth. The game lasts longest when starting in the middle.

#pagebreak()

= Continuous-Time Markov Chains

== Definition

A *continuous-time Markov chain (CTMC)* is a stochastic process ${X(t) : t ≥ 0}$ satisfying:

$ P(X(t+s) = j | X(s) = i, X(u) = x(u), 0 ≤ u < s) = P(X(t+s) = j | X(s) = i) $

== Transition Rate Matrix

The *infinitesimal generator* or *transition rate matrix* $Q$ has entries:

$
  q_(i j) = cases(
    lim_(h→0) (p_(i j)(h))/h quad & "if" i ≠ j,
    -sum_(k≠i) q_(i k) quad & "if" i = j
  )
$

Properties:
- $q_(i j) ≥ 0$ for $i ≠ j$
- Row sums are zero: $sum_(j) q_(i j) = 0$

== Kolmogorov Equations

=== Forward Equation
$ (partial P(t))/(partial t) = P(t) Q $

=== Backward Equation
$ (partial P(t))/(partial t) = Q P(t) $

== Embedded Markov Chain

The *embedded Markov chain* is the discrete-time chain obtained by observing only the states visited (ignoring holding times).

Transition probabilities:
$
  s_(i j) = cases(
    q_(i j)/(sum_(k≠i) q_(i k)) quad & "if" i ≠ j,
    0 quad & "if" i = j
  )
$

#pagebreak()

== Example 1: Poisson Process (Counting Process)

A *Poisson process* with rate $λ$ is the fundamental example of a CTMC. It counts the number of events occurring over time.

=== Definition and Properties

#block(
  fill: rgb("#f0f8ff"),
  inset: 10pt,
  radius: 4pt,
)[
  A counting process ${N(t) : t ≥ 0}$ is a Poisson process with rate $λ > 0$ if:

  1. $N(0) = 0$ (starts at zero)
  2. *Independent increments:* Counts in disjoint time intervals are independent
  3. *Stationary increments:* Distribution of $N(t+s) - N(s)$ depends only on $t$, not $s$
  4. *Poisson distributed:* $N(t) ~ "Poisson"(λ t)$

  Equivalently:
  $ P(N(t) = n) = (e^(-λ t) (λ t)^n)/(n!) quad "for" n = 0, 1, 2, ... $
]

=== State Space and Transitions

*State space:* $S = {0, 1, 2, 3, ...}$ (non-negative integers)

*Transition behavior:*
- From state $n$, can only transition to state $n+1$ (one event occurs)
- No downward transitions (events are irreversible)
- Memoryless waiting times (exponential distribution)

#align(center)[
  #diagram(
    spacing: 1.6cm,
    node-stroke: 1pt,
    node((0, 0), $0$, name: <0>, radius: 0.6cm),
    node((1.6, 0), $1$, name: <1>, radius: 0.6cm),
    node((3.2, 0), $2$, name: <2>, radius: 0.6cm),
    node((4.8, 0), $3$, name: <3>, radius: 0.6cm),
    node((6.4, 0), $...$, name: <dots>, shape: "rect", stroke: none),

    edge(<0>, <1>, "->", label: $λ$),
    edge(<1>, <2>, "->", label: $λ$),
    edge(<2>, <3>, "->", label: $λ$),
    edge(<3>, <dots>, "->", label: $λ$),
  )
]

=== Generator Matrix $Q$

The infinitesimal generator has a simple structure:

$ Q = mat(
  -λ, λ, 0, 0, 0, ...;
  0, -λ, λ, 0, 0, ...;
  0, 0, -λ, λ, 0, ...;
  0, 0, 0, -λ, λ, ...;
  dots.v, dots.v, dots.v, dots.v, dots.v, dots.down
) $

*Elements:*
- $q_(n, n+1) = λ$ for all $n ≥ 0$ (transition rate upward)
- $q_(n n) = -λ$ for all $n ≥ 0$ (diagonal: negative sum of off-diagonal)
- All other entries are 0

*Physical interpretation:* From any state, events occur at constant rate $λ$ regardless of current count.

=== Detailed Derivation of Transition Probabilities

We want to find $p_(i j)(t) = P(N(t) = j | N(0) = i)$.

*Key observation:* Due to stationary increments:
$ p_(i j)(t) = P(N(t) - N(0) = j - i) = P(N(t) = j - i) $

So we only need $p_(0 n)(t) = P(N(t) = n)$.

*Derivation using Kolmogorov Forward Equation:*

$ (d p_(0 n)(t))/(d t) = sum_(k) p_(0 k)(t) q_(k n) $

For $n = 0$:
$ (d p_(00)(t))/(d t) = p_(00)(t) q_(00) = p_(00)(t) · (-λ) = -λ p_(00)(t) $

Solving this ODE with $p_(00)(0) = 1$:
$ p_(00)(t) = e^(-λ t) $

For $n ≥ 1$:
$ (d p_(0 n)(t))/(d t) = p_(0, n-1)(t) q_(n-1, n) + p_(0 n)(t) q_(n n) $
$ (d p_(0 n)(t))/(d t) = λ p_(0, n-1)(t) - λ p_(0 n)(t) $

*Solving by induction:*

Assume $p_(0, n-1)(t) = (e^(-λ t) (λ t)^(n-1))/((n-1)!)$ (induction hypothesis)

Then:
$ (d p_(0 n)(t))/(d t) + λ p_(0 n)(t) = λ · (e^(-λ t) (λ t)^(n-1))/((n-1)!) $

This is a first-order linear ODE. Using integrating factor $e^(λ t)$:

$ (d)/(d t)[e^(λ t) p_(0 n)(t)] = λ · ((λ t)^(n-1))/((n-1)!) $

Integrating both sides:
$ e^(λ t) p_(0 n)(t) = λ ∫ ((λ t)^(n-1))/((n-1)!) d t = λ · ((λ t)^n)/(n! · λ) = ((λ t)^n)/(n!) $

Therefore:
$ p_(0 n)(t) = e^(-λ t) · ((λ t)^n)/(n!) $

This is exactly the Poisson distribution! ✓

=== Inter-arrival Times and Memoryless Property

#block(
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  *Theorem:* The waiting time between consecutive events in a Poisson process is exponentially distributed with rate $λ$:

  $ T_i ~ "Exp"(λ) quad "i.i.d." $

  *Memoryless property:*
  $ P(T > t + s | T > s) = P(T > t) = e^(-λ t) $

  *Interpretation:* The future waiting time doesn't depend on how long we've already waited.
]

=== Practical Example: Customer Arrivals

*Scenario:* Customers arrive at a store according to a Poisson process with rate $λ = 5$ customers/hour.

*Questions and Solutions:*

*Q1:* What's the probability of exactly 3 arrivals in the next hour?

*Solution:*
$ P(N(1) = 3) = (e^(-5) · 5^3)/(3!) = (e^(-5) · 125)/(6) ≈ 0.1404 $

About 14% chance of exactly 3 customers.

*Q2:* What's the expected time until the next customer?

*Solution:*
$ 𝔼[T] = 1/λ = 1/5 "hours" = 12 "minutes" $

*Q3:* Given that 10 minutes have passed with no customer, what's the probability we wait another 10 minutes?

*Solution:* By memoryless property:
$ P(T > 20 | T > 10) = P(T > 10) = e^(-λ · 10/60) = e^(-5/6) ≈ 0.4346 $

About 43.5% chance, same as if we just started waiting!

*Q4:* What's the probability of at least 2 customers in 30 minutes?

*Solution:*
$ P(N(0.5) ≥ 2) = 1 - P(N(0.5) = 0) - P(N(0.5) = 1) $
$ = 1 - e^(-2.5) - 2.5 e^(-2.5) $
$ = 1 - 3.5 e^(-2.5) ≈ 1 - 0.2873 = 0.7127 $

About 71% chance of at least 2 customers.

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  [*Time Interval*], [*Expected Arrivals*], [*P(0 arrivals)*], [*P(≥ 2 arrivals)*],
  [15 min (0.25 hr)], [$λ t = 1.25$], [0.287], [0.358],
  [30 min (0.5 hr)], [$λ t = 2.5$], [0.082], [0.713],
  [1 hour], [$λ t = 5$], [0.007], [0.960],
  [2 hours], [$λ t = 10$], [0.00005], [0.9995],
)

=== Extension: Compound Poisson Process

If each arrival brings a random "value" $Y_i$ (i.i.d.), the total accumulated value is:

$ S(t) = sum_(i=1)^(N(t)) Y_i $

This is called a *compound Poisson process*.

*Example applications:*
- Insurance claims: $N(t)$ = number of claims, $Y_i$ = claim amount
- Traffic flow: $N(t)$ = number of vehicles, $Y_i$ = vehicle size/weight
- Network packets: $N(t)$ = packet arrivals, $Y_i$ = packet size

*Expected total value:*
$ 𝔼[S(t)] = 𝔼[N(t)] · 𝔼[Y_i] = λ t · 𝔼[Y_i] $

#pagebreak()

== Example 2: Birth-Death Process

A *birth-death process* is a CTMC on ${0, 1, 2, ...}$ where:
- From state $i$, can only move to $i+1$ (birth) or $i-1$ (death)
- Birth rate from $i$: $λ_i$
- Death rate from $i$: $μ_i$

#align(center)[
  #diagram(
    spacing: 1.8cm,
    node-stroke: 1pt,
    node((0, 0), $0$, name: <0>, radius: 0.5cm),
    node((1.8, 0), $1$, name: <1>, radius: 0.5cm),
    node((3.6, 0), $2$, name: <2>, radius: 0.5cm),
    node((5.4, 0), $...$, name: <dots>, shape: "rect", stroke: none),

    edge(<0>, <1>, "->", label: $λ_0$, bend: -20deg),
    edge(<1>, <0>, "->", label: $μ_1$, bend: -20deg),
    edge(<1>, <2>, "->", label: $λ_1$, bend: -20deg),
    edge(<2>, <1>, "->", label: $μ_2$, bend: -20deg),
    edge(<2>, <dots>, "->", label: $λ_2$, bend: -20deg),
  )
]

*Applications:*
- Queueing systems (M/M/1 queue)
- Population dynamics
- Chemical reactions

#pagebreak()

= Advanced Topics

== Reversibility

#block(
  fill: rgb("#e8f4f8"),
  inset: 10pt,
  radius: 4pt,
)[
  A Markov chain with stationary distribution $π$ is *reversible* if:

  $ π_i p_(i j) = π_j p_(j i) quad "for all" i, j $

  This is called the *detailed balance condition*.
]

*Physical Interpretation:* The probability flow from $i$ to $j$ equals the flow from $j$ to $i$ in equilibrium.

== Metropolis-Hastings Algorithm

A method to construct a Markov chain with desired stationary distribution $π$:

1. Propose move to state $j$ with probability $q_(i j)$
2. Accept with probability:
  $ α_(i j) = min(1, (π_j q_(j i))/(π_i q_(i j))) $

This creates a reversible chain with stationary distribution $π$.

== Hidden Markov Models (HMMs)

An HMM consists of:
- Hidden states forming a Markov chain
- Observations that depend on hidden states

Applications:
- Speech recognition
- Bioinformatics (gene finding)
- Natural language processing

#pagebreak()

= Applications

== Finance: Credit Rating Transitions

Credit rating agencies model rating changes as Markov chains:

#table(
  columns: (auto, auto, auto, auto, auto),
  align: center,
  [From \\ To], [AAA], [AA], [A], [Default],
  [AAA], [0.90], [0.08], [0.01], [0.01],
  [AA], [0.05], [0.85], [0.08], [0.02],
  [A], [0.02], [0.05], [0.88], [0.05],
)

*Applications:*
- Risk assessment
- Portfolio optimization
- Credit default prediction

== Biology: DNA Sequence Analysis

Model DNA sequences as Markov chains over ${A, C, G, T}$:

$
  P = mat(
    p_(A A), p_(A C), p_(A G), p_(A T);
    p_(C A), p_(C C), p_(C G), p_(C T);
    p_(G A), p_(G C), p_(G G), p_(G T);
    p_(T A), p_(T C), p_(T G), p_(T T)
  )
$

*Applications:*
- Gene prediction
- Phylogenetic analysis
- CpG island detection

== Computer Science: PageRank

Google's PageRank models web surfing as a Markov chain:
- States = web pages
- Transitions = following hyperlinks
- Damping factor handles "random jumps"

== Queueing Theory: M/M/1 Queue Complete Analysis

The *M/M/1 queue* is one of the most fundamental queueing models, representing a single-server queue with:
- *M* (Markovian) arrivals: Poisson process with rate $λ$
- *M* (Markovian) service: Exponential service times with rate $μ$
- *1* server

=== Model Setup and State Space

*State definition:* $X(t)$ = number of customers in the system at time $t$

*State space:* $S = {0, 1, 2, 3, ...}$ (unbounded)

*Dynamics:*
- Arrivals add 1 to the state (rate $λ$)
- Service completions subtract 1 (rate $μ$ when system non-empty)

#align(center)[
  #diagram(
    spacing: 1.6cm,
    node-stroke: 1pt,
    node((0, 0), $0$, name: <0>, radius: 0.6cm),
    node((1.6, 0), $1$, name: <1>, radius: 0.6cm),
    node((3.2, 0), $2$, name: <2>, radius: 0.6cm),
    node((4.8, 0), $3$, name: <3>, radius: 0.6cm),
    node((6.4, 0), $...$, name: <dots>, shape: "rect", stroke: none),

    edge(<0>, <1>, "->", label: $λ$, bend: -20deg),
    edge(<1>, <0>, "->", label: $μ$, bend: -20deg),
    edge(<1>, <2>, "->", label: $λ$, bend: -20deg),
    edge(<2>, <1>, "->", label: $μ$, bend: -20deg),
    edge(<2>, <3>, "->", label: $λ$, bend: -20deg),
    edge(<3>, <2>, "->", label: $μ$, bend: -20deg),
    edge(<3>, <dots>, "->", label: $λ$, bend: -20deg),
  )
]

=== Generator Matrix

$ Q = mat(
  -λ, λ, 0, 0, 0, ...;
  μ, -(λ+μ), λ, 0, 0, ...;
  0, μ, -(λ+μ), λ, 0, ...;
  0, 0, μ, -(λ+μ), λ, ...;
  dots.v, dots.v, dots.v, dots.v, dots.v, dots.down
) $

*Key difference from Poisson process:* Birth-death structure allows both upward (arrivals) and downward (service) transitions.

=== Stationary Distribution Derivation

We seek $π$ such that $π Q = 0$ (equilibrium) and $sum_(n=0)^∞ π_n = 1$ (normalization).

*Using detailed balance equations:*

For a birth-death process, detailed balance holds:
$ π_n λ = π_(n+1) μ quad "for all" n ≥ 0 $

*Physical interpretation:* Rate of transitions from $n$ to $n+1$ equals rate from $n+1$ to $n$ in equilibrium.

*Solving recursively:*

From $n = 0$:
$ π_0 λ = π_1 μ ⟹ π_1 = (λ)/(μ) π_0 $

From $n = 1$:
$ π_1 λ = π_2 μ ⟹ π_2 = (λ)/(μ) π_1 = ((λ)/(μ))^2 π_0 $

By induction:
$ π_n = ((λ)/(μ))^n π_0 = ρ^n π_0 $

where $ρ = λ/μ$ is called the *traffic intensity* or *utilization factor*.

*Normalization to find $π_0$:*

$ sum_(n=0)^∞ π_n = 1 $
$ sum_(n=0)^∞ ρ^n π_0 = 1 $
$ π_0 sum_(n=0)^∞ ρ^n = 1 $

This geometric series converges *if and only if* $ρ < 1$:
$ sum_(n=0)^∞ ρ^n = 1/(1-ρ) quad "for" ρ < 1 $

Therefore:
$ π_0 · 1/(1-ρ) = 1 ⟹ π_0 = 1 - ρ $

*Final stationary distribution:*

#block(
  fill: rgb("#fffacd"),
  inset: 10pt,
  radius: 4pt,
)[
  $ π_n = (1 - ρ) ρ^n quad "for" n = 0, 1, 2, ... $

  where $ρ = λ/μ < 1$ (stability condition).

  *Distribution type:* Geometric distribution!
]

=== Stability Condition: $ρ < 1$

#block(
  fill: rgb("#ffe6f0"),
  inset: 10pt,
  radius: 4pt,
)[
  *Theorem:* The M/M/1 queue has a stationary distribution if and only if $ρ = λ/μ < 1$.

  *Interpretation:*
  - $λ$ = arrival rate (customers/time)
  - $μ$ = service rate (customers/time)
  - $1/μ$ = average service time
  - $ρ$ = fraction of time server is busy

  *Stability requires:* Average service rate > average arrival rate

  *If $ρ ≥ 1$:* Queue grows without bound (unstable)
]

=== Performance Metrics

*1. Average number of customers in system:*

$ L = 𝔼[N] = sum_(n=0)^∞ n π_n = sum_(n=0)^∞ n (1-ρ) ρ^n $

Using $sum_(n=1)^∞ n ρ^n = ρ/(1-ρ)^2$:

$ L = (1-ρ) · ρ/(1-ρ)^2 = ρ/(1-ρ) = λ/(μ - λ) $

*2. Average number in queue (waiting):*

$ L_q = sum_(n=1)^∞ (n-1) π_n = L - ρ = ρ^2/(1-ρ) = λ^2/(μ(μ-λ)) $

*3. Average time in system (Little's Law):*

$ W = L/λ = 1/(μ - λ) $

*4. Average time in queue (waiting):*

$ W_q = L_q/λ = ρ/(μ - λ) = λ/(μ(μ - λ)) $

*5. Server utilization:*

$ U = ρ = λ/μ $

#table(
  columns: (auto, auto, auto),
  align: center,
  [*Metric*], [*Formula*], [*Units*],
  [$L$ (system size)], [$ρ/(1-ρ)$], [customers],
  [$L_q$ (queue size)], [$ρ^2/(1-ρ)$], [customers],
  [$W$ (system time)], [$1/(μ-λ)$], [time],
  [$W_q$ (wait time)], [$ρ/(μ-λ)$], [time],
  [$ρ$ (utilization)], [$λ/μ$], [dimensionless],
)

=== Little's Law (Fundamental Relationship)

#block(
  fill: rgb("#f0f8ff"),
  inset: 10pt,
  radius: 4pt,
)[
  *Theorem (Little's Law):*

  $ L = λ W $

  *In words:* Average number in system = arrival rate × average time in system

  *Also applies to queue:* $L_q = λ W_q$

  *Proof idea:* In steady state, rate in = rate out. Over long time $T$:
  - Arrivals: $λ T$ customers
  - Total time in system: $sum "individual times"$
  - Average: $L · T = λ T · W$
]

=== Numerical Example: Detailed Calculation

*Scenario:* Bank teller with:
- Customers arrive at rate $λ = 20$ per hour
- Teller serves at rate $μ = 25$ per hour

*Step 1: Check stability*
$ ρ = λ/μ = 20/25 = 0.8 < 1 $ ✓ (Stable)

*Step 2: Compute performance metrics*

Average number in system:
$ L = ρ/(1-ρ) = 0.8/(1-0.8) = 0.8/0.2 = 4 "customers" $

Average number waiting:
$ L_q = ρ^2/(1-ρ) = 0.64/0.2 = 3.2 "customers" $

Average time in system:
$ W = 1/(μ-λ) = 1/(25-20) = 1/5 "hour" = 12 "minutes" $

Average waiting time:
$ W_q = ρ/(μ-λ) = 0.8/5 = 0.16 "hour" = 9.6 "minutes" $

Server utilization:
$ U = ρ = 0.8 = 80% $

*Step 3: Probability distribution*

Probability of empty system:
$ π_0 = 1 - ρ = 0.2 = 20% $

Probability of exactly 3 customers:
$ π_3 = (1-ρ) ρ^3 = 0.2 · 0.8^3 = 0.1024 ≈ 10.2% $

Probability of at least 5 customers:
$ P(N ≥ 5) = sum_(n=5)^∞ π_n = ρ^5 = 0.8^5 = 0.32768 ≈ 32.8% $

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  [*n*], [$π_n$], [*Interpretation*], [*Cumulative*],
  [0], [0.200], [20% time idle], [20.0%],
  [1], [0.160], [16% exactly 1], [36.0%],
  [2], [0.128], [12.8% exactly 2], [48.8%],
  [3], [0.102], [10.2% exactly 3], [59.0%],
  [4], [0.082], [8.2% exactly 4], [67.2%],
  [5], [0.066], [6.6% exactly 5], [73.8%],
  [≥ 5], [0.328], [32.8% five or more], [100%],
)

=== Effect of Traffic Intensity

How do metrics change as $ρ$ approaches 1?

#table(
  columns: (auto, auto, auto, auto, auto),
  align: center,
  [*ρ*], [*L*], [*$L_q$*], [*W* (if μ=10)], [*Status*],
  [0.5], [1.0], [0.25], [0.20], [Light traffic],
  [0.7], [2.33], [1.14], [0.33], [Moderate],
  [0.8], [4.0], [3.2], [0.50], [Heavy],
  [0.9], [9.0], [8.1], [1.0], [Very heavy],
  [0.95], [19.0], [18.05], [2.0], [Critical],
  [0.99], [99.0], [98.01], [10.0], [Near collapse],
)

*Key insight:* As $ρ → 1$, all metrics $→ ∞$ (system saturates)

#pagebreak()

= Computational Methods

== Simulating Markov Chains

*Algorithm:* Generate sample path $X_0, X_1, ..., X_n$

```python
import numpy as np

def simulate_markov_chain(P, initial_state, n_steps):
    """
    Simulate a discrete-time Markov chain.

    Parameters:
    - P: transition matrix (numpy array)
    - initial_state: starting state (int)
    - n_steps: number of steps to simulate

    Returns:
    - states: array of visited states
    """
    n_states = P.shape[0]
    states = [initial_state]
    current = initial_state

    for _ in range(n_steps):
        # Sample next state based on transition probabilities
        current = np.random.choice(n_states, p=P[current])
        states.append(current)

    return np.array(states)
```

== Computing Stationary Distributions

```python
import numpy as np
from scipy.linalg import null_space

def stationary_distribution(P):
    """
    Compute stationary distribution of Markov chain.

    Parameters:
    - P: transition matrix

    Returns:
    - pi: stationary distribution
    """
    # Find left eigenvector with eigenvalue 1
    eigenvalues, eigenvectors = np.linalg.eig(P.T)

    # Find eigenvector corresponding to eigenvalue 1
    idx = np.argmin(np.abs(eigenvalues - 1.0))
    pi = eigenvectors[:, idx].real

    # Normalize to probability distribution
    pi = pi / np.sum(pi)

    return pi
```

#pagebreak()

== Estimating Transition Probabilities

Given observed sequence $x_0, x_1, ..., x_n$:

$ hat(p)_(i j) = (N_(i j))/(N_i) $

where:
- $N_(i j)$ = number of transitions from $i$ to $j$
- $N_i$ = number of visits to state $i$

```python
def estimate_transition_matrix(states, n_states):
    """
    Estimate transition matrix from observed sequence.

    Parameters:
    - states: observed sequence of states
    - n_states: number of states

    Returns:
    - P_hat: estimated transition matrix
    """
    # Count transitions
    counts = np.zeros((n_states, n_states))
    for i in range(len(states) - 1):
        counts[states[i], states[i+1]] += 1

    # Normalize rows to get probabilities
    row_sums = counts.sum(axis=1, keepdims=True)
    P_hat = counts / np.where(row_sums > 0, row_sums, 1)

    return P_hat
```

#pagebreak()

= Practice Problems

== Problem 1: Two-State Chain Analysis

Consider the transition matrix:
$ P = mat(0.8, 0.2; 0.4, 0.6) $

*Questions:*
1. Find the stationary distribution
2. Is this chain irreducible?
3. Is this chain aperiodic?
4. Compute $P^5$
5. Starting from state 1, what's the expected time to return?

=== Solution

*Part 1: Finding Stationary Distribution*

We need to solve $π P = π$ with $π_1 + π_2 = 1$.

Setting up equations:
$ [π_1, π_2] mat(0.8, 0.2; 0.4, 0.6) = [π_1, π_2] $

This gives:
$
  cases(
    0.8 π_1 + 0.4 π_2 = π_1,
    0.2 π_1 + 0.6 π_2 = π_2,
    π_1 + π_2 = 1
  )
$

From equation 1:
$ 0.8 π_1 + 0.4 π_2 = π_1 $
$ 0.4 π_2 = 0.2 π_1 $
$ π_2 = 0.5 π_1 $

Substituting into normalization:
$ π_1 + 0.5 π_1 = 1 $
$ 1.5 π_1 = 1 $
$ π_1 = 2/3 ≈ 0.667 $
$ π_2 = 1/3 ≈ 0.333 $

*Answer:* $π = [2/3, 1/3]$

*Part 2: Irreducibility*

Check if all states communicate:
- State 1 → State 2: $p_(12) = 0.2 > 0$ ✓
- State 2 → State 1: $p_(21) = 0.4 > 0$ ✓

Since we can go from any state to any other state in one step, all states communicate.

*Answer:* Yes, the chain is irreducible.

*Part 3: Aperiodicity*

Check periods:
- State 1 has self-loop: $p_(11) = 0.8 > 0$
  Returns possible at steps: 1, 2, 3, ... → period = $gcd(1, 2, 3, ...) = 1$
- State 2 has self-loop: $p_(22) = 0.6 > 0$
  Returns possible at steps: 1, 2, 3, ... → period = $gcd(1, 2, 3, ...) = 1$

*Answer:* Yes, the chain is aperiodic (both states have period 1).

*Part 4: Computing $P^5$*

$P^2 = mat(0.8, 0.2; 0.4, 0.6) mat(0.8, 0.2; 0.4, 0.6)$
$= mat(0.8·0.8 + 0.2·0.4, 0.8·0.2 + 0.2·0.6; 0.4·0.8 + 0.6·0.4, 0.4·0.2 + 0.6·0.6)$
$= mat(0.64 + 0.08, 0.16 + 0.12; 0.32 + 0.24, 0.08 + 0.36)$
$= mat(0.72, 0.28; 0.56, 0.44)$

Continuing:
$P^3 = P^2 · P = mat(0.688, 0.312; 0.624, 0.376)$

$P^4 = P^3 · P = mat(0.6752, 0.3248; 0.6496, 0.3504)$

$P^5 = P^4 · P = mat(0.67008, 0.32992; 0.65984, 0.34016)$

Note convergence toward stationary distribution:
#table(
  columns: (auto, auto, auto),
  align: center,
  [*Power*], [$P^n [1,1]$], [$P^n [1,2]$],
  [$P^1$], [0.8000], [0.2000],
  [$P^2$], [0.7200], [0.2800],
  [$P^3$], [0.6880], [0.3120],
  [$P^4$], [0.6752], [0.3248],
  [$P^5$], [0.6701], [0.3299],
  [$P^∞$ (limit)], [0.6667 = 2/3], [0.3333 = 1/3],
)

*Answer:* $P^5 ≈ mat(0.670, 0.330; 0.660, 0.340)$

*Part 5: Expected Return Time to State 1*

For an irreducible, aperiodic Markov chain, the expected return time to state $i$ is:
$ E[T_i] = 1/(π_i) $

For state 1:
$ E[T_1] = 1/(π_1) = 1/(2/3) = 3/2 = 1.5 "steps" $

*Answer:* Expected return time = 1.5 steps

#block(
  fill: rgb("#e8f4f8"),
  inset: 10pt,
  radius: 4pt,
)[
  *Summary Table for Problem 1*

  #table(
    columns: (auto, auto),
    align: (left, left),
    [*Property*], [*Value*],
    [Stationary Distribution], [$π = [2/3, 1/3]$],
    [Irreducible?], [Yes],
    [Aperiodic?], [Yes],
    [Ergodic?], [Yes (irreducible + aperiodic)],
    [Expected Return to State 1], [1.5 steps],
    [Expected Return to State 2], [3 steps],
  )
]

== Problem 2: Three-State Weather Model

A weather model has states {Sunny, Cloudy, Rainy} with transition matrix:

$
  P = mat(
    0.6, 0.3, 0.1;
    0.3, 0.4, 0.3;
    0.2, 0.3, 0.5
  )
$

*Questions:*
1. Find the long-run proportion of sunny days
2. If today is cloudy, what's the probability of rain in 2 days?
3. Is this chain ergodic?

#align(center)[
  #diagram(
    spacing: 2.5cm,
    node-stroke: 1pt,
    edge-stroke: 1pt,
    node((0, 0), [Sunny], name: <s>, radius: 1.2cm),
    node((3, 0), [Cloudy], name: <c>, radius: 1.2cm),
    node((1.5, 2.5), [Rainy], name: <r>, radius: 1.2cm),

    // From Sunny
    edge(<s>, <c>, "->", label: "0.3", bend: 20deg),
    edge(<s>, <r>, "->", label: "0.1", bend: -20deg),
    edge(<s>, <s>, "->", label: "0.6", bend: 130deg, loop-angle: 180deg),

    // From Cloudy
    edge(<c>, <s>, "->", label: "0.3", bend: 20deg),
    edge(<c>, <r>, "->", label: "0.3", bend: 20deg),
    edge(<c>, <c>, "->", label: "0.4", bend: -130deg, loop-angle: 0deg),

    // From Rainy
    edge(<r>, <s>, "->", label: "0.2", bend: -20deg),
    edge(<r>, <c>, "->", label: "0.3", bend: 20deg),
    edge(<r>, <r>, "->", label: "0.5", bend: 130deg, loop-angle: 90deg),
  )
]

=== Solution

*Part 1: Long-Run Proportion of Sunny Days*

We need to find the stationary distribution by solving $π P = π$ with $π_S + π_C + π_R = 1$.

$
  [π_S, π_C, π_R] mat(
    0.6, 0.3, 0.1;
    0.3, 0.4, 0.3;
    0.2, 0.3, 0.5
  ) = [π_S, π_C, π_R]
$

This gives us the system:
$
  cases(
    0.6 π_S + 0.3 π_C + 0.2 π_R = π_S,
    0.3 π_S + 0.4 π_C + 0.3 π_R = π_C,
    0.1 π_S + 0.3 π_C + 0.5 π_R = π_R,
    π_S + π_C + π_R = 1
  )
$

Simplifying equations 1-3:
$
  cases(
    -0.4 π_S + 0.3 π_C + 0.2 π_R = 0,
    0.3 π_S - 0.6 π_C + 0.3 π_R = 0,
    0.1 π_S + 0.3 π_C - 0.5 π_R = 0,
    π_S + π_C + π_R = 1
  )
$

From equation 1:
$ 0.3 π_C + 0.2 π_R = 0.4 π_S $
$ π_C = (0.4 π_S - 0.2 π_R)/(0.3) = (4 π_S - 2 π_R)/(3) $

From equation 3:
$ 0.1 π_S + 0.3 π_C = 0.5 π_R $
$ π_C = (0.5 π_R - 0.1 π_S)/(0.3) = (5 π_R - π_S)/(3) $

Setting equal:
$ (4 π_S - 2 π_R)/(3) = (5 π_R - π_S)/(3) $
$ 4 π_S - 2 π_R = 5 π_R - π_S $
$ 5 π_S = 7 π_R $
$ π_R = (5)/(7) π_S $

Substituting back:
$
  π_C = (5 π_R - π_S)/(3) = (5 · (5)/(7) π_S - π_S)/(3) = ((25)/(7) π_S - π_S)/(3) = ((25-7)/(7) π_S)/(3) = (18 π_S)/(21) = (6 π_S)/(7)
$

Using normalization:
$ π_S + π_C + π_R = 1 $
$ π_S + (6)/(7) π_S + (5)/(7) π_S = 1 $
$ π_S (1 + (6)/(7) + (5)/(7)) = 1 $
$ π_S ((7 + 6 + 5)/(7)) = 1 $
$ π_S ((18)/(7)) = 1 $
$ π_S = 7/18 ≈ 0.389 $

Therefore:
$ π_C = (6)/(7) · (7)/(18) = 6/18 = 1/3 ≈ 0.333 $
$ π_R = (5)/(7) · (7)/(18) = 5/18 ≈ 0.278 $

*Verification:*
$ [7/18, 6/18, 5/18] mat(0.6, 0.3, 0.1; 0.3, 0.4, 0.3; 0.2, 0.3, 0.5) $

First element: $(7/18)(0.6) + (6/18)(0.3) + (5/18)(0.2) = 4.2/18 + 1.8/18 + 1.0/18 = 7/18$ ✓

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  [*State*], [*Stationary Prob.*], [*Percentage*], [*Days per Week*],
  [Sunny], [7/18 ≈ 0.389], [38.9%], [≈ 2.7 days],
  [Cloudy], [6/18 ≈ 0.333], [33.3%], [≈ 2.3 days],
  [Rainy], [5/18 ≈ 0.278], [27.8%], [≈ 1.9 days],
)

*Answer:* Long-run proportion of sunny days is $7/18 ≈ 38.9%$

*Part 2: Probability of Rain in 2 Days Starting from Cloudy*

We need $(P^2)_(C R)$ (Cloudy to Rainy entry in 2-step transition matrix).

Computing $P^2$:
$
  P^2 = mat(
    0.6, 0.3, 0.1;
    0.3, 0.4, 0.3;
    0.2, 0.3, 0.5
  ) mat(
    0.6, 0.3, 0.1;
    0.3, 0.4, 0.3;
    0.2, 0.3, 0.5
  )
$

Row 2, Column 3 (Cloudy → Rainy in 2 steps):
$ (P^2)_(C R) = sum_k p_(C k) p_(k R) $
$ = p_(C S) p_(S R) + p_(C C) p_(C R) + p_(C R) p_(R R) $
$ = (0.3)(0.1) + (0.4)(0.3) + (0.3)(0.5) $
$ = 0.03 + 0.12 + 0.15 $
$ = 0.30 $

*Detailed path analysis:*
#table(
  columns: (auto, auto, auto, auto),
  align: center,
  [*Path*], [*Probability*], [*Calculation*], [*Value*],
  [Cloudy → Sunny → Rainy], [$p_(C S) · p_(S R)$], [0.3 × 0.1], [0.03],
  [Cloudy → Cloudy → Rainy], [$p_(C C) · p_(C R)$], [0.4 × 0.3], [0.12],
  [Cloudy → Rainy → Rainy], [$p_(C R) · p_(R R)$], [0.3 × 0.5], [0.15],
  [*Total*], [], [], [*0.30*],
)

*Answer:* Probability of rain in 2 days = 0.30 or 30%

*Part 3: Is This Chain Ergodic?*

A chain is ergodic if it is both irreducible and aperiodic.

*Check Irreducibility:*

Build accessibility matrix to verify all states communicate:

From Sunny: Can reach Cloudy (direct), Rainy (direct) ✓
From Cloudy: Can reach Sunny (direct), Rainy (direct) ✓
From Rainy: Can reach Sunny (direct), Cloudy (direct) ✓

All states are mutually accessible in 1 step → irreducible.

*Check Aperiodicity:*

For each state, check if period = 1:
- Sunny: $p_(S S) = 0.6 > 0$ → can return in 1 step → period = 1 ✓
- Cloudy: $p_(C C) = 0.4 > 0$ → can return in 1 step → period = 1 ✓
- Rainy: $p_(R R) = 0.5 > 0$ → can return in 1 step → period = 1 ✓

All states have self-loops → all states are aperiodic.

*Answer:* Yes, the chain is ergodic (irreducible + aperiodic).

#block(
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  *Summary for Problem 2*

  #table(
    columns: (auto, auto),
    align: (left, left),
    [*Property*], [*Result*],
    [Stationary Distribution], [$π = [7/18, 6/18, 5/18]$],
    [Long-run Sunny Days], [38.9%],
    [P(Rain in 2 days | Cloudy today)], [0.30 (30%)],
    [Irreducible?], [Yes - all states communicate],
    [Aperiodic?], [Yes - all have self-loops],
    [Ergodic?], [Yes],
  )
]

== Problem 3: Random Walk on a Graph

Consider a random walk on a cycle of length 5 (states 0, 1, 2, 3, 4):
- From state $i$, move to $(i+1) mod 5$ with probability 0.5
- Move to $(i-1) mod 5$ with probability 0.5

*Questions:*
1. Write the transition matrix
2. What is the period of each state?
3. Find the stationary distribution
4. Explain why all states have equal stationary probability

#align(center)[
  #diagram(
    spacing: 2cm,
    node-stroke: 1pt,
    edge-stroke: 1pt,
    node((0, 2), $0$, name: <0>, radius: 0.8cm),
    node((1.9, 0.6), $1$, name: <1>, radius: 0.8cm),
    node((1.2, -1.6), $2$, name: <2>, radius: 0.8cm),
    node((-1.2, -1.6), $3$, name: <3>, radius: 0.8cm),
    node((-1.9, 0.6), $4$, name: <4>, radius: 0.8cm),

    // Clockwise edges (probability 0.5)
    edge(<0>, <1>, "->", label: "0.5", bend: -15deg),
    edge(<1>, <2>, "->", label: "0.5", bend: -15deg),
    edge(<2>, <3>, "->", label: "0.5", bend: -15deg),
    edge(<3>, <4>, "->", label: "0.5", bend: -15deg),
    edge(<4>, <0>, "->", label: "0.5", bend: -15deg),

    // Counter-clockwise edges (probability 0.5)
    edge(<1>, <0>, "->", label: "0.5", bend: -15deg),
    edge(<2>, <1>, "->", label: "0.5", bend: -15deg),
    edge(<3>, <2>, "->", label: "0.5", bend: -15deg),
    edge(<4>, <3>, "->", label: "0.5", bend: -15deg),
    edge(<0>, <4>, "->", label: "0.5", bend: -15deg),
  )
]

=== Solution

*Part 1: Transition Matrix*

The state space is $S = {0, 1, 2, 3, 4}$. From state $i$:
- Move to $(i+1) mod 5$ with probability 0.5
- Move to $(i-1) mod 5$ with probability 0.5

Constructing the matrix row by row:

*State 0:* Can go to 1 (forward) or 4 (backward), each with prob 0.5
*State 1:* Can go to 2 (forward) or 0 (backward), each with prob 0.5
*State 2:* Can go to 3 (forward) or 1 (backward), each with prob 0.5
*State 3:* Can go to 4 (forward) or 2 (backward), each with prob 0.5
*State 4:* Can go to 0 (forward) or 3 (backward), each with prob 0.5

$
  P = mat(
    0, 0.5, 0, 0, 0.5;
    0.5, 0, 0.5, 0, 0;
    0, 0.5, 0, 0.5, 0;
    0, 0, 0.5, 0, 0.5;
    0.5, 0, 0, 0.5, 0
  )
$

*Verification:* Each row sums to 1 ✓

#table(
  columns: 6,
  align: center,
  [], [*To 0*], [*To 1*], [*To 2*], [*To 3*], [*To 4*],
  [*From 0*], [0], [0.5], [0], [0], [0.5],
  [*From 1*], [0.5], [0], [0.5], [0], [0],
  [*From 2*], [0], [0.5], [0], [0.5], [0],
  [*From 3*], [0], [0], [0.5], [0], [0.5],
  [*From 4*], [0.5], [0], [0], [0.5], [0],
)

*Part 2: Period of Each State*

The period of state $i$ is $d(i) = gcd{n ≥ 1 : p_(i i)^((n)) > 0}$.

*Analyzing state 0:*

From the diagram, we can return to state 0 by:
- Taking 2 steps: 0 → 1 → 0 (prob = 0.5 × 0.5 = 0.25)
- Taking 2 steps: 0 → 4 → 0 (prob = 0.5 × 0.5 = 0.25)
- Taking 4 steps: 0 → 1 → 2 → 1 → 0
- Taking 5 steps: 0 → 1 → 2 → 3 → 4 → 0 (full cycle)
- Taking 6 steps: 0 → 1 → 0 → 1 → 0 (three 2-step returns)
- Taking 10 steps: two full cycles

Actually, let's check more carefully:
- *n = 1:* $p_(00)^((1)) = 0$ (can't return in 1 step)
- *n = 2:* $p_(00)^((2)) > 0$ (can go 0→1→0 or 0→4→0)
- *n = 3:* $p_(00)^((3)) = 0$ (odd number of steps won't work on a bipartite graph... wait, this is a cycle of odd length!)

Let me reconsider. With a cycle of length 5 (odd):
- *n = 1:* Cannot return (0 neighbors only)
- *n = 2:* Can return via 2-step paths
- *n = 3:* Can return: 0→1→2→3 won't work... 0→4→3→2 won't work...

Actually, on a cycle of length 5 with symmetric random walk:
- Go clockwise 5 steps: return with some probability
- Go clockwise 2, counterclockwise 3: net displacement 2-3 = -1 (mod 5) = 4
- Any path with net displacement 0 (mod 5) returns to start

Possible return times: any $n$ where we can have equal clockwise/counterclockwise or net 0 mod 5.

Computing $P^2$:
$(P^2)_(00) = sum_k p_(0 k) p_(k 0) = p_(01) p_(10) + p_(04) p_(40) = (0.5)(0.5) + (0.5)(0.5) = 0.5 > 0$

Computing $P^5$ (full cycle):
After 5 steps, definitely can return.

*Key insight:* On an odd cycle with symmetric walk, we can return at steps 2, 3, 4, 5, 6, ...
Since $gcd(2, 3, 4, 5, ...) = 1$, the period is 1.

Let me verify $P^3$:
After 3 steps, possible positions from 0:
- CCC: position 3
- CCB: position 1
- CBC: position 1
- CBB: position 4 (not 0)
- BCC: position 4
- BCB: position 0 ✓
- BBC: position 1
- BBB: position 2

Yes! Path 0→4→3→4→0 has probability $(0.5)^3 = 0.125$, so $p_(00)^((3)) > 0$.

Therefore: $d(0) = gcd(2, 3, 4, 5, ...) = 1$

*Answer:* All states are aperiodic (period = 1) due to odd cycle length.

#table(
  columns: (auto, auto, auto),
  align: center,
  [*State*], [*Possible Return Times*], [*Period*],
  [0], [2, 3, 4, 5, 6, ...], [gcd = 1],
  [1], [2, 3, 4, 5, 6, ...], [gcd = 1],
  [2], [2, 3, 4, 5, 6, ...], [gcd = 1],
  [3], [2, 3, 4, 5, 6, ...], [gcd = 1],
  [4], [2, 3, 4, 5, 6, ...], [gcd = 1],
)

*Note:* On an *even* cycle (e.g., length 4), the period would be 2 (can only return at even times).

*Part 3: Stationary Distribution*

We solve $π P = π$ with $sum_i π_i = 1$.

By symmetry, we expect $π_0 = π_1 = π_2 = π_3 = π_4$.

Let $π_i = c$ for all $i$. Then:
$ sum_(i=0)^4 π_i = 5c = 1 $
$ c = 1/5 $

*Verification:* Check that $π = [1/5, 1/5, 1/5, 1/5, 1/5]$ satisfies $π P = π$.

For state 0:
$ (π P)_0 = sum_i π_i p_(i 0) = π_1 p_(10) + π_4 p_(40) $
$ = (1/5)(0.5) + (1/5)(0.5) = 1/10 + 1/10 = 1/5 = π_0 $ ✓

By symmetry, this holds for all states.

*Answer:* $π = [1/5, 1/5, 1/5, 1/5, 1/5] = [0.2, 0.2, 0.2, 0.2, 0.2]$

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  [*State*], [*Stationary Prob.*], [*Percentage*], [*Expected Return Time*],
  [0], [1/5 = 0.2], [20%], [5 steps],
  [1], [1/5 = 0.2], [20%], [5 steps],
  [2], [1/5 = 0.2], [20%], [5 steps],
  [3], [1/5 = 0.2], [20%], [5 steps],
  [4], [1/5 = 0.2], [20%], [5 steps],
)

*Part 4: Why Equal Stationary Probabilities?*

There are several explanations:

*Explanation 1: Symmetry*

The graph is completely symmetric - every state "looks the same." Each state has exactly 2 neighbors, and the transition probabilities are identical for all states. This structural symmetry implies the stationary distribution must be uniform.

*Explanation 2: Reversibility*

This chain is reversible with uniform distribution. Check detailed balance:
$ π_i p_(i j) = π_j p_(j i) $

For adjacent states (say $i=0, j=1$):
$ π_0 p_(01) = (1/5)(0.5) = 1/10 $
$ π_1 p_(10) = (1/5)(0.5) = 1/10 $ ✓

The probability flow from any state to its neighbor equals the flow back.

*Explanation 3: Doubly Stochastic Matrix*

A matrix is *doubly stochastic* if both rows and columns sum to 1.

Check column sums of $P$:
$ sum_(i=0)^4 p_(i 0) = p_(10) + p_(40) = 0.5 + 0.5 = 1 $ ✓
$ sum_(i=0)^4 p_(i 1) = p_(01) + p_(21) = 0.5 + 0.5 = 1 $ ✓

All column sums equal 1!

*Theorem:* For a doubly stochastic matrix on a finite state space, the uniform distribution is stationary.

*Proof:* If $P$ is doubly stochastic and $π = [1/N, ..., 1/N]$:
$ (π P)_j = sum_i π_i p_(i j) = sum_i (1/N) p_(i j) = (1/N) sum_i p_(i j) = (1/N) · 1 = π_j $ □

*Explanation 4: Random Walk on Regular Graph*

This is a random walk on a 5-regular cycle where each vertex has degree 2. For a random walk on any *regular graph* (all vertices have same degree), the stationary distribution is uniform.

If degree is $d$ for all vertices, then:
$ π_i = d/(sum_j d) = d/(N d) = 1/N $

#block(
  fill: rgb("#e8f4f8"),
  inset: 10pt,
  radius: 4pt,
)[
  *Summary for Problem 3*

  #table(
    columns: (auto, auto),
    align: (left, left),
    [*Property*], [*Result*],
    [State Space], [Cycle of length 5],
    [Transition Matrix], [Doubly stochastic],
    [Irreducible?], [Yes - all states communicate],
    [Period of each state], [1 (aperiodic due to odd cycle)],
    [Stationary Distribution], [Uniform: [0.2, 0.2, 0.2, 0.2, 0.2]],
    [Reason for uniformity], [Symmetry / Doubly stochastic / Regular graph],
    [Expected return time], [5 steps for all states],
  )
]

#pagebreak()

== Problem 4: Absorbing Chain

A particle performs a random walk on {0, 1, 2, 3, 4} where:
- States 0 and 4 are absorbing
- From state 1: move to 0 with prob. 0.3, to 2 with prob. 0.7
- From state 2: move to 1, 3 each with prob. 0.5
- From state 3: move to 2 with prob. 0.6, to 4 with prob. 0.4

*Questions:*
1. Write the transition matrix in canonical form
2. Compute the fundamental matrix $N$
3. What's the probability of absorption at 0 starting from state 2?
4. Expected time to absorption from state 2?

#align(center)[
  #diagram(
    spacing: 1.6cm,
    node-stroke: 1pt,
    edge-stroke: 1pt,
    node((0, 0), [*0*\ Absorb], name: <0>, radius: 0.7cm, fill: rgb("#ffcccc")),
    node((1.8, 0), $1$, name: <1>, radius: 0.6cm),
    node((3.4, 0), $2$, name: <2>, radius: 0.6cm),
    node((5.0, 0), $3$, name: <3>, radius: 0.6cm),
    node((6.8, 0), [*4*\ Absorb], name: <4>, radius: 0.7cm, fill: rgb("#ccffcc")),

    edge(<1>, <0>, "->", label: "0.3", bend: 20deg),
    edge(<1>, <2>, "->", label: "0.7", bend: 20deg),
    edge(<2>, <1>, "->", label: "0.5", bend: 20deg),
    edge(<2>, <3>, "->", label: "0.5", bend: 20deg),
    edge(<3>, <2>, "->", label: "0.6", bend: 20deg),
    edge(<3>, <4>, "->", label: "0.4", bend: 20deg),
    edge(<0>, <0>, "->", label: "1", bend: 130deg, loop-angle: 180deg),
    edge(<4>, <4>, "->", label: "1", bend: -130deg, loop-angle: 0deg),
  )
]

=== Solution

*Part 1: Transition Matrix in Canonical Form*

*Standard form:* List transient states first (1, 2, 3), then absorbing states (0, 4).

State ordering: $1, 2, 3, 0, 4$

Transition matrix:
$
  P = mat(
    0, 0.7, 0, 0.3, 0;
    0.5, 0, 0.5, 0, 0;
    0, 0.6, 0, 0, 0.4;
    0, 0, 0, 1, 0;
    0, 0, 0, 0, 1
  )
$

*Canonical form:* $P = mat(Q, R; 0, I)$

where:
- $Q$ = transitions between transient states (3×3)
- $R$ = transitions from transient to absorbing states (3×2)
- $0$ = zero matrix (2×3)
- $I$ = identity matrix for absorbing states (2×2)

$
  Q = mat(
    0, 0.7, 0;
    0.5, 0, 0.5;
    0, 0.6, 0
  ) quad R = mat(
    0.3, 0;
    0, 0;
    0, 0.4
  )
$

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  align: center,
  [], [*To 1*], [*To 2*], [*To 3*], [*To 0*], [*To 4*],
  [*From 1*], [0], [0.7], [0], [0.3], [0],
  [*From 2*], [0.5], [0], [0.5], [0], [0],
  [*From 3*], [0], [0.6], [0], [0], [0.4],
  [--- $Q$ above ---], [--- $R$ above ---], [], [], [], [*From 0*],
  [0], [0], [0], [1], [0], [*From 4*],
  [0], [0], [0], [0], [1],
)

*Part 2: Fundamental Matrix $N$*

The fundamental matrix is:
$ N = (I - Q)^(-1) $

First, compute $I - Q$:
$
  I - Q = mat(1, 0, 0; 0, 1, 0; 0, 0, 1) - mat(0, 0.7, 0; 0.5, 0, 0.5; 0, 0.6, 0) = mat(1, -0.7, 0; -0.5, 1, -0.5; 0, -0.6, 1)
$

To find $(I - Q)^(-1)$, we use the formula for 3×3 matrix inverse or solve $(I-Q)N = I$.

*Method: Solve system of equations*

Let $N = mat(n_(11), n_(12), n_(13); n_(21), n_(22), n_(23); n_(31), n_(32), n_(33))$

From $(I-Q)N = I$:

$
  mat(1, -0.7, 0; -0.5, 1, -0.5; 0, -0.6, 1) mat(n_(11), n_(12), n_(13); n_(21), n_(22), n_(23); n_(31), n_(32), n_(33)) = mat(1, 0, 0; 0, 1, 0; 0, 0, 1)
$

*Column 1 equations:*
$
  cases(
    n_(11) - 0.7 n_(21) = 1,
    -0.5 n_(11) + n_(21) - 0.5 n_(31) = 0,
    -0.6 n_(21) + n_(31) = 0
  )
$

From equation 3: $n_(31) = 0.6 n_(21)$

Substitute into equation 2:
$ -0.5 n_(11) + n_(21) - 0.5(0.6 n_(21)) = 0 $
$ -0.5 n_(11) + n_(21) - 0.3 n_(21) = 0 $
$ -0.5 n_(11) + 0.7 n_(21) = 0 $
$ n_(21) = (0.5)/(0.7) n_(11) = (5)/(7) n_(11) $

Substitute into equation 1:
$ n_(11) - 0.7 · (5)/(7) n_(11) = 1 $
$ n_(11) - 0.5 n_(11) = 1 $
$ 0.5 n_(11) = 1 $
$ n_(11) = 2 $

Therefore:
$ n_(21) = (5)/(7) · 2 = 10/7 ≈ 1.429 $
$ n_(31) = 0.6 · 10/7 = 6/7 ≈ 0.857 $

*Column 2 equations:*
$
  cases(
    n_(12) - 0.7 n_(22) = 0,
    -0.5 n_(12) + n_(22) - 0.5 n_(32) = 1,
    -0.6 n_(22) + n_(32) = 0
  )
$

From equation 3: $n_(32) = 0.6 n_(22)$
From equation 1: $n_(12) = 0.7 n_(22)$

Substitute into equation 2:
$ -0.5(0.7 n_(22)) + n_(22) - 0.5(0.6 n_(22)) = 1 $
$ -0.35 n_(22) + n_(22) - 0.3 n_(22) = 1 $
$ 0.35 n_(22) = 1 $
$ n_(22) = 1/0.35 = 20/7 ≈ 2.857 $

Therefore:
$ n_(12) = 0.7 · 20/7 = 2 $
$ n_(32) = 0.6 · 20/7 = 12/7 ≈ 1.714 $

*Column 3 equations:*
$
  cases(
    n_(13) - 0.7 n_(23) = 0,
    -0.5 n_(13) + n_(23) - 0.5 n_(33) = 0,
    -0.6 n_(23) + n_(33) = 1
  )
$

From equation 1: $n_(13) = 0.7 n_(23)$

Substitute into equation 2:
$ -0.5(0.7 n_(23)) + n_(23) - 0.5 n_(33) = 0 $
$ -0.35 n_(23) + n_(23) - 0.5 n_(33) = 0 $
$ 0.65 n_(23) = 0.5 n_(33) $
$ n_(23) = (0.5)/(0.65) n_(33) = (10)/(13) n_(33) $

Substitute into equation 3:
$ -0.6 · (10)/(13) n_(33) + n_(33) = 1 $
$ -(6)/(13) n_(33) + n_(33) = 1 $
$ (7)/(13) n_(33) = 1 $
$ n_(33) = 13/7 ≈ 1.857 $

Therefore:
$ n_(23) = (10)/(13) · 13/7 = 10/7 ≈ 1.429 $
$ n_(13) = 0.7 · 10/7 = 1 $

*Fundamental Matrix:*
$
  N = mat(
    2, 2, 1;
    10/7, 20/7, 10/7;
    6/7, 12/7, 13/7
  ) ≈ mat(
    2.000, 2.000, 1.000;
    1.429, 2.857, 1.429;
    0.857, 1.714, 1.857
  )
$

*Interpretation of $N$:*
- $N_(i j)$ = expected number of times in transient state $j$ starting from transient state $i$
- Example: $N_(21) = 10/7 ≈ 1.43$ means starting from state 2, we expect to visit state 1 about 1.43 times before absorption

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  [*Start State*], [*Visits to 1*], [*Visits to 2*], [*Visits to 3*],
  [1], [2.000], [2.000], [1.000],
  [2], [1.429], [2.857], [1.429],
  [3], [0.857], [1.714], [1.857],
)

*Part 3: Probability of Absorption at State 0 from State 2*

The absorption probability matrix is:
$ B = N R $

$ B = mat(2, 2, 1; 10/7, 20/7, 10/7; 6/7, 12/7, 13/7) mat(0.3, 0; 0, 0; 0, 0.4) $

Computing $B$:

Row 2, Column 1 (start at 2, absorb at 0):
$ B_(21) = n_(21) · r_(10) + n_(22) · r_(20) + n_(23) · r_(30) $
$ = (10/7)(0.3) + (20/7)(0) + (10/7)(0) $
$ = 3/7 ≈ 0.429 $

Row 2, Column 2 (start at 2, absorb at 4):
$ B_(22) = n_(21) · r_(14) + n_(22) · r_(24) + n_(23) · r_(34) $
$ = (10/7)(0) + (20/7)(0) + (10/7)(0.4) $
$ = 4/7 ≈ 0.571 $

*Answer:* Probability of absorption at state 0 starting from state 2 = $3/7 ≈ 0.429$ or 42.9%

*Complete absorption probability matrix:*
$
  B = mat(
    0.6, 0.4;
    3/7, 4/7;
    2/7, 5/7
  ) ≈ mat(
    0.600, 0.400;
    0.429, 0.571;
    0.286, 0.714
  )
$

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  [*Start State*], [*P(Absorb at 0)*], [*P(Absorb at 4)*], [*Verification*],
  [1], [0.600 (60%)], [0.400 (40%)], [Sum = 1.0 ✓],
  [2], [0.429 (42.9%)], [0.571 (57.1%)], [Sum = 1.0 ✓],
  [3], [0.286 (28.6%)], [0.714 (71.4%)], [Sum = 1.0 ✓],
)

*Intuition:* State 2 is equidistant from both absorbing states, but there's a slight bias toward state 4 due to the transition probabilities.

*Part 4: Expected Time to Absorption from State 2*

The expected time to absorption vector is:
$ t = N bold(1) $

where $bold(1) = mat(1; 1; 1)$ is a column vector of ones.

$ t = mat(2, 2, 1; 10/7, 20/7, 10/7; 6/7, 12/7, 13/7) mat(1; 1; 1) $

For state 2 (row 2):
$ t_2 = n_(21) · 1 + n_(22) · 1 + n_(23) · 1 $
$ = 10/7 + 20/7 + 10/7 $
$ = 40/7 ≈ 5.714 "steps" $

*Answer:* Expected time to absorption from state 2 = $40/7 ≈ 5.71$ steps

*Complete expected absorption times:*
$
  t = mat(
    2 + 2 + 1;
    10/7 + 20/7 + 10/7;
    6/7 + 12/7 + 13/7
  ) = mat(
    5;
    40/7;
    31/7
  ) ≈ mat(
    5.000;
    5.714;
    4.429
  )
$

#table(
  columns: (auto, auto, auto),
  align: center,
  [*Start State*], [*Expected Steps to Absorption*], [*Interpretation*],
  [1], [5.000], [Farthest from absorbing states],
  [2], [5.714], [Central position, most visits],
  [3], [4.429], [Closer to state 4],
)

*Verification through simulation reasoning:*
Starting from state 2:
- Visit state 2 itself 2.857 times (including start)
- Visit state 1 about 1.429 times
- Visit state 3 about 1.429 times
- Total visits: 2.857 + 1.429 + 1.429 = 5.715 ≈ 40/7 ✓

#block(
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 4pt,
)[
  *Summary for Problem 4*

  #table(
    columns: (auto, auto),
    align: (left, left),
    [*Property*], [*Result*],
    [Transient States], [1, 2, 3],
    [Absorbing States], [0, 4],
    [Fundamental Matrix $N$], [$mat(2, 2, 1; 10/7, 20/7, 10/7; 6/7, 12/7, 13/7)$],
    [P(Absorb at 0 | Start at 2)], [3/7 ≈ 0.429 (42.9%)],
    [P(Absorb at 4 | Start at 2)], [4/7 ≈ 0.571 (57.1%)],
    [Expected absorption time from 2], [40/7 ≈ 5.71 steps],
    [Most likely outcome from 2], [Absorption at state 4],
  )
]

== Problem 5: Birth-Death Process

A population follows a birth-death process with:
- Birth rate: $λ_n = λ n$ (proportional to population)
- Death rate: $μ_n = μ n$ (proportional to population)

*Questions:*
1. Write the transition rate matrix $Q$
2. Find the stationary distribution (if it exists)
3. Under what conditions is the process stable?

#align(center)[
  #diagram(
    spacing: 1.8cm,
    node-stroke: 1pt,
    node((0, 0), $0$, name: <0>, radius: 0.5cm),
    node((1.8, 0), $1$, name: <1>, radius: 0.5cm),
    node((3.6, 0), $2$, name: <2>, radius: 0.5cm),
    node((5.4, 0), $3$, name: <3>, radius: 0.5cm),
    node((7.2, 0), $...$, name: <dots>, shape: "rect", stroke: none),

    edge(<0>, <1>, "->", label: $λ · 0$, bend: -20deg),
    edge(<1>, <0>, "->", label: $μ · 1$, bend: -20deg),
    edge(<1>, <2>, "->", label: $λ · 1$, bend: -20deg),
    edge(<2>, <1>, "->", label: $μ · 2$, bend: -20deg),
    edge(<2>, <3>, "->", label: $λ · 2$, bend: -20deg),
    edge(<3>, <2>, "->", label: $μ · 3$, bend: -20deg),
    edge(<3>, <dots>, "->", label: $λ · 3$, bend: -20deg),
  )
]

=== Solution

*Part 1: Transition Rate Matrix $Q$*

For a continuous-time Markov chain, the transition rate matrix $Q$ has entries:
- $q_(i j) =$ rate of transition from state $i$ to state $j$ (for $i ≠ j$)
- $q_(i i) = -sum_(j ≠ i) q_(i j)$ (row sums to zero)

For the birth-death process:
- From state $n$: birth to $n+1$ at rate $λ_n = λ n$
- From state $n$: death to $n-1$ at rate $μ_n = μ n$

*Special case: State 0*
When population is 0, no births or deaths occur (extinction):
- $λ_0 = λ · 0 = 0$ (no births from empty population)
- $μ_0 = μ · 0 = 0$ (no deaths from empty population)
- State 0 is absorbing in this model!

For $n ≥ 1$:
- $q_(n, n+1) = λ n$ (birth rate)
- $q_(n, n-1) = μ n$ (death rate)
- $q_(n n) = -(λ n + μ n)$ (total exit rate)

*Transition rate matrix (infinite):*
$
  Q = mat(
    0, 0, 0, 0, 0, ...;
    μ, -(λ+μ), λ, 0, 0, ...;
    0, 2μ, -2(λ+μ), 2λ, 0, ...;
    0, 0, 3μ, -3(λ+μ), 3λ, ...;
    dots.v, dots.v, dots.v, dots.v, dots.v, dots.down
  )
$

*Finite-state approximation (truncate at $N$):*

For states $0, 1, 2, ..., N$ (assuming no population above $N$):

$
  Q = mat(
    0, 0, 0, 0, ...;
    μ, -(λ+μ), λ, 0, ...;
    0, 2μ, -2(λ+μ), 2λ, ...;
    dots.v, dots.v, dots.v, dots.v, dots.down;
    0, ..., 0, N μ, -N μ
  )
$

#table(
  columns: (auto, auto, auto, auto, auto),
  align: center,
  [*State $n$*], [*Birth Rate*], [*Death Rate*], [*Exit Rate*], [*Net Rate*],
  [0], [0], [0], [0], [0 (absorbing)],
  [1], [$λ$], [$μ$], [$λ + μ$], [$λ - μ$],
  [2], [$2λ$], [$2μ$], [$2(λ + μ)$], [$2(λ - μ)$],
  [3], [$3λ$], [$3μ$], [$3(λ + μ)$], [$3(λ - μ)$],
  [$n$], [$n λ$], [$n μ$], [$n(λ + μ)$], [$n(λ - μ)$],
)

*Part 2: Stationary Distribution*

For a continuous-time Markov chain, the stationary distribution $π$ satisfies:
$ π Q = 0 quad "and" quad sum_i π_i = 1 $

*Detailed balance equations:*

For a birth-death process, detailed balance means:
$ π_n · q_(n, n+1) = π_(n+1) · q_(n+1, n) $

This gives:
$ π_n · (λ n) = π_(n+1) · (μ(n+1)) $
$ π_(n+1) = (λ n)/(μ(n+1)) π_n $

*Recursive solution:*

Starting from $π_0$:
$ π_1 = (λ · 0)/(μ · 1) π_0 = 0 $

Since $λ_0 = 0$, we have $π_1 = 0$, which implies $π_n = 0$ for all $n ≥ 1$.

This means the only stationary distribution is $π = [1, 0, 0, ...]$ (all probability on state 0).

*Interpretation:* State 0 is absorbing! Once the population reaches 0, it stays there forever. Eventually, the population goes extinct with probability 1.

*Answer:* The stationary distribution is $π_0 = 1, π_n = 0$ for $n ≥ 1$ (extinction is certain).

*Modified Model: Constant Immigration*

To avoid extinction, modify the model with constant immigration:
- Birth rate: $λ_n = λ n + α$ (births + immigration)
- Death rate: $μ_n = μ n$

Now $λ_0 = α > 0$, so state 0 is not absorbing.

For this model, detailed balance gives:
$ π_n (λ n + α) = π_(n+1) μ(n+1) $

$ π_(n+1) = (λ n + α)/(μ(n+1)) π_n $

This is more complex, but for $λ < μ$, a proper stationary distribution exists.

*Part 3: Stability Conditions*

*Case 1: Original Model (No Immigration)*

The process is NOT stable in the traditional sense:
- State 0 is absorbing
- For any initial state $n > 0$, the population will eventually reach 0 with probability 1
- Time to extinction depends on $λ/μ$ ratio

*Mean time to extinction from state $n$:*

Let $T_n$ = expected time to reach 0 starting from $n$.

From the differential equations:
$ T_n = 1/(n μ) + (λ)/(λ + μ) T_(n+1) + (μ)/(λ + μ) T_(n-1) $

For $λ < μ$ (deaths exceed births):
$ T_n ≈ (1)/(n(μ - λ)) quad "for large" n $

Extinction is faster when $μ >> λ$.

For $λ > μ$ (births exceed deaths):
$ T_n ≈ exp(n (λ - μ)/(μ)) $

Extinction takes exponentially long! But still happens eventually.

For $λ = μ$ (balanced):
$ T_n ≈ n^2/(2μ) $

*Case 2: With Constant Immigration ($λ_0 = α > 0$)*

The process is stable if $λ < μ$:
- *Stable ($λ < μ$):* Unique stationary distribution exists
  $ π_n ∝ ((λ)/(μ))^n · product_(k=0)^(n-1) (λ k + α)/(μ(k+1)) $

- *Critical ($λ = μ$):* Null recurrent or transient depending on $α$

- *Unstable ($λ > μ$):* Population grows to infinity
  $ E[X(t)] → ∞ quad "as" t → ∞ $

*Stability condition summary:*

#table(
  columns: (auto, auto, auto),
  align: center,
  [*Condition*], [*Long-term Behavior*], [*Stationary Distribution*],
  [$λ < μ$], [Population decreases to 0], [Extinction (if no immigration)],
  [$λ = μ$], [Random walk (neutral)], [Extinction (slower)],
  [$λ > μ$], [Population grows before extinction], [Extinction (very slow)],
  [With immigration, $λ < μ$], [Stable equilibrium], [Proper distribution exists],
  [With immigration, $λ ≥ μ$], [Unbounded growth], [No stationary distribution],
)

*Answer:*
1. Original model: Always reaches extinction (state 0 absorbing)
2. With immigration: Stable if and only if $λ < μ$ (death rate exceeds birth rate)

#block(
  fill: rgb("#e8f4f8"),
  inset: 10pt,
  radius: 4pt,
)[
  *Summary for Problem 5*

  #table(
    columns: (auto, auto),
    align: (left, left),
    [*Property*], [*Result*],
    [Type], [Continuous-time birth-death process],
    [Birth rate from $n$], [$λ_n = λ n$],
    [Death rate from $n$], [$μ_n = μ n$],
    [State 0], [Absorbing (no births/deaths)],
    [Stationary distribution], [$π_0 = 1$, all others = 0],
    [Long-term outcome], [Extinction certain],
    [Stability condition (with immigration)], [$λ < μ$ (deaths > births)],
    [Key insight], [Without external input, populations die out],
  )
]

*Real-World Example: Population Dynamics*

Consider a species with:
- Birth rate proportional to population: $λ n$
- Death rate proportional to population: $μ n$
- $λ = 0.8$ births per individual per year
- $μ = 1.0$ deaths per individual per year

Since $λ < μ$, population declines. Starting with 100 individuals:
- Expected time to extinction ≈ $1/(100(1.0-0.8)) = 1/20 = 0.05$ years ≈ 18 days

This model explains why isolated populations without immigration eventually go extinct!

#pagebreak()

= Summary and Key Takeaways

== Essential Concepts

#table(
  columns: (auto, 1fr),
  align: (left, left),
  [*Concept*], [*Key Point*],
  [Markov Property], [Future depends only on present, not past],
  [Transition Matrix], [Stochastic matrix with rows summing to 1],
  [Stationary Distribution], [Satisfies $π P = π$; long-run behavior],
  [Irreducibility], [All states communicate],
  [Aperiodicity], [No cyclic behavior (period = 1)],
  [Ergodicity], [Aperiodic + positive recurrent],
  [Absorbing State], [$p_(i i) = 1$; can't escape],
)

== Important Theorems

#block(
  fill: rgb("#e8f4f8"),
  inset: 10pt,
  radius: 4pt,
)[
  1. *Ergodic Theorem:* For irreducible, aperiodic chains:
    $ lim_(n→∞) p_(i j)^((n)) = π_j $

  2. *Fundamental Theorem:* Finite, irreducible, aperiodic chains have unique stationary distribution

  3. *Detailed Balance:* Reversible chains satisfy $π_i p_(i j) = π_j p_(j i)$

  4. *Chapman-Kolmogorov:* $p_(i j)^((n+m)) = sum_k p_(i k)^((n)) p_(k j)^((m))$
]

#pagebreak()

== Common Pitfalls to Avoid

1. *Confusing rows and columns* in transition matrices
  - Remember: rows represent current state, columns represent next state
  - Row sums must equal 1

2. *Assuming all chains have stationary distributions*
  - Reducible chains may not have unique stationary distribution
  - Null recurrent chains don't have stationary distribution

3. *Forgetting initial distribution*
  - $P^n$ gives transition probabilities, not state distribution
  - State distribution: $π^((n)) = π^((0)) P^n$

4. *Misidentifying periodicity*
  - Self-loops guarantee aperiodicity
  - Check $gcd$ of return times, not just presence of cycles

== Study Tips

1. *Practice with examples:* Work through the problems systematically
2. *Visualize with diagrams:* Draw state transition diagrams
3. *Use software:* Implement algorithms in Python/R
4. *Connect to applications:* Understand real-world context
5. *Master fundamentals:* Linear algebra (eigenvalues, matrix powers)

#pagebreak()

= References and Further Reading

== Textbooks

1. *Norris, J.R.* (1997). _Markov Chains_. Cambridge University Press.
  - Comprehensive theoretical treatment
  - Graduate level

2. *Grinstead, C.M. & Snell, J.L.* (2012). _Introduction to Probability_.
  - Free online textbook
  - Accessible introduction with exercises

3. *Ross, S.M.* (2014). _Introduction to Probability Models_ (11th ed.). Academic Press.
  - Excellent for applications
  - Clear explanations

4. *Kemeny, J.G. & Snell, J.L.* (1976). _Finite Markov Chains_. Springer.
  - Classic reference
  - Focus on finite chains

== Online Resources

- MIT OpenCourseWare: Stochastic Processes
- Stanford CS109: Probability for Computer Scientists
- Brilliant.org: Interactive Markov Chain tutorials
- Wikipedia: Comprehensive reference with examples

== Research Papers

1. Markov, A.A. (1906). "Extension of the limit theorems of probability theory to a sum of variables connected in a chain"
  - Original paper introducing Markov chains

2. Page, L. et al. (1999). "The PageRank Citation Ranking: Bringing Order to the Web"
  - Application to web search

== Software Packages

- *Python:* NumPy, SciPy, PyMC3, hmmlearn
- *R:* markovchain, msm, depmixS4
- *MATLAB:* Statistics and Machine Learning Toolbox

#pagebreak()

= Appendix: Mathematical Notation

#table(
  columns: (auto, 1fr),
  align: (center, left),
  [*Symbol*], [*Meaning*],
  [$X_n$], [State at time $n$],
  [$S$], [State space],
  [$p_(i j)$], [Transition probability from $i$ to $j$],
  [$P$], [Transition matrix],
  [$p_(i j)^((n))$], [$n$-step transition probability],
  [$π$], [Stationary distribution],
  [$π_i$], [Stationary probability of state $i$],
  [$f_(i j)$], [Probability of ever reaching $j$ from $i$],
  [$T_i$], [First return time to state $i$],
  [$d(i)$], [Period of state $i$],
  [$Q$], [Transition rate matrix (CTMC)],
  [$q_(i j)$], [Transition rate from $i$ to $j$],
  [$N$], [Fundamental matrix (absorbing chains)],
  [$I$], [Identity matrix],
  [$𝟙$], [Vector of ones],
)

#v(2em)

#align(center)[
  #line(length: 100%, stroke: 2pt)
  #v(1em)
  #text(size: 14pt, weight: "bold")[End of Study Material]
  #v(0.5em)
  #text(size: 11pt, style: "italic")[
    "The future is independent of the past, given the present." \
    — The Markov Property
  ]
]
