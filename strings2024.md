% String Processing
% Jill-Jênn Vie; Halim book
% October 18, 2024
---
aspectratio: 169
biblio-style: authoryear
biblatexoptions: natbib
header-includes:
  - \def\R{\mathbf{R}}
---
# Rabin-Karp: hashing

Looking for $s$ in $t$

## Idea

Comparing an updated rolling hash of every substring of t of size $|s|$ with the hash of s.

$$ \textnormal{hash}(x) = \sum_i x[i] A^i \pmod P $$

## Applications

- Pattern matching
- Lexicographical smallest rotation of a string

# 

\scriptsize

```cpp
vector<H> getHashes(string& str, int length) {
        if (sz(str) < length) return {};
        H h = 0, pw = 1;
        rep(i,0,length)
                h = h * C + str[i], pw = pw * C;
        vector<H> ret = {h};
        rep(i,length,sz(str)) {
                ret.push_back(h = h * C + str[i] - pw * str[i-length]);
        }
        return ret;
}

struct HashInterval {
        vector<H> ha, pw;
        HashInterval(string& str) : ha(sz(str)+1), pw(ha) {
                pw[0] = 1;
                rep(i,0,sz(str))
                        ha[i+1] = ha[i] * C + str[i],
                        pw[i+1] = pw[i] * C;
        }
        H hashInterval(int a, int b) { // hash [a, b)                                                                                                                                                       
                return ha[b] - ha[a] * pw[b - a];
        }
};
```

# 2D pattern matching: SWERC 2014's J: The Big Painting

\centering

![](figures/big-painting.png){height=5cm}

\raggedright

<https://open.kattis.com/problems/bigpainting>

# Suffixes \hfill Suffix Trie \hfill Suffix Tree

![](figures/suffixtree.png)

String matching / longest repeated substring / longest common substring of multiple strings

# String matching

A in GATAGACA

![](figures/st-string-matching.png)

# Longest repeated substring

GATAGACA: it is GA

![](figures/st-longest-repeated.png)

# Longest common substring

GATAGACA and CATA: it is ATA

![](figures/st-longest-common.png)

# Suffix array

\centering

![](figures/suffixarray.png){width=70%}

\raggedright

Naive in $O(n^2 \log n)$, divide in conquer best in practice $O(n \log n)$, best in theory $O(n)$

# Suffix tree vs. suffix array

![](figures/st-suffixarray.png)

Longest common prefix of any two suffixes

# String applications

![](figures/string-applications-st.png)

# Knuth-Morris-Pratt

Let $s$ a string of length $n$

## Prefix function

Array $p$ such that $p[i]$ is the length of the longest proper prefix of $s[0..i]$ which is also a suffix of $s[0..i]$. 

## Idea

Build $p$ in $O(n)$ by dyn prog

## Applications

- String matching
- Know biggest $p$ such that $s = z^p$
- Find all palindrome prefixes
- Given $u, v$, find whether $\exists x, y, u = xy, v = yx$ 

# Looking for a set of patterns $S$

## Generalization

But now, how to find \alert{all} occurrences of a set of patterns in a string?

# Aho-Corasick

Look for all occurrences of a, ab, bc, bca, c, caa (white nodes)

:::::: {.columns}
::: {.column width=30%}
![](figures/aho-corasick.png)

Blue arrows: suffix links  
Green arrows: terminal
:::
::: {.column width=70%}
## Complexity

If $\sum$ strings is $m$, nb vertices $n$, alphabet size $k$

- $O(mk)$ thanks to dyn prog
- Can be sped up $O(n \log k)$ with a segment tree

## Note

- Generalization of KMP for several strings
- Notebook implementation is exactly cp-algorithms (wtf 445 pages of Stanford slides)
:::
::::::

# 

\centering

![](figures/aho-corasick-a3nm.png)

# Problems using Aho-Corasick

- Find all strings from a given set in a text
- Finding the lexicographical smallest string of a given length that doesn't match any given strings
- Finding the shortest string containing all given strings
- Finding the lexicographical smallest string of length $L$ containing $k$ strings

# Context-free grammar

![](figures/cf-grammar.png)

# Recognizing a context-free grammar in Chomsky normal form

:::::: {.columns}
::: {.column}
![](figures/grammar.png)
:::
::: {.column}
![](figures/cyk.gif){width=90%}

## Complexity of CYK algorithm

$O(n^3 |G|)$ for string of length $n$ and grammar of size $|G|$
:::
::::::

# String applications

![](figures/string-applications.png)
