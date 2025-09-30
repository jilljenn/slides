% Hungarian
% JJV
% 8 novembre 2024
---
aspectratio: 169
colorlinks: true
---
# Reminder

Potential $\ell$ does not need to be positive

Only constraint: $\forall i, j, \ell(i) + \ell(j) \leq W_{ij}$.

# $O(N^4)$ algorithm

Initialize $\ell = 0$

Consider the subgraph of tight edges: $\{(i, j) \mid \ell(i) + \ell(j) = W_{ij}\}$

Search path from unmatched nodes left. $Z$ is set of reachable nodes.

If path reaches unmatched node right: we found a bigger matching $M'$.

Otherwise: path "finishes" on the left. Consider the frontier:

$$\Delta = \min_{\substack{i \in U \cap Z\\j \in V \setminus Z}} \{ W_{ij} - \ell(i) - \ell(j) \}$$

Increase by $\Delta$ on the left, decrease by $\Delta$ on the right. Lemma: current matching $M$ stays tight (so $M$ stays in the subgraph of tight edges)

# Loop invariant

Either:

- $M$ is maximum size: algorithm is over
- subgraph contains an augmenting path
- graph contains a \alert{loose-tailed path}: path from unmatched node left to some node $w_{\textnormal{next}}$ on the right s.t. all edges are tight except the last one.

# Useful lemmas

$$\sum_{i \in U} \ell(i) + \sum_{j \in V} \ell(j) \leq \textnormal{any cost of matching}$$

- Invariant: $\ell$ stays a potential: $\forall i, j, \ell(i) + \ell(j) \leq W_{ij}$
- Adjusting potential leaves $M$ unchanged
- After each potential recalculation, $Z$ grows
- At most $n$ potential recalculations happen before an augmenting path is found (because we discover at most $n$ new nodes on the right).

# Grey areas

- Why a vertex cover is good for $O(N^4)$ algorithm? (TopCoder)
- How to recompute $\Delta$ and next right node $w_{\textnormal{next}}$ in $O(n)$? (Wikipedia, CP Algorithm)

Nice plots: [Codeforces post](https://codeforces.com/blog/entry/128703)

# En fait

Hungarian is implicitly Johnson's algorithm (Dijkstra with reduced costs)
