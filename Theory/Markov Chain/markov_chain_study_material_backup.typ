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
  #align(center)[
    #text(size: 12pt)[
      *Simple Two-State Markov Chain*

      #v(1em)

      ```
      State A ----0.7---→ State B
         ↑                  |
         |                  |
         └------0.6---------┘

      Self-loops: A→A (0.3), B→B (0.4)
      ```
    ]
    #v(0.5em)
    #text(size: 10pt, style: "italic")[Figure: A simple two-state Markov chain]
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
  indent: auto
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

$ P = mat(
  p_(11), p_(12), ..., p_(1N);
  p_(21), p_(22), ..., p_(2N);
  dots.v, dots.v, dots.down, dots.v;
  p_(N1), p_(N2), ..., p_(N N)
) $

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
$ P = mat(
  0.7, 0.3;
  0.5, 0.5
) $

=== Computing Future Probabilities

If today is sunny, what's the probability it will be sunny in 2 days?

$ P^2 = mat(0.7, 0.3; 0.5, 0.5) mat(0.7, 0.3; 0.5, 0.5) = mat(0.64, 0.36; 0.60, 0.40) $

The probability is $p_("SS")^((2)) = 0.64 = 64%$.

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
$ P = mat(
  1, 0, 0, 0, 0;
  0.5, 0, 0.5, 0, 0;
  0, 0.5, 0, 0.5, 0;
  0, 0, 0.5, 0, 0.5;
  0, 0, 0, 0, 1
) $

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
  $ lim_(n→∞) P^n = mat(
    π_1, π_2, ..., π_N;
    π_1, π_2, ..., π_N;
    dots.v, dots.v, dots.down, dots.v;
    π_1, π_2, ..., π_N
  ) $
]

== Computing Stationary Distributions

*Method 1: Solve the Linear System*

Solve $π P = π$ subject to $sum_i π_i = 1$:

$ cases(
  π_1 p_(11) + π_2 p_(21) + ... + π_N p_(N 1) = π_1,
  π_1 p_(12) + π_2 p_(22) + ... + π_N p_(N 2) = π_2,
  dots.v,
  π_1 + π_2 + ... + π_N = 1
) $

*Method 2: Matrix Approach*

Solve $(P^T - I)π^T = 0$ with the constraint $sum_i π_i = 1$.

#pagebreak()

=== Example: Weather Model

For our weather example:
$ P = mat(0.7, 0.3; 0.5, 0.5) $

Solve $π P = π$:
$ [π_S, π_R] mat(0.7, 0.3; 0.5, 0.5) = [π_S, π_R] $

This gives:
$ cases(
  0.7 π_S + 0.5 π_R = π_S,
  0.3 π_S + 0.5 π_R = π_R,
  π_S + π_R = 1
) $

Solving: $π_S = 5/8 = 0.625$ and $π_R = 3/8 = 0.375$.

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

$ P = mat(
  Q, R;
  0, I
) $

where:
- $Q$: transition probabilities between transient states
- $R$: transition probabilities from transient to absorbing states
- $I$: identity matrix (absorbing states stay put)
- $0$: zero matrix (can't leave absorbing states)

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

A gambler starts with $k$ dollars and plays until reaching $0$ (broke) or $N$ (wins). Each game, win $1 with probability $p$, lose $1 with probability $q = 1-p$.

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

*Solution (for $p = q = 1\/2$):*
- Probability of ruin from $k$: $(N-k)/N$
- Expected game duration from $k$: $k(N-k)$

#pagebreak()

= Continuous-Time Markov Chains

== Definition

A *continuous-time Markov chain (CTMC)* is a stochastic process ${X(t) : t ≥ 0}$ satisfying:

$ P(X(t+s) = j | X(s) = i, X(u) = x(u), 0 ≤ u < s) = P(X(t+s) = j | X(s) = i) $

== Transition Rate Matrix

The *infinitesimal generator* or *transition rate matrix* $Q$ has entries:

$ q_(i j) = cases(
  lim_(h→0) (p_(i j)(h))/h quad &"if" i ≠ j,
  -sum_(k≠i) q_(i k) quad &"if" i = j
) $

Properties:
- $q_(i j) ≥ 0$ for $i ≠ j$
- Row sums are zero: $sum_(j) q_(i j) = 0$

== Kolmogorov Equations

=== Forward Equation
$ (diff P(t))/(diff t) = P(t) Q $

=== Backward Equation
$ (diff P(t))/(diff t) = Q P(t) $

== Embedded Markov Chain

The *embedded Markov chain* is the discrete-time chain obtained by observing only the states visited (ignoring holding times).

Transition probabilities:
$ s_(i j) = cases(
  q_(i j)/(sum_(k≠i) q_(i k)) quad &"if" i ≠ j,
  0 quad &"if" i = j
) $

#pagebreak()

== Example: Birth-Death Process

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

$ P = mat(
  p_(AA), p_(AC), p_(AG), p_(AT);
  p_(CA), p_(CC), p_(CG), p_(CT);
  p_(GA), p_(GC), p_(GG), p_(GT);
  p_(TA), p_(TC), p_(TG), p_(TT)
) $

*Applications:*
- Gene prediction
- Phylogenetic analysis
- CpG island detection

== Computer Science: PageRank

Google's PageRank models web surfing as a Markov chain:
- States = web pages
- Transitions = following hyperlinks
- Damping factor handles "random jumps"

== Queueing Theory

M/M/1 queue (Markovian arrivals/service, 1 server):
- Arrivals: Poisson process with rate $λ$
- Service times: Exponential with rate $μ$
- State = number of customers in system

Stability condition: $ρ = λ/μ < 1$

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

1. Find the stationary distribution
2. Is this chain irreducible?
3. Is this chain aperiodic?
4. Compute $P^5$
5. Starting from state 1, what's the expected time to return?

== Problem 2: Three-State Weather Model

A weather model has states {Sunny, Cloudy, Rainy} with transition matrix:

$ P = mat(
  0.6, 0.3, 0.1;
  0.3, 0.4, 0.3;
  0.2, 0.3, 0.5
) $

1. Find the long-run proportion of sunny days
2. If today is cloudy, what's the probability of rain in 2 days?
3. Is this chain ergodic?

== Problem 3: Random Walk on a Graph

Consider a random walk on a cycle of length 5 (states 0, 1, 2, 3, 4):
- From state $i$, move to $(i+1) mod 5$ with probability 0.5
- Move to $(i-1) mod 5$ with probability 0.5

1. Write the transition matrix
2. What is the period of each state?
3. Find the stationary distribution
4. Explain why all states have equal stationary probability

#pagebreak()

== Problem 4: Absorbing Chain

A particle performs a random walk on {0, 1, 2, 3, 4} where:
- States 0 and 4 are absorbing
- From state 1: move to 0 with prob. 0.3, to 2 with prob. 0.7
- From state 2: move to 1, 3 each with prob. 0.5
- From state 3: move to 2 with prob. 0.6, to 4 with prob. 0.4

1. Write the transition matrix in canonical form
2. Compute the fundamental matrix $N$
3. What's the probability of absorption at 0 starting from state 2?
4. Expected time to absorption from state 2?

== Problem 5: Birth-Death Process

A population follows a birth-death process with:
- Birth rate: $λ_n = λ n$ (proportional to population)
- Death rate: $μ_n = μ n$ (proportional to population)

1. Write the transition rate matrix $Q$
2. Find the stationary distribution (if it exists)
3. Under what conditions is the process stable?

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
